//
//  CodeEditorView.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/18/23.
//

import SwiftUI
// CodeEditorView Component
struct CodeEditorView: View {
    @ObservedObject var viewModel: ContentEditorView_ViewModel
    @Binding var questionType: QuestionType

    var body: some View {
        VStack {
            Text(questionType == .Code ? "Paste Your Swift Code Below:" : "Type Your iOS Question Below:")
                .padding()
            
            TextEditor(text: $viewModel.writing) // assuming this replacement for your custom editor
                .font(.custom("SF Mono Regular", size: 17))
                .border(Color(UIColor.systemGray), width: 1)
                .padding(.leading)
                .padding(.trailing)
            
            Button(action: {
                viewModel.analyzeWriting()
            }) {
                Text("Compose a Response")
            }
            .padding()
        }
        Spacer()
    }
}
