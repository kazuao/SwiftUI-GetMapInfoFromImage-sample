//
//  Background.swift
//  SwiftUI-GetCoordinatesFromImage-Sample
//
//  Created by kazunori.aoki on 2021/12/01.
//

import UIKit
import SwiftUI

struct Background: UIViewRepresentable {
    typealias UIViewType = UIView

    var tappedCallback: ((CGPoint) -> ())

    func makeUIView(context: Context) -> UIView {
        let uiView = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tappedPoint))
        uiView.addGestureRecognizer(gesture)
        return uiView
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        return Coordinator(tappedCallback: tappedCallback)
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> ())

        init(tappedCallback: @escaping (CGPoint) -> ()) {
            self.tappedCallback = tappedCallback
        }

        @objc
        func tappedPoint(gesture: UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            tappedCallback(point)
        }
    }
}
