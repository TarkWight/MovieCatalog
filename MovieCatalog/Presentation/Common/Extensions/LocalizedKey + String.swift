//
//  LocalizedKey + String.swift
//  MovieCatalog
//
//  Created by Tark Wight on 05.01.2025.
//

import SwiftUI

extension LocalizedStringKey {
    static func from(_ key: String) -> LocalizedStringKey {
        LocalizedStringKey(key)
    }
}
