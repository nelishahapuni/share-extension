//
//  ExtensionView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 2.02.24.
//

import SwiftUI

struct ExtensionView: View {
    private var viewModel: ExtensionViewModel

    public init(viewModel: ExtensionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Rectangle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Numbers.sharedImageSize, height: Numbers.sharedImageSize)
            }
            Button {
                viewModel.saveDataToDocuments(viewModel.image?.pngData())
            } label: {
                Text(Strings.shareMessage)
                    .bold()
                    .foregroundStyle(.black)
                    .padding()
                    .background(.yellow)
            }
        }
    }
}

#Preview {
    ExtensionView(viewModel: ExtensionViewModel(image: UIImage(named: "rabbit")))
}
