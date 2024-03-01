//
//  ShareExtension.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct ShareExtension: View {

    var body: some View {
        if let token: String = UserDefaultManager.shared.get(for: .token) {
            HomeView(viewModel: HomeViewModel())
        } else {
            LoginView(viewModel: LoginViewModel(loginRequest: LoginModel.previewData))
        }
    }
}

#Preview {
    return ShareExtension()
}
