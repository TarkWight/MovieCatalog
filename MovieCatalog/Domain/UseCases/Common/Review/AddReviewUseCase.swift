//
//  AddReviewUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class AddReviewUseCase {

    private let reviewRepository: ReviewRepository

    init(reviewRepository: ReviewRepository) {
        self.reviewRepository = reviewRepository
    }

    func execute(review: ReviewModify, movieId: UUID) async throws {
        try await reviewRepository.addReview(review: review, movieId: movieId)
    }
}
