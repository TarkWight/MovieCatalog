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
        UserShort(userId: userId ?? UUID(), nickName: nickName, avatar: avatarLink)
    }

    convenience init(from userShort: UserShort, context: NSManagedObjectContext) {
        self.init(context: context)
        self.userId = userShort.userId
        self.nickName = userShort.nickName
        self.avatarLink = userShort.avatar
    }
}
