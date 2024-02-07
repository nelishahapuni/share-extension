//
//  ShareViewController.swift
//  CustomShareExtension
//
//  Created by Neli Shahapuni on 4.11.23.
//

import UIKit
import SwiftUI
import MobileCoreServices

class CustomShareViewController: UIViewController {
    private var extensionViewModel: ExtensionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let extensionItems = extensionContext?.inputItems,
           let attachments = (extensionItems[0] as? NSExtensionItem)?.attachments {
            let urlProvider = attachments[0] as NSItemProvider

            urlProvider.loadItem(forTypeIdentifier: Strings.publicURL,
                                 options: nil) { [weak self] (decoder: NSSecureCoding!, error) -> Void in
                if let url = decoder as? NSURL,
                   let imageData = NSData(contentsOf: url as URL),
                   let uiimg = UIImage(data: imageData as Data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupViews(image: uiimg)
                    }
                    // TODO: - Handle Error Case
                }
            }
        }

        view.backgroundColor = .systemGray6
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = Strings.customShareExtension

        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.setLeftBarButton(itemCancel, animated: false)

        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.setRightBarButton(itemDone, animated: false)
    }

    @objc private func cancelAction () {
        let error = NSError(domain: Strings.bundleIdentifier, code: 0, userInfo: [NSLocalizedDescriptionKey: Strings.cancelError])
        extensionContext?.cancelRequest(withError: error)
    }

    @objc private func doneAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private func setupViews(image: UIImage) {
        extensionViewModel = ExtensionViewModel(image: image)
        guard let extensionViewModel else { return }

        let testView = UIHostingController(rootView: ExtensionView(viewModel: extensionViewModel))
        guard let swiftuiView = testView.view else { return }

        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        addChild(testView)
        view.addSubview(swiftuiView)
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        testView.didMove(toParent: self)
    }
}
