//
//  ShareViewController.swift
//  CustomShareExtension
//
//  Created by Neli Shahapuni on 4.11.23.
//

import UIKit
import SwiftUI
import Combine
import MobileCoreServices

class CustomShareViewController: UIViewController {
    @ObservedObject private var shareViewModel: ShareViewModel = ShareViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeToViewModel()
        loadExtensionItem()
        setupNavBar()
    }
}

// MARK: - Private Methods

private extension CustomShareViewController {
    func setupNavBar() {
        navigationItem.title = Strings.customShareExtension

        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.setLeftBarButton(itemCancel, animated: false)

        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationItem.setRightBarButton(itemDone, animated: false)
    }

    @objc func cancelAction () {
        let error = NSError(domain: Strings.bundleIdentifier, code: 0, userInfo: [NSLocalizedDescriptionKey: Strings.cancelError])
        extensionContext?.cancelRequest(withError: error)
    }

    @objc func doneAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    func subscribeToViewModel() {
        shareViewModel.$uploadStatus.sink { [weak self] status in
            guard let self else { return }
            if status.success {
                extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            } else {
                guard let error = status.error else { return }
                extensionContext?.cancelRequest(withError: error)
            }
        }
        .store(in: &cancellables)
    }

    func loadExtensionItem() {
        if let extensionItems = extensionContext?.inputItems,
           let attachments = (extensionItems[0] as? NSExtensionItem)?.attachments {
            let urlProvider = attachments[0] as NSItemProvider

            urlProvider.loadItem(forTypeIdentifier: Strings.publicURL,
                                 options: nil) { [weak self] (decoder: NSSecureCoding!, error: Error!) -> Void in
                guard let url = decoder as? NSURL,
                      let imageData = NSData(contentsOf: url as URL),
                      let uiimg = UIImage(data: imageData as Data) else {

                    self?.extensionContext?.cancelRequest(withError: error)
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    shareViewModel.image = uiimg
                    setupViews(shareView: ShareView(viewModel: shareViewModel))
                }
            }
        }
    }

    func setupViews(shareView: ShareView) {
        let shareView = UIHostingController(rootView: shareView)
        guard let swiftuiView = shareView.view else { return }

        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        addChild(shareView)
        view.addSubview(swiftuiView)
        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftuiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        shareView.didMove(toParent: self)
        view.backgroundColor = .systemGray6
    }
}
