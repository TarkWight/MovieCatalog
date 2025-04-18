//
//  UserShortEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//

import Foundation
import CoreData


extension UserShortEntity {
    func toDomain() -> UserShort {
        return UserShort(
            userId: userId ?? UUID(),
            nickName: nickName,
            avatar: avatarLink
        )
    }
    
    convenience init(from domain: UserShort, context: NSManagedObjectContext) {
        self.init(context: context)
        self.userId = domain.userId
        self.nickName = domain.nickName
        self.avatarLink = domain.avatar
    }
}
