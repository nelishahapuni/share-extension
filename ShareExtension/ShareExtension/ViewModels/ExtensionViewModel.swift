//
//  ExtensionViewModel.swift
//  CustomShareExtension
//
//  Created by Neli Shahapuni on 5.02.24.
//

import Foundation
import SwiftUI

class ExtensionViewModel {
    let image: UIImage

    init(image: UIImage) {
        self.image = image
    }

    func saveDataToDocuments(_ data: Data?, imageFileName: String = Strings.sharedImageName) {
        guard let imageFileURL = getDocumentsDirectory()?.appendingPathComponent(imageFileName) else { return }

        do {
            try data?.write(to: imageFileURL)
        } catch {
            print(error)
        }
    }
}

private extension ExtensionViewModel {

    private func getDocumentsDirectory() -> URL? {
        let paths = Strings.directoryPath
        return URL(fileURLWithPath: paths)
    }
}
