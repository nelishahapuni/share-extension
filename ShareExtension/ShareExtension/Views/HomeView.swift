//
//  HomeView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct HomeView: View {
    private var columns: [GridItem] = []
    private let rowSpacing: CGFloat

    public init(
        columnSpacing: CGFloat = 10,
        numberOfColumns: Int = 3,
        rowSpacing: CGFloat = 10
    ) {
        columns.append(
            contentsOf: repeatElement(
                GridItem(
                    .flexible(),
                    spacing: columnSpacing
                ),
                count: numberOfColumns
            )
        )
        self.rowSpacing = rowSpacing
    }

    @State private var isImagePresented: Bool = false
    @State private var images: [IdentifiableImage] = []

    var body: some View {
        VStack {
            LazyVGrid(
                columns: columns,
                spacing: rowSpacing
            ) {
                ForEach(images, id: \.self) { item in
                    Button(
                        action: { isImagePresented = true },
                        label: {
                            item.image
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                        }
                    )
                    .navigationDestination(
                        isPresented: $isImagePresented) {
                            ImageView(image: item.image)
                        }
                }
            }
            Spacer()
            PhotoPickerView(images: $images)
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    HomeView()
}
