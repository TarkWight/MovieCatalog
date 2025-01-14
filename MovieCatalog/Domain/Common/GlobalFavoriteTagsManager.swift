//
//  GlobalFavoriteTagsManager.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import Foundation

final class GlobalFavoriteTagsManager {
    static let shared = GlobalFavoriteTagsManager()

    private init() {}

    private var favoriteTagIds: Set<UUID> = []

    func isFavorite(tagId: UUID) -> Bool {
        return favoriteTagIds.contains(tagId)
    }

    func toggleFavorite(tagId: UUID) {
        if favoriteTagIds.contains(tagId) {
            favoriteTagIds.remove(tagId)
        } else {
            favoriteTagIds.insert(tagId)
        }
    }

    func getAllFavorites() -> [UUID] {
        return Array(favoriteTagIds)
    }

    func clearFavorites() {
        favoriteTagIds.removeAll()
    }
}
