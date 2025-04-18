//
//  DeleteReviewUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class DeleteReviewUseCase {

    private let reviewRepository: ReviewRepository

    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }

    func execute(_ reviewId: UUID, movieId: UUID) async throws {
        try await reviewRepository.deleteReview(reviewId: reviewId, movieId: movieId)
    }
}
