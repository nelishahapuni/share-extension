//
//  ShareView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 2.02.24.
//

import SwiftUI

struct ShareView: View {
    @State private var showProgressView = false
    private var viewModel: ShareViewModel

    public init(viewModel: ShareViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            imagePreview()
            saveButton
        }
    }
}

// MARK: - Private Views

private extension ShareView {

    @ViewBuilder func imagePreview() -> some View {
        if let image = viewModel.image {
            Image(uiImage: image)
                .resizable()
                .clipShape(Rectangle())
                .aspectRatio(contentMode: .fit)
                .frame(width: Numbers.sharedImageSize, height: Numbers.sharedImageSize)
        }
    }

    var saveButton: some View {
        Button {
            didPressSave()
        } label: {
            Text(Strings.shareMessage)
                .bold()
                .foregroundStyle(.black)
                .padding()
                .background(showProgressView ? .gray : .yellow)
        }
        .overlay {
            ProgressView()
                .opacity(showProgressView ? 1 : 0)
        }
        .disabled(showProgressView)
    }
}

// MARK: - Private Methods

private extension ShareView {
    func didPressSave() {
        showProgressView = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showProgressView = false
            viewModel.saveDataToDocuments(viewModel.image?.pngData())
        }
    }
}

#Preview {
    ShareView(viewModel: ShareViewModel())
}
