//
//  View+.swift
//  SwiftUI-GetCoordinatesFromImage-Sample
//
//  Created by kazunori.aoki on 2021/12/01.
//

import SwiftUI

extension View {

    func alert(alertItem: AlertData) -> Alert {
        let title = Text(alertItem.title)
        var messageText: Text? = nil
        if let message = alertItem.message {
            messageText = Text(message)
        }

        var primaryButton: Alert.Button? = nil
        if let primaryText = alertItem.primaryText {
            primaryButton = .default(Text(primaryText)) {
                _ = alertItem.primaryAction?()
            }
        }

        var secondaryButton: Alert.Button? = nil
        if let secondaryText = alertItem.secondaryText {
            secondaryButton = .default(Text(secondaryText)) {
                _ = alertItem.secondaryAction?()
            }
        }

        if let primaryButton = primaryButton, let secondaryButton = secondaryButton {
            return alert(title: title, message: messageText, primaryButton: primaryButton, secondaryButton: secondaryButton)
        } else if let primaryButton = primaryButton {
            return alert(title: title, message: messageText, dismissButton: primaryButton)
        } else if let secondaryButton = secondaryButton {
            return alert(title: title, message: messageText, dismissButton: secondaryButton)
        } else {
            return alert(title: title, message: messageText)
        }
    }

    private func alert(title: Text, message: Text?) -> Alert {
        return Alert(title: title, message: message)
    }

    private func alert(title: Text, message: Text?, primaryButton: Alert.Button, secondaryButton: Alert.Button) -> Alert {
        return
            Alert(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton)
    }

    private func alert(title: Text, message: Text?, dismissButton: Alert.Button) -> Alert {
        return
            Alert(title: title, message: message, dismissButton: dismissButton)
    }
}

extension View {
    func halfModal<Sheet: View>(isShow: Binding<Bool>,
                                @ViewBuilder sheet: @escaping () -> Sheet,
                                onEnd: @escaping () -> ()) -> some View
    {
        return self
            .background(HalfModalSheet(sheet: sheet(), isShow: isShow, onClose: onEnd))
    }
}
