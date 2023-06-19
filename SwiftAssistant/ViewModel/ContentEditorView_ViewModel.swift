//
//  ContentEditorView_ViewModel.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

//import AVFoundation
import SwiftUI

class ContentEditorView_ViewModel: ObservableObject {
    @Published var writing = ""
    @Published var analysis = ""
    @Published var isLoading = false
    @Published var showCheckmark = false
    @Published var showingModal = false
    @Published var questionType: QuestionType = .Code
    @Published var selectedResponseLength: ResponseLength = .Short
    @Published var syntaxStyle: HighlightrTheme = .githubGist
    @Published var requestError: RequestError?
    //let speechSynthesizer = AVSpeechSynthesizer()
    let networkService = NetworkService()
    
    func analyzeWriting() {
        self.isLoading = true
        let prompt = createPrompt()
        
        networkService.sendRequest(with: prompt) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let root):
                    if let firstChoice = root.choices.first {
                        print("CONTENT BEING PRINTED: \(firstChoice.message.content)")
                        self?.analysis = firstChoice.message.content
                    } else {
                        print("No choices available")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    self?.requestError = .failedRequest
                }
            }
        }
    }
    
    private func createPrompt() -> String {
        let codePrompt = "Can you analyze the following Swift code? Give a \(selectedResponseLength.rawValue) length explanation of what the code does. Then give a refactored improved code example and explain how it improved the code from the previous version. Here is the Swift code: \(writing)"
        let questionPrompt = "Answer the following iOS or Swift related problem or question to the best of your ability. Add a short example in Swift code. Here is the question: \(writing)"
        return questionType == .Code ? codePrompt : questionPrompt
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = analysis
        withAnimation {
            self.showCheckmark = true
        }
    }
    
    func checkFirstLaunch() {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        if !isFirstLaunch {
            showingModal = true
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
    }
    
    //    func speakText(_ text: String) {
    //        let utterance = AVSpeechUtterance(string: text)
    //        speechSynthesizer.speak(utterance)
    //    }
}




