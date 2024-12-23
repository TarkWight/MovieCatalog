//
//  ReviewModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//

import Foundation



public struct ReviewModel: Codable {

    public var id: UUID?
    public var rating: Int?
    public var reviewText: String?
    public var isAnonymous: Bool?
    public var createDateTime: String?
    public var author: UserShortModel?

    public init(
        id: UUID? = nil,
        rating: Int? = nil,
        reviewText: String? = nil,
        isAnonymous: Bool? = nil,
        createDateTime: String? = nil,
        author: UserShortModel? = nil
    ) {
        self.id = id
        self.rating = rating
        self.reviewText = reviewText
        self.isAnonymous = isAnonymous
        self.createDateTime = createDateTime
        self.author = author
    }

   
}
