//
//  PageInfoModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//

import Foundation



public struct PageInfoModel: Codable {

    public var pageSize: Int?
    public var pageCount: Int?
    public var currentPage: Int?

    public init(pageSize: Int? = nil, pageCount: Int? = nil, currentPage: Int? = nil) {
        self.pageSize = pageSize
        self.pageCount = pageCount
        self.currentPage = currentPage
    }


}

