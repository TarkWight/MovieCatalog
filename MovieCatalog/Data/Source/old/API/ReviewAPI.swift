////
////  ReviewAPI.swift
////  ClientAPI
////
////  Created by Tark Wight on 15.10.2024.
////
//
//import Foundation
//internal import Alamofire
//
//open class ReviewAPI {
//    
//    private static func createHeaders() -> HTTPHeaders? {
//        guard let token = KeychainManager.shared.getToken() else {
//            print("No token found")
//            return nil
//        }
//        print("Authorization - Bearer \(token)")
//        return ["Authorization": "Bearer \(token)"]
//    }
//    
//    open class func reviewAdd(movieId: UUID, body: ReviewModifyModel?, completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let headers = createHeaders() else {
//            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"])))
//            return
//        }
//        
//        let url = APIEndpoint.Rewiew.reviewAdd(movieId: movieId)
//        AF.request(url, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
//            .validate()
//            .response { response in
//                switch response.result {
//                case .success:
//                    completion(.success(()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//    
//    open class func reviewEdit(movieId: UUID, reviewId: UUID, body: ReviewModifyModel?, completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let headers = createHeaders() else {
//            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"])))
//            return
//        }
//        
//        let url = APIEndpoint.Rewiew.reviewEdit(movieId: movieId, rewiewId: reviewId)
//        AF.request(url, method: .put, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
//            .validate()
//            .response { response in
//                        print("Request URL: \(url)")
//                        print("Response Data: \(String(describing: String(data: response.data ?? Data(), encoding: .utf8)))")
//                        
//                        switch response.result {
//                        case .success:
//                            completion(.success(()))
//                        case .failure(let error):
//                            print("Failed to update review: \(error)")
//                            completion(.failure(error))
//                        }
//                    }
//    }
//    
//    open class func reviewDelete(movieId: UUID, reviewId: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let headers = createHeaders() else {
//            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "No token found"])))
//            return
//        }
//        
//        let url = APIEndpoint.Rewiew.reviewDelete(movieId: movieId, rewiewId: reviewId)
//        AF.request(url, method: .delete, headers: headers)
//            .validate()
//            .response { response in
//                switch response.result {
//                case .success:
//                    completion(.success(()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//    }
//}
//
