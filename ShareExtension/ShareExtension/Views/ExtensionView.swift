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
                    .frame(width: 300, height: 300)
            }
            Button {
                viewModel.saveDataToDocuments(viewModel.image?.pngData())
            } label: {
                Text("Save to Project Folder")
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
