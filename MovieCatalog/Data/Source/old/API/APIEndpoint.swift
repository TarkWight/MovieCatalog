//
//  APIEndpoint.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation

public enum APIEndpoint {
    private static let baseURL: String = "https://react-midterm.kreosoft.space/api"

    public enum Auth {
        static let login = "\(baseURL)/account/login"
        static let register = "\(baseURL)/account/register"
        static let logout = "\(baseURL)/account/logout"
    }
    
    public enum FavoriteMovies {
        static let favorites = "\(baseURL)/favorites"
        static func movieIdAdd(movieId: UUID) -> String {
            return "\(baseURL)/favorites/\(movieId.uuidString)/add"
        }
        static func movieIdDelete(movieId: UUID) -> String {
            return "\(baseURL)/favorites/\(movieId.uuidString)/delete"
        }
    }
    
    public enum Movies {
        static func page(page: Int32) -> String {
            return "\(baseURL)/movies/\(page)"
        }
        static func details(movieId: UUID) -> String {
            return "\(baseURL)/movies/details/\(movieId.uuidString)"
        }
    }
    
    public enum Rewiew {
        static func reviewAdd(movieId: UUID) -> String {
            return "\(baseURL)/movie/\(movieId.uuidString)/review/add"
        }
        static func reviewEdit(movieId: UUID, rewiewId: UUID) -> String {
            return "\(baseURL)/movie/\(movieId.uuidString)/review/\(rewiewId.uuidString)/edit"
        }
        static func reviewDelete(movieId: UUID, rewiewId: UUID) -> String {
            return "\(baseURL)/movie/\(movieId.uuidString)/review/\(rewiewId.uuidString)/delete"
        }
    }
    
    public enum User {
        static let getProfile = "\(baseURL)/account/profile"
        static let updateProfile = "\(baseURL)/account/profile"
    }
    
}
