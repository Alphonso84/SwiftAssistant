//
//  ContentView.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

import Down
import SwiftUI

// Main View
struct MainView: View {
    @ObservedObject var viewModel = ContentEditorView_ViewModel()
    @State private var selectedTheme = HighlightrTheme.dracula
    @State private var analysisLength = ResponseLength.Short
    @State private var questionType = QuestionType.Code
    @State private var selectedTab: Tab = .settings
    
    var body: some View {
        NavigationView {
            SidebarView(selectedTheme: $selectedTheme, analysisLength: $analysisLength, questionType: $questionType, selectedTab: $selectedTab)
            VStack {
                HStack {
                    CodeEditorView(viewModel: viewModel, questionType: $questionType)
                    AnalysisResultView(viewModel: viewModel, selectedTheme: $selectedTheme, questionType: $questionType)
                }
                
                .onAppear(perform: viewModel.checkFirstLaunch)
                .onChange(of: questionType) { newQuestionType in
                    viewModel.questionType = newQuestionType
                }
                .sheet(isPresented: $viewModel.showingModal) {
                    ModalView(showingModal: $viewModel.showingModal)
                }
            }
            .alert(item: $viewModel.requestError) { error in
                Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("Retry"), action: {
                    //viewModel.isLoading = false
                }))
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
