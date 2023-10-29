//
//  PhotoModel.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct PhotoModel: Transferable {
    
    private(set) var image: Image
    private(set) var caption: String

    public init(
        image: Image,
        caption: String
    ) {
        self.image = image
        self.caption = caption
    }

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
}

#if DEBUG
extension PhotoModel {
    static var previewData: PhotoModel {
        .init(
            image: Image(systemName: "pencil.and.scribble"),
            caption: "Pencil and scribble"
        )
    }
}
#endif
