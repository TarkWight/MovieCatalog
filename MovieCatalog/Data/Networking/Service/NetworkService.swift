//
//  NetworkService.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//

import Foundation

final class NetworkService {
    
    private enum Constants {
        static let baseUrl = "https://react-midterm.kreosoft.space/api/"
        static let maxRetryCount = 3
    }
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    let keychainService: KeychainService
    private let session: URLSession
    
    var onLoginSuccess: (() -> Void)?
    var onUnauthorized: (() -> Void)?
    
    init(keychainService: KeychainService) {
        self.keychainService = keychainService
        
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        self.session = URLSession(configuration: configuration)
    }
    
    func request(with config: NetworkConfig, useToken: Bool = false) async throws {
        try await performRequest(config: config, useToken: useToken, retryCount: Constants.maxRetryCount)
    }
    
    func request<Model: Decodable>(with config: NetworkConfig, useToken: Bool = false) async throws -> Model {
        let data = try await performRequest(config: config, useToken: useToken, retryCount: Constants.maxRetryCount)
        guard let model = try? decoder.decode(Model.self, from: data) else {
            throw NetworkError.decodingError
        }
        return model
    }
    
    func encode<Value: Encodable>(_ value: Value) throws -> Data {
        guard let encoded = try? encoder.encode(value) else {
            throw NetworkError.encodingError
        }
        return encoded
    }
    
    // MARK: - Private Methods
    
    private func performRequest(config: NetworkConfig, useToken: Bool, retryCount: Int) async throws -> Data {
        do {
            let token = useToken ? try keychainService.retrieveToken() : nil
            let request = try buildRequest(config: config, token: token)
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }
            
//            if let responseData = String(data: data, encoding: .utf8) {
//                print("Response Body: \(responseData)")
//            }
            
            try handleResponse(response)
            return data
        } catch {
            print("Error during request: \(error)")
            guard retryCount > 0, shouldRetry(error: error) else {
                throw error
            }
            try await Task.sleep(nanoseconds: UInt64(pow(2.0, Double(Constants.maxRetryCount - retryCount))) * 1_000_000_000)
            return try await performRequest(config: config, useToken: useToken, retryCount: retryCount - 1)
        }
    }
    
    private func buildRequest(config: NetworkConfig, token: String?) throws -> URLRequest {
        let urlString = Constants.baseUrl + config.path + config.endPoint
        guard let url = URL(string: urlString) else {
            throw NetworkError.missingURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = config.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch config.task {
        case .requestBody(let data):
            request.httpBody = data
//            if let json = String(data: data, encoding: .utf8) {
//                print("Request body: \(json)")
//            }
        case .requestUrlParameters(let parameters):
            try URLParameterEncoder().encode(urlRequest: &request, with: parameters)
        default:
            break
        }

//        print("Request URL: \(urlString)")
//        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        return request
    }
    
    private func handleResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            switch HTTPStatusCode(rawValue: httpResponse.statusCode) {
            case .unauthorized:
                try keychainService.deleteToken()
                onUnauthorized?()
                throw AuthError.unauthorized
            default:
                throw NetworkError.invalidResponse
            }
        }
        
        if httpResponse.statusCode == 200 {
            onLoginSuccess?()
        }
    }
    
    private func shouldRetry(error: Error) -> Bool {
        guard let urlError = error as? URLError else {
            return false
        }
        
        switch urlError.code {
        case .timedOut, .cannotFindHost, .cannotConnectToHost, .networkConnectionLost, .notConnectedToInternet:
            return true
        default:
            return false
        }
    }
}
