# share-extension
This repo contains an iOS share extensions for code/data sharing between the app and the extension.

## Contents

- ShareExtension
- Models
    - PhotoModel
    - LoginModel
- Views
    - HomeView
    - LoginView
- ViewModels
    - LoginViewModel
- Components
    - PhotoPickerView

## Share Extension

The main view of the share extension, containing the LoginView. 

```swift
LoginView(viewModel: LoginViewModel(loginRequest: LoginModel.previewData))
```

To be continued...