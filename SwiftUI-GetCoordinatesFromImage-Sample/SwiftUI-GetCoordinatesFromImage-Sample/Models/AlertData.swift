//
//  AlertData.swift
//  SwiftUI-GetCoordinatesFromImage-Sample
//
//  Created by kazunori.aoki on 2021/12/01.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var alert: Alert
//    var alert: AlertData
}

struct AlertData: Identifiable {
    let id = UUID()
    
    let title: String
    let message: String?
    let primaryText: String?
    let primaryAction: (() -> ())?
    let secondaryText: String?
    let secondaryAction: (() -> ())?

    init(title: String,                message: String? = nil,
         primaryText: String? = nil,   primaryAction: (() -> ())? = nil,
         secondaryText: String? = nil, secondaryAction: (() -> ())? = nil) {
        self.title = title
        self.message = message
        self.primaryText = primaryText
        self.primaryAction = primaryAction
        self.secondaryText = secondaryText
        self.secondaryAction = secondaryAction
    }
}
