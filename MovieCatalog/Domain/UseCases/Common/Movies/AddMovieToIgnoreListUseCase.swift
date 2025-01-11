//
//  AddMovieToIgnoreListUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class AddMovieToIgnoreListUseCase {

    private let blacklistManager: BlacklistManager

    init(blacklistManager: BlacklistManager) {
        self.blacklistManager = blacklistManager
    }

    func execute(movieId: UUID) async throws {
        await blacklistManager.addToBlacklist(movieId: movieId)
    }
}
