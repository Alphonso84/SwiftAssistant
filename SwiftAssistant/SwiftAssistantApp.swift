//
//  SwiftAssistantApp.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

import SwiftUI

@main
struct SwiftAssistantApp: App {
    @StateObject private var viewModel = ContentEditorView_ViewModel()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(viewModel)
        }
    }
}
