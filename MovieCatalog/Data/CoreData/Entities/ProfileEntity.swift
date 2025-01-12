//
//  ProfileEntity.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


//import CoreData
//
//@objc(ProfileEntity)
//final class ProfileEntity: NSManagedObject {
//    @NSManaged var id: UUID
//    @NSManaged var nickName: String
//    @NSManaged var email: String
//    @NSManaged var avatarLink: String
//    @NSManaged var name: String
//    @NSManaged var birthDate: Date
//    @NSManaged var gender: String
//    
//    convenience init(from profile: Profile, context: NSManagedObjectContext) {
//        let entity = NSEntityDescription.entity(forEntityName: "ProfileEntity", in: context)!
//        self.init(entity: entity, insertInto: context)
//        
//        id = profile.id
//        nickName = profile.nickName
//        email = profile.email
//        avatarLink = profile.avatarLink
//        name = profile.name
//        birthDate = profile.birthDate
//        gender = profile.gender.rawValue
//    }
//}
//
extension ProfileEntity {
    func toDomain() -> Profile {
        Profile(
            id: id,
            nickName: nickName,
            email: email,
            avatarLink: avatarLink,
            name: name,
            birthDate: birthDate,
            gender: Gender(rawValue: gender) ?? .male
        )
    }
}

//    func update(from profile: Profile) {
//        id = profile.id
//        nickName = profile.nickName
//        email = profile.email
//        avatarLink = profile.avatarLink
//        name = profile.name
//        birthDate = profile.birthDate
//        gender = profile.gender.rawValue
//    }
//}
//
//extension ProfileEntity {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileEntity> {
//        return NSFetchRequest<ProfileEntity>(entityName: "ProfileEntity")
//    }
//}
