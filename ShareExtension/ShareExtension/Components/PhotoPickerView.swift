//
//  PhotoPickerView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @Binding var images: [IdentifiableImage]
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var uploadError = false

    var body: some View {
        photosPicker
            .alert(Strings.uploadError, isPresented: $uploadError) {
                Button(Strings.uploadText, role: .cancel) {
                    uploadError = false
                }
            }
    }
}

// MARK: - Private Views

private extension PhotoPickerView {

    var photosPicker: some View {
        PhotosPicker(selection: $photosPickerItem, matching: .images) {
            Text(Strings.pickerText)
                .font(.title)
                .frame(maxWidth: .infinity, maxHeight: Numbers.pickerMaxHeight)
                .foregroundColor(Color.white)
                .background(Color.purple)
                .cornerRadius(Numbers.pickerCornerRadius)
        }
        .onChange(of: photosPickerItem) {
            Task {
                if let image = try? await photosPickerItem?.loadTransferable(type: Image.self) {
                    images.append(IdentifiableImage(image: image))
                } else {
                    uploadError = true
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView(images: Binding.constant([IdentifiableImage(image: Image(Strings.testAsset))]))
}
