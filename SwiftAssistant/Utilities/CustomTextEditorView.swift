//
//  CustomTextEditor.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

import SwiftUI
import UIKit

struct CustomTextEditorView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont(name: "Menlo", size: 20)
        textView.isEditable = true
        textView.isSelectable = true
        textView.backgroundColor = UIColor.black
        textView.textColor = UIColor.white
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextEditorView

        init(_ parent: CustomTextEditorView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

extension UITextView {
    @objc var placeholder: String {
        get {
            return ""
        }
        set {
            let placeholderString = NSAttributedString(string: newValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            self.textStorage.append(placeholderString)
        }
    }
}
