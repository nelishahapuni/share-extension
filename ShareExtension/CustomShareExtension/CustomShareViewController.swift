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

        // 1: Set the background and call the function to create the navigation bar
        self.view.backgroundColor = .systemGray6
        setupNavBar()
        setupViews()
    }

    // 2: Set the title and the navigation items
    private func setupNavBar() {
        self.navigationItem.title = "Custom Share Extension"

        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)

        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButton(itemDone, animated: false)
    }

    // 3: Define the actions for the navigation items
    @objc private func cancelAction () {
        let error = NSError(domain: "some.bundle.identifier", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }

    @objc private func doneAction() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.text = "some value"
        textField.textColor = .black
        textField.backgroundColor = .yellow
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private func setupViews() {
        //self.view.addSubview(textField)
        let testView = UIHostingController(rootView: TestView())
        let swiftuiView = testView.view!
            swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        addChild(testView)
        self.view.addSubview(swiftuiView)

        NSLayoutConstraint.activate([
            swiftuiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            swiftuiView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            swiftuiView.heightAnchor.constraint(equalToConstant: 44)
        ])

        testView.didMove(toParent: self)
    }
}
