//
//  HomeViewModel.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 1.03.24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var images: [IdentifiableImage] = []
}
