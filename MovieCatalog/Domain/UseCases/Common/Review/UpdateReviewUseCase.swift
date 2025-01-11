//
//  UpdateReviewUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class UpdateReviewUseCase {

    private let reviewRepository: ReviewRepository

    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }

    func execute(_ review: ReviewModify, reviewId: UUID, movieId: UUID) async throws {
        try await reviewRepository.updateReview(review: review, reviewId: reviewId, movieId: movieId)
    }
}
