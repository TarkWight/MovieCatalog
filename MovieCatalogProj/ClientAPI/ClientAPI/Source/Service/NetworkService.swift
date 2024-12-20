//
//  NetworkService.swift
//  ClientAPI
//
//  Created by Tark Wight on 20.12.2024.
//

import Foundation

// MARK: - Протокол NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func request(with config: NetworkConfig, useToken: Bool) async throws
    func request<Model: Decodable>(
        with config: NetworkConfig,
        useToken: Bool
    ) async throws -> Model
    func encode<Value: Encodable>(_ value: Value) throws -> Data
}

// MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {

    private enum Constants {
        static let movieBaseUrl = "https://react-midterm.kreosoft.space/api/"
    }

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let keychainService: KeychainServiceProtocol

    init(keychainService: KeychainServiceProtocol) {
        self.keychainService = keychainService
    }

    func request(with config: NetworkConfig, useToken: Bool = false) async throws {
        let (_, response) = try await makeRequest(config: config, useToken: useToken)
        try handleResponse(response)
    }

    func request<Model: Decodable>(
        with config: NetworkConfig,
        useToken: Bool = false
    ) async throws -> Model {
        let (data, response) = try await makeRequest(config: config, useToken: useToken)

        try handleResponse(response)
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
}

// MARK: - Private Methods
private extension NetworkService {

    func makeRequest(config: NetworkConfig, useToken: Bool) async throws -> (Data, URLResponse) {
        let token = useToken ? try keychainService.retrieveToken() : nil
        let urlRequest = try buildRequest(with: config, token: token)
        return try await URLSession.shared.data(for: urlRequest)
    }

    func buildRequest(with config: NetworkConfig, token: String?) throws -> URLRequest {
        let urlString = Constants.movieBaseUrl + config.path + config.endPoint
        guard let url = URL(string: urlString) else { throw NetworkError.missingURL }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)

        switch config.task {
        case .requestBody(let data):
            request.httpBody = data

        case .requestUrlParameters(let parameters):
            try URLParameterEncoder().encode(urlRequest: &request, with: parameters)

        default: break
        }

        request.httpMethod = config.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

    func handleResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }

        guard (200...299).contains(httpResponse.statusCode) else {
            switch HTTPStatusCode(rawValue: httpResponse.statusCode) {
            case .unauthorized:
                try keychainService.deleteToken()
                throw AuthError.unauthorized
            default:
                throw NetworkError.invalidResponse
            }
        }
    }
}
