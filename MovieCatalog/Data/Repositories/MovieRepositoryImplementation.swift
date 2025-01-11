//
//  MovieRepositoryImplementation.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class MovieRepositoryImplementation: @unchecked Sendable {

    enum MovieRepositoryError: Error {
        case notFound
        case updateFailed
        case deleteFailed
        case maxPagesReached
    }

    private var loadedMovies = [Movie]()
    private var pagination = Pagination()

    private var isFavoritesLoaded = false
    private var favoriteMovies: [Movie] {
        loadedMovies.filter { $0.isFavorite }
    }

    private let localDataSource: MovieLocalDataSource
    private let remoteDataSource: MovieRemoteDataSource

    init(localDataSource: MovieLocalDataSource, remoteDataSource: MovieRemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

extension MovieRepositoryImplementation: MovieRepository {

    @CoreDataActor
    func deleteAllMovies() async throws {
        loadedMovies = []
        isFavoritesLoaded = false
        await localDataSource.deleteAllMovies()
    }

    @CoreDataActor
    func addFavoriteMovie(id: UUID) async throws {
        do {
            try await remoteDataSource.addFavoriteMovie(movieId: id)
        } catch {
            try await handleUnauthorizedError(error)
        }

        if let movieEntity = await localDataSource.fetchMovie(id: id) {
            movieEntity.isFavorite = true
            await localDataSource.saveMovie(movieEntity)
        }
    }

    @CoreDataActor
    func deleteFavoriteMovie(id: UUID) async throws {
        do {
            try await remoteDataSource.deleteFavoriteMovie(movieId: id)
        } catch {
            try await handleUnauthorizedError(error)
        }

        if let movieEntity = await localDataSource.fetchMovie(id: id) {
            movieEntity.isFavorite = false
            await localDataSource.saveMovie(movieEntity)
        }
    }

    @CoreDataActor
    func getMovie(id: UUID) async throws -> Movie {
        if let localMovieEntity = await localDataSource.fetchMovie(id: id) {
            return localMovieEntity.toDomain()
        }

        let movieDto = try await remoteDataSource.fetchMovie(id: id)
        let movieEntity = MovieEntity(from: movieDto.toDomain(), context: CoreDataManager.shared.viewContext)

        await localDataSource.saveMovie(movieEntity)

        return movieEntity.toDomain()
    }

    @CoreDataActor
    func getFavoriteMovies() async throws -> [Movie] {
        if isFavoritesLoaded {
            return loadedMovies.filter { $0.isFavorite }
        }

        let moviesResponse = try await remoteDataSource.fetchFavoriteMovies()
        let movieShortIds = moviesResponse.movies.map { $0.id }

        return try await withThrowingTaskGroup(of: Movie.self, returning: [Movie].self) { taskGroup in
            var favoriteMovies = [Movie]()

            for id in movieShortIds {
                if let index = loadedMovies.firstIndex(where: { $0.id == id }) {
                    loadedMovies[index].isFavorite = true
                    favoriteMovies.append(loadedMovies[index])

                    if let movieEntity = await localDataSource.fetchMovie(id: id) {
                        movieEntity.isFavorite = true
                        await localDataSource.saveMovie(movieEntity)
                    }
                } else {
                    if let movieEntity = await localDataSource.fetchMovie(id: id) {
                        var movie = movieEntity.toDomain()
                        movie.isFavorite = true
                        favoriteMovies.append(movie)

                        await localDataSource.saveMovie(movieEntity)
                    } else {
                        taskGroup.addTask {
                            let movieDto = try await self.remoteDataSource.fetchMovie(id: id)
                            var movie = movieDto.toDomain()
                            movie.isFavorite = true
                            return movie
                        }
                    }
                }
            }

            for try await movie in taskGroup {
                favoriteMovies.append(movie)
                loadedMovies.append(movie)

                let movieEntity = MovieEntity(from: movie, context: CoreDataManager.shared.viewContext)
                await localDataSource.saveMovie(movieEntity)
            }

            isFavoritesLoaded = true
            return favoriteMovies
        }
    }

    func getMovieList(page: Page?) async throws -> [Movie] {
        guard let page else {
            guard !loadedMovies.isEmpty else { throw NetworkError.requestFailed }
            return loadedMovies.filter { $0.isPaged }
        }

        pagination.page = page
        guard !pagination.isLimitReached else {
            throw MovieRepositoryError.maxPagesReached
        }

        let moviesPagedListDto = try await remoteDataSource.fetchMoviesPagedList(page: pagination.currentPage)
        let movieShorts = moviesPagedListDto.movies

        return try await withThrowingTaskGroup(of: Movie.self, returning: [Movie].self) { taskGroup in
            var movieList = [Movie]()

            for movieShort in movieShorts {
                let id = movieShort.id

                if let movieEntity = await localDataSource.fetchMovie(id: id) {
                    movieList.append(movieEntity.toDomain())
                } else {
                    taskGroup.addTask {
                        let movieDto = try await self.remoteDataSource.fetchMovie(id: id)
                        let movie = movieDto.toDomain()

                        let movieEntity = MovieEntity(from: movie, context: CoreDataManager.shared.viewContext)
                        await self.localDataSource.saveMovie(movieEntity)

                        return movie
                    }
                }
            }

            for try await movie in taskGroup {
                movieList.append(movie)
                loadedMovies.append(movie)
            }

            return movieList
        }
    }
}


private extension MovieRepositoryImplementation {
    func handleUnauthorizedError(_ error: Error) async throws {
        if let authError = error as? AuthError, authError == .unauthorized {
            try await deleteAllMovies()
        }
        throw error
    }
}
