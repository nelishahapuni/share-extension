//
//  ImageView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 2.02.24.
//

import SwiftUI

struct ImageView: View {
    private var image: Image

    init(image: Image) {
        self.image = image
    }

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .toolbar {
                ShareLink(
                    item: image,
                    preview: SharePreview(
                        Strings.shareCaption,
                        image: image
                    )
                )
            }
    }
}

#Preview {
    ImageView(image: Image("rabbit"))
}
