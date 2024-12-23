//
//  PageInfoModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//

import Foundation



public struct Pagination {
    public var pageCount: Int?
    public var pageSize: Int?
    public var currentPage = 1

    public var isLimitReached: Bool {
        guard let pageCount else { return false }
        return currentPage > pageCount
    }
    
    public var page: Page = .first {
        didSet {
            currentPage = page == .first ? 1 : currentPage + 1
        }
    }
}

