////
////  ProfileAPI.swift
////  ClientAPI
////
////  Created by Tark Wight on 03.11.2024.
////
//
//internal import Alamofire
//
//open class ProfileAPI {
//    private let token: String?
//    
//    public init() {
//        self.token = KeychainManager.shared.getToken()
//    }
//    
//    open func getUserProfile() async throws -> ProfileModel {
//        guard let token = token else {
//            throw NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"])
//        }
//
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)"
//        ]
//
//        return try await AF.request(APIEndpoint.User.getProfile, headers: headers)
//            .validate()
//            .serializingDecodable(ProfileModel.self).value
//    }
//    
//    open func updateUserProfile(with profile: ProfileModel) async throws {
//        guard let token = token else {
//            throw NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"])
//        }
//
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)",
//            "Content-Type": "application/json"
//        ]
//
//        _ = try await AF.request(APIEndpoint.User.updateProfile, method: .put, parameters: profile, encoder: JSONParameterEncoder.default, headers: headers)
//            .validate()
//            .serializingDecodable(ProfileModel.self)
//            .value
//    }
//
//}
