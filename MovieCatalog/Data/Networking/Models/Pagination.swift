//
//  Pagination.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//


import Foundation

struct Pagination {
    var pageCount: Int?
    var currentPage = 1

    var isLimitReached: Bool {
        guard let pageCount else { return false }
        return currentPage > pageCount
    }

    var page: Page = .first {
        didSet {
            currentPage = page == .first ? 1 : currentPage + 1
        }
    }
}
