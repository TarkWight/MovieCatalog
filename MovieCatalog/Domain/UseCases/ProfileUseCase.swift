//
//  ProfileUseCase.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.11.2024.
//

import Foundation


public struct ProfileUseCase {
    private let userAPI: ProfileAPI
    
    public init(userAPI: ProfileAPI) {
        self.userAPI = userAPI
    }
    
    public func fetchUserProfile() async throws -> ProfileModel {
        do {
            return try await userAPI.getUserProfile()
        } catch let error as AFError {
            throw error
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error while fetching user profile"])
        }
    }
    
    public func updateUserProfile(with profile: ProfileModel) async throws {
        do {
            try await userAPI.updateUserProfile(with: profile)
        } catch let error as AFError {
            throw error
        } catch {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error while updating user profile"])
        }
    }
}
