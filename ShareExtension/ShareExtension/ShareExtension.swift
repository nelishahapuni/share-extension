//
//  ShareExtension.swift
//  ShareExtension
//
//  Created by Neli Shahapuni on 29.10.23.
//

import SwiftUI

struct ShareExtension: View {

    var body: some View {
        LoginView(viewModel: LoginViewModel(loginRequest: LoginModel.previewData))
    }
}

#Preview {
    return ShareExtension()
}
