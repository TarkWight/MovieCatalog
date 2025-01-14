//
//  GlobalFavoriteTagsManager.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import Foundation

final class GlobalFavoriteTagsManager {
    static let shared = GlobalFavoriteTagsManager()

    private init() {
        loadFromUserDefaults()
    }

    private var favoriteTagIds: Set<UUID> = []

    private let userDefaultsKey = "favoriteTagIds"

    // MARK: - Public Methods

    func isFavorite(tagId: UUID) -> Bool {
        return favoriteTagIds.contains(tagId)
    }

    func toggleFavorite(tagId: UUID) {
        if favoriteTagIds.contains(tagId) {
            favoriteTagIds.remove(tagId)
        } else {
            favoriteTagIds.insert(tagId)
        }
        saveToUserDefaults()
    }

    func getAllFavorites() -> [UUID] {
        return Array(favoriteTagIds)
    }

    func clearFavorites() {
        favoriteTagIds.removeAll()
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }

    // MARK: - Private Methods

    private func saveToUserDefaults() {
        let tagIds = favoriteTagIds.map { $0.uuidString }
        UserDefaults.standard.set(tagIds, forKey: userDefaultsKey)
    }

    private func loadFromUserDefaults() {
        guard let savedTagIds = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] else { return }
        favoriteTagIds = Set(savedTagIds.compactMap { UUID(uuidString: $0) })
    }

    func removeFavoritesFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
