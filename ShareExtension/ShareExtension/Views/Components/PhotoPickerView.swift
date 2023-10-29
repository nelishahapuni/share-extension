//
//  PhotoPickerView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {

    @State private var selectedImage: Image?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var uploadError = false

    var body: some View {
        VStack {
            image
            photosPicker
        }
        .alert("There was an issue with uploading your image. Please try again.", isPresented: $uploadError) {
            Button("OK", role: .cancel) {
                uploadError = false
            }
        }
    }
}

// MARK: - Views

private extension PhotoPickerView {

    var image: some View {
        selectedImage?
            .resizable()
            .scaledToFit()
            .toolbar {
                shareLink
            }
    }

    var shareLink: some View {
        if let selectedImage = selectedImage {
            let photoModel = PhotoModel(image: selectedImage, caption: "Share this image.")
            return AnyView(
                ShareLink(
                    item: photoModel,
                    preview: SharePreview(
                        photoModel.caption,
                        image: photoModel.image
                    )
                )
            )
        } else {
            return AnyView(EmptyView())
        }
    }

    var photosPicker: some View {
        PhotosPicker(selection: $photosPickerItem, matching: .images) {
            Text("Upload Image")
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundColor(Color.white)
                .background(Color.purple)
                .cornerRadius(10)
        }
        .onChange(of: photosPickerItem) {
            Task {
                if let image = try? await photosPickerItem?.loadTransferable(type: Image.self) {
                    selectedImage = image
                } else {
                    uploadError = true
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView()
}
