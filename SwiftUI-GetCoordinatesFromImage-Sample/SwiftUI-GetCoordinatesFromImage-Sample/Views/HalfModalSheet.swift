//
//  HalfModalSheet.swift
//  SwiftUI-GetCoordinatesFromImage-Sample
//
//  Created by kazunori.aoki on 2021/12/01.
//

import UIKit
import SwiftUI

struct HalfModalSheet<Sheet: View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    var sheet: Sheet
    @Binding var isShow: Bool
    var onClose: () -> ()

    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isShow {
            let sheetController = CustomHostingController(rootView: sheet)
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        } else {
            uiViewController.dismiss(animated: true) { onClose() }
        }
    }

    final class CustomHostingController<content: View>: UIHostingController<content> {
        override func viewDidLoad() {
            super.viewDidLoad()

            if let sheet = sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    final class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfModalSheet

        init(parent: HalfModalSheet) {
            self.parent = parent
        }

        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.isShow = false
        }
    }
}
