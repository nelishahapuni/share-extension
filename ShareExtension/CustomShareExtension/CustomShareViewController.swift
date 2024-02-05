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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Try to get input items
        if let extensionItems = extensionContext?.inputItems,
           let attachments = (extensionItems[0] as? NSExtensionItem)?.attachments {
            let urlProvider = attachments[0] as NSItemProvider

            urlProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] (decoder: NSSecureCoding!, _) -> Void in
                if let url = decoder as? NSURL,
                   let imageData = NSData(contentsOf: url as URL),
                   let uiimg = UIImage(data: imageData as Data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupViews(image: uiimg)
                    }
                }
            }
        }

        view.backgroundColor = .systemGray6
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = "Custom Share Extension"

        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.setLeftBarButton(itemCancel, animated: false)

        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.setRightBarButton(itemDone, animated: false)
    }

    @objc private func cancelAction () {
        let error = NSError(domain: "some.bundle.identifier", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }

    @objc private func doneAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private func setupViews(image: UIImage) {
        let extensionViewModel = ExtensionViewModel(image: image)
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
