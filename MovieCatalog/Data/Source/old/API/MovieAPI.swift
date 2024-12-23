////
////  MovieAPI.swift
////  ClientAPI
////
////  Created by Tark Wight on 15.10.2024.
////
//
//internal import Alamofire
//
//open class MovieAPI {
//    
//    open class func getMovies(page: Int, completion: @escaping (_ data: MoviesPagedListModel?, _ error: Error?) -> Void) {
//        guard let token = KeychainManager.shared.getToken() else {
//            print("No token found")
//            completion(nil, NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "error_401"]))
//            return
//        }
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)"
//        ]
//        
//        AF.request(APIEndpoint.Movies.page(page: Int32(page)), headers: headers)
//            .validate()
//            .responseDecodable(of: MoviesPagedListModel.self) { response in
//                switch response.result {
//                    case .success(let data):
//                        completion(data, nil)
//                    case .failure(let error):
//                        completion(nil, error)
//                }
//            }
//    }
//    
//    open class func getMovieDetails(movieId: UUID, completion: @escaping (_ data: MovieDetailsModel?, _ error: Error?) -> Void) {
//        guard let token = KeychainManager.shared.getToken() else {
//            print("No token found")
//            completion(nil, NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "error_401"]))
//            return
//        }
//        
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer \(token)"
//        ]
//        
//        AF.request(APIEndpoint.Movies.details(movieId: movieId), headers: headers)
//            .validate()
//            .responseDecodable(of: MovieDetailsModel.self) { response in
//                switch response.result {
//                    case .success(let data):
//                        completion(data, nil)
//                    case .failure(let error):
//                        completion(nil, error)
//                }
//            }
//    }
//    
//    
//}
