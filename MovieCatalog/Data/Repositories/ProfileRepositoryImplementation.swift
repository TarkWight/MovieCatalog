//
//  ProfileRepositoryImplementation.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import Foundation

final class ProfileRepositoryImplementation {
    
    enum ProfileRepositoryError: LocalizedError {
        case notFound
        case updateFailed
        case deleteFailed
        case networkUnavailable
        
        var errorDescription: String? {
            switch self {
            case .notFound:
                return LocalizedKey.ErrorMessage.Profile.notFound
            case .updateFailed:
                return LocalizedKey.ErrorMessage.Profile.updateFailed
            case .deleteFailed:
                return LocalizedKey.ErrorMessage.Profile.deleteFailed
            case .networkUnavailable:
                return LocalizedKey.ErrorMessage.Network.noConnect
            }
        }
    }
    
    private var isProfileLoaded = false
    private let localDataSource: ProfileLocalDataSource
    private let remoteDataSource: ProfileRemoteDataSource

    init(
        localDataSource: ProfileLocalDataSource,
        remoteDataSource: ProfileRemoteDataSource
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
}

extension ProfileRepositoryImplementation: ProfileRepository {
    
    @CoreDataActor
    func deleteProfile() async {
        await localDataSource.deleteProfile()
        isProfileLoaded = false
    }
    
    @CoreDataActor
    func getProfile() async throws -> Profile {
        if isProfileLoaded, let localProfile = await localDataSource.fetchProfile() {
            return localProfile.toDomain()
        } else {
            do {
                let profileDto = try await remoteDataSource.fetchProfile()
                let profile = profileDto.toDomain()
                
                await localDataSource.saveProfile(ProfileEntity(context: CoreDataManager.shared.viewContext))
                isProfileLoaded = true
                return profile
            } catch {
                await handleUnauthorizedError(error)
                throw ProfileRepositoryError.notFound
            }
        }
    }
    
    @CoreDataActor
    func updateProfile(_ profile: Profile) async throws {
        let profileDto = ProfileDTO(
            id: profile.id,
            nickName: profile.nickName,
            email: profile.email,
            avatarLink: profile.avatarLink,
            name: profile.name,
            birthDate: DateFormatter.iso8601Full.string(from: profile.birthDate),
            gender: profile.gender == .male ? .male : .female
        )
        
        do {
            try await remoteDataSource.updateProfile(profile: profileDto)
            await localDataSource.saveProfile(ProfileEntity(context: CoreDataManager.shared.viewContext))
        } catch {
            await handleUnauthorizedError(error)
            throw ProfileRepositoryError.updateFailed
        }
    }
}

private extension ProfileRepositoryImplementation {
    func handleUnauthorizedError(_ error: Error) async {
        if let authError = error as? AuthError, authError == .unauthorized {
            await deleteProfile()
        }
    }
}
