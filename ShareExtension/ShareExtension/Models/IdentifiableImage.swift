//
//  IdentifiableImage.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 2.02.24.
//

import SwiftUI

struct IdentifiableImage: Identifiable, Hashable {
    let id = UUID()
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
