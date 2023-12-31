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
        .alert(Alert.message, isPresented: $uploadError) {
            Button(Alert.text, role: .cancel) {
                uploadError = false
            }
        }
    }
}

// MARK: - Private Views

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
            let photoModel = PhotoModel(image: selectedImage, caption: Share.caption)
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
            Text(Picker.text)
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: Picker.maxHeight)
                .foregroundColor(Color.white)
                .background(Color.purple)
                .cornerRadius(Picker.cornerRadius)
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

// MARK: - Constants

private extension PhotoPickerView {

    enum Picker {
        static let text = "Choose Image"
        static let maxHeight: CGFloat = 60
        static let cornerRadius: CGFloat = 10
    }

    enum Alert {
        static let message = "There was an issue with uploading your image. Please try again."
        static let text = "OK"
    }

    enum Share {
        static let caption = "Share this image."
    }
}

#Preview {
    PhotoPickerView()
}
