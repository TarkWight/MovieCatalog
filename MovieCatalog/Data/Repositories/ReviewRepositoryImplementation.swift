//
//  ReviewRepositoryImplementation.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


import Foundation

final class ReviewRepositoryImplementation {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension ReviewRepositoryImplementation: ReviewRepository {
    func deleteReview(reviewId: UUID, movieId: UUID) async throws {
        let config = ReviewNetworkConfig.delete(movieId: movieId, reviewId: reviewId)
        try await networkService.request(with: config, useToken: true)
    }

    func addReview(review: ReviewModify, movieId: UUID) async throws {
        let data = try encodeReviewModify(review)
        let config = ReviewNetworkConfig.add(movieId: movieId, review: data)

        try await networkService.request(with: config, useToken: true)
    }

    func updateReview(review: ReviewModify, reviewId: UUID, movieId: UUID) async throws {
        let data = try encodeReviewModify(review)
        let config = ReviewNetworkConfig.edit(movieId: movieId, reviewId: reviewId, review: data)

        try await networkService.request(with: config, useToken: true)
    }
}

private extension ReviewRepositoryImplementation {
    func encodeReviewModify(_ reviewModify: ReviewModify) throws -> Data {
        let reviewDto = ReviewModifyDTO(
            reviewText: reviewModify.reviewText,
            rating: reviewModify.rating,
            isAnonymous: reviewModify.isAnonymous
        )

        return try networkService.encode(reviewDto)
    }
}
