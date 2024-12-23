//
//  InterceptorProtocols.swift
//  MovieCatalog
//
//  Created by Tark Wight on 22.12.2024.
//

import Foundation


protocol RequestInterceptor {
    func intercept(request: inout URLRequest) throws
}

protocol ErrorInterceptor {
    func intercept(error: Error) throws -> Error
}
