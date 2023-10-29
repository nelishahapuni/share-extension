//
//  PhotoModel.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct PhotoModel: Transferable {

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }

    private(set) var image: Image
    private(set) var caption: String

    public init(
        image: Image,
        caption: String
    ) {
        self.image = image
        self.caption = caption
    }
}
