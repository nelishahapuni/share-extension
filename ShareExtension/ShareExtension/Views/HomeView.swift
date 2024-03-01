//
//  HomeView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct HomeView: View {
    @State private var isImagePresented: Bool = false
    @ObservedObject private var viewModel: HomeViewModel

    private var columns: [GridItem] = []
    private let rowSpacing: CGFloat

    public init(
        viewModel: HomeViewModel,
        columnSpacing: CGFloat = Numbers.columnSpacing,
        numberOfColumns: Int = Numbers.numberOfColumns,
        rowSpacing: CGFloat = Numbers.rowSpacing
    ) {
        self.viewModel = viewModel
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

    var body: some View {
        VStack {
            imageGrid
            Spacer()
            PhotoPickerView(images: $viewModel.images)
                .navigationBarBackButtonHidden()
        }
        .padding(.horizontal)
    }
}

// MARK: - Private Views

private extension HomeView {

    var imageGrid: some View {
        LazyVGrid(
            columns: columns,
            spacing: rowSpacing
        ) {
            ForEach(viewModel.images, id: \.self) { item in
                Button(
                    action: {
                        isImagePresented = true
                    },
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
        .padding(.top)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
