//
//  ReviewModifyModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 15.10.2024.
//

import Foundation



public struct ReviewModifyModel: Codable {

    public var reviewText: String
    public var rating: Int?
    public var isAnonymous: Bool?

    public init(reviewText: String, rating: Int? = nil, isAnonymous: Bool? = nil) {
        self.reviewText = reviewText
        self.rating = rating
        self.isAnonymous = isAnonymous
    }


}
