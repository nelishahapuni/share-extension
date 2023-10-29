//
//  HomeView.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        PhotoPickerView()
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
