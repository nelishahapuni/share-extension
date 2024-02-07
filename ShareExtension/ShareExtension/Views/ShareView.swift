//
//  ShareView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 2.02.24.
//

import SwiftUI

struct ShareView: View {
    private var viewModel: ShareViewModel

    public init(viewModel: ShareViewModel) {
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
    ShareView(viewModel: ShareViewModel())
}
