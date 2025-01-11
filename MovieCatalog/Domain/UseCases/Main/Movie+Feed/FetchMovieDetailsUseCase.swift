//
//  FetchMovieDetailsUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

final class FetchMovieDetailsUseCase {

    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute(_ movies: [Movie]) async throws -> [MovieDetails] {
        let userId: UUID?
        do {
            userId = try await profileRepository.getProfile().id
        } catch {
            userId = nil
        }

        return movies.map { makeMovieDetails(for: $0, userId: userId) }
    }
}

private extension FetchMovieDetailsUseCase {

    func makeReviewDetails(for review: Review, isUserReview: Bool) -> ReviewDetails {
        .init(
            id: review.id,
            rating: review.rating,
            reviewText: review.reviewText ?? LocalizedKey.ErrorMessage.noStringAvailable,
            isAnonymous: review.isAnonymous,
            createDateTime: review.createDateTime,
            author: review.author,
            isUserReview: isUserReview
        )
    }

    func makeMovieDetails(for movie: Movie, userId: UUID?) -> MovieDetails {
        let userReview = movie.reviews?.first(where: { $0.author?.userId == userId })

        let reviewDetailsList = movie.reviews?.compactMap { review in
            makeReviewDetails(for: review, isUserReview: review.id == userReview?.id)
        } ?? []

        return .init(
            id: movie.id,
            name: movie.name ?? LocalizedKey.ErrorMessage.noStringAvailable,
            poster: movie.poster,
            year: movie.year,
            country: movie.country ?? LocalizedKey.ErrorMessage.noStringAvailable,
            genres: movie.genres ?? [],
            reviews: reviewDetailsList,
            time: movie.time,
            tagline: movie.tagline ?? LocalizedKey.ErrorMessage.noStringAvailable,
            description: movie.description,
            director: movie.director ?? LocalizedKey.ErrorMessage.noStringAvailable,
            budget: movie.budget,
            fees: movie.fees,
            ageLimit: movie.ageLimit,
            rating: movie.getAverageRating(),
            userRating: userReview?.rating,
            isFavorite: movie.isFavorite
        )
    }
}
