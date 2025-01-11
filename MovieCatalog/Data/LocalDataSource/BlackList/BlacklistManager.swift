//
//  BlacklistManager.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//

import Foundation

protocol BlacklistManagerProtocol: AnyObject {
    func addToBlacklist(movieId: UUID) async
    func fetchBlacklist() async -> [UUID]
    func clearBlacklist() async
}

@globalActor
actor BlacklistActor {
    static let shared = BlacklistActor()
}

final class BlacklistManager: BlacklistManagerProtocol {
    
    init() {}
    private let blacklistKey = "blacklistMovies"

    @BlacklistActor
    func addToBlacklist(movieId: UUID) async {
        var blacklist = await fetchBlacklist()
        if !blacklist.contains(movieId) {
            blacklist.append(movieId)
            saveBlacklist(blacklist)
        }
    }

    @BlacklistActor
    func fetchBlacklist() async -> [UUID] {
        guard let data = UserDefaults.standard.data(forKey: blacklistKey),
              let ids = try? JSONDecoder().decode([UUID].self, from: data) else {
            return []
        }
        return ids
    }

    @BlacklistActor
    func clearBlacklist() async {
        UserDefaults.standard.removeObject(forKey: blacklistKey)
    }

    // MARK: - Private Methods
    private func saveBlacklist(_ blacklist: [UUID]) {
        if let data = try? JSONEncoder().encode(blacklist) {
            UserDefaults.standard.set(data, forKey: blacklistKey)
        }
    }
}
