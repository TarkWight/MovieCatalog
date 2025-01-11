//
//  ReviewRepository.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

protocol ReviewRepository {
    func deleteReview(reviewId: UUID, movieId: UUID) async throws
    func addReview(review: ReviewModify, movieId: UUID) async throws
    func updateReview(review: ReviewModify, reviewId: UUID, movieId: UUID) async throws
}
