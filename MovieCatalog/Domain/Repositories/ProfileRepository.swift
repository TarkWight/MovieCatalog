//
//  ProfileRepository.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

protocol ProfileRepository {
    func deleteProfile() async
    func getProfile() async throws -> Profile
    func updateProfile(_ profile: Profile) async throws
}
