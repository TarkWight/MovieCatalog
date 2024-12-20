//
//  AuthAPI.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

internal import Alamofire

open class AuthAPI {
    
    // MARK: - Login
    open class func login(
        body: LoginCredentials,
        completion: @escaping (_ success: Bool, _ error: Error?) -> Void
    ) {
        let url = APIEndpoint.Auth.login
        
        AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: AuthResponseModel.self) { response in
            switch response.result {
            case .success(let loginResponse):
                if let token = loginResponse.token {
                    if KeychainManager.shared.saveToken(token) {
                        completion(true, nil)
                    } else {
                        completion(false, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to save token"]))
                    }
                } else {
                    completion(false, NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No token found in response"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    // MARK: - Register
    open class func register(
        body: UserRegisterModel,
        completion: @escaping (_ success: Bool, _ error: Error?) -> Void
    ) {
        let url = APIEndpoint.Auth.register
        
        AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseDecodable(of: AuthResponseModel.self) { response in
            switch response.result {
            case .success(let registerResponse):
                if let token = registerResponse.token {
                    if KeychainManager.shared.saveToken(token) {
                        completion(true, nil)
                    } else {
                        completion(false, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to save token"]))
                    }
                } else {
                    completion(false, NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No token found in response"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    // MARK: - Logout
    open class func logout(
        completion: @escaping (_ success: Bool, _ error: Error?) -> Void
    ) {
        let url = APIEndpoint.Auth.logout
        
        guard let token = KeychainManager.shared.getToken() else {
            completion(false, NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"]))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(
            url,
            method: .post,
            headers: headers
        )
        .validate()
        .response { response in
            switch response.result {
            case .success:
                if KeychainManager.shared.deleteToken() {
                    completion(true, nil)
                } else {
                    completion(false, NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to delete token"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
