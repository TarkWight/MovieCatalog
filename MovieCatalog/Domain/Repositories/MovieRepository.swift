//
//  MovieRepository.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

protocol MovieRepository {
    func getMovie(id: UUID) async throws -> Movie
    func getMovieList(page: Page?) async throws -> [Movie]
    
    @discardableResult
    func getFavoriteMovies() async throws -> [Movie]
    func addFavoriteMovie(id: UUID) async throws
    
    func deleteAllMovies() async throws
    func deleteFavoriteMovie(id: UUID) async throws
    
//    func addMovieToIgnoreList(id: UUID) async throws
}
