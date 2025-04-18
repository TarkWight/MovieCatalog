//
//  ProfileDTO.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.12.2024.
//


import Foundation

struct ProfileDTO: Codable {
    let id: UUID
    let nickName: String?
    let email: String
    let avatarLink: String?
    let name: String
    let birthDate: String
    let gender: GenderDTO

    func toDomain() -> Profile {
        .init(
            id: id,
            nickName: nickName ?? "",
            email: email,
            avatarLink: avatarLink ?? "",
            name: name,
            birthDate: DateFormatter.iso8601Full.date(from: birthDate) ?? .now,
            gender: gender == .male ? .male : .female
        )
    }
}
