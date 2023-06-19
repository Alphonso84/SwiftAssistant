//
//  AnalysisResultView.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/18/23.
//

import SwiftUI
// AnalysisResultView Component
struct AnalysisResultView: View {
    @ObservedObject var viewModel: ContentEditorView_ViewModel
    @Binding var selectedTheme: HighlightrTheme
    @Binding var questionType: QuestionType

    var body: some View {
        VStack {
            Text(questionType == .Code ? "Refactored Swift Code" : "SwiftAssistant Answer")
                .padding()
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ZStack{
                    TypingView(fullText:viewModel.analysis, theme:selectedTheme.rawValue)
                        .frame(maxWidth:.infinity,maxHeight: .infinity)
                        .border(Color(UIColor.separator), width:2)
                        .padding(.leading)
                        .padding(.trailing)
                    if viewModel.showCheckmark {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.green)
                            .opacity(viewModel.showCheckmark ? 1 : 0)
                            .animation(.easeInOut(duration: 2))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        viewModel.showCheckmark = false
                                    }
                                }
                            }
                    }
                }
            }
            Button(action: viewModel.copyToClipboard) {
                Text("Copy Refactored Code to Clipboard")
            }
            .padding()
        }
    }
}
