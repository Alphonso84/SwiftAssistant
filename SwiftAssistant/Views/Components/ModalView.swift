//
//  ModalView.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

import SwiftUI

struct ModalView: View {
    @Binding var showingModal: Bool

    var body: some View {
        VStack {
            ModalViewText()
            ModalViewButton(showingModal: $showingModal)
        }
        .frame(width: 300, height: 300)
        .background(Color.primary.opacity(0.5))
    }
}

struct ModalViewText: View {
    var body: some View {
        Text("""
            Welcome to EmailResponder! Powered by ChatGPT;
            EmailResponder composes email responses so you don't have to.
            We hope you like it!
            """)
            .padding()
    }
}

struct ModalViewButton: View {
    @Binding var showingModal: Bool

    var body: some View {
        Button(action: {
            showingModal = false
        }) {
            Text("OK")
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(showingModal: .constant(true))
    }
}

