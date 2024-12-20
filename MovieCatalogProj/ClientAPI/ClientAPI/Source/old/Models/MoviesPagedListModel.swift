//
//  MoviesPagedListModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//
import Foundation



public struct MoviesPagedListModel: Codable {

    public var movies: [MovieElementModel]?
    public var pageInfo: PageInfoModel?

    public init(movies: [MovieElementModel]? = nil, pageInfo: PageInfoModel? = nil) {
        self.movies = movies
        self.pageInfo = pageInfo
    }


}
