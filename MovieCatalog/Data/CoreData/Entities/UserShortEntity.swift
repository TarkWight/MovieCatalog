//
//  UserShortEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 11.01.2025.
//


import CoreData

@objc(UserShortEntity)
final class UserShortEntity: NSManagedObject {
    @NSManaged var userId: UUID
    @NSManaged var nickName: String?
    @NSManaged var avatar: String?
    
    convenience init(from userShort: UserShort, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "ProfileEntity", in: context)!
        self.init(entity: entity, insertInto: context)
        
        userId = userShort.userId
        nickName = userShort.nickName
        avatar = userShort.avatar
    }
    
}

extension UserShortEntity {
    func toDomain() -> UserShort {
        UserShort(userId: userId, nickName: nickName, avatar: avatar)
    }

    func update(from userShort: UserShort) {
        userId = userShort.userId
        nickName = userShort.nickName
        avatar = userShort.avatar
    }
}

extension UserShort {
    func toEntity(context: NSManagedObjectContext) -> UserShortEntity {
        let entity = UserShortEntity(context: context)
        entity.userId = userId
        entity.nickName = nickName
        entity.avatar = avatar
        return entity
    }
}

extension UserShortEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserShortEntity> {
        return NSFetchRequest<UserShortEntity>(entityName: "MovieEntity")
    }
}
