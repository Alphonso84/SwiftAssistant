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
    @Published var questionType: QuestionType = .Question
    @Published var selectedResponseLength: ResponseLength = .Short
    @Published var syntaxStyle: HighlightrTheme = .githubGist
    @Published var requestError: RequestError?
    @Published var historyDictionary: History = .init(history:["":""])
    //let speechSynthesizer = AVSpeechSynthesizer()
    let networkService = NetworkService()
    
    init() {
        
        // Load history dictionary from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "history") {
            do {
                // Convert data to dictionary
                let historyObject = try JSONDecoder().decode(History.self, from: data)
                historyDictionary = historyObject
            } catch {
                print("Failed to load history: \(error)")
            }
        }
    }
    
    func saveHistoryToUserDefaults(history:[String:String]) {
        do {
            // Convert dictionary to data
            let data = try JSONEncoder().encode(history)
            // Save data to UserDefaults
            UserDefaults.standard.set(data, forKey: "history")
        } catch {
            print("Failed to save history: \(error)")
        }
    }
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
                        
                        // Update history dictionary with new analysis
                        self?.historyDictionary.history[self?.writing ?? "default"] = self?.analysis 

                        do {
                            // Convert dictionary to data
                            let data = try JSONEncoder().encode(self?.historyDictionary.history)
                            // Save data to UserDefaults
                            UserDefaults.standard.set(data, forKey: "history")
                        } catch {
                            print("Failed to save history: \(error)")
                        }
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
        let prompt = questionType == .Code ? codePrompt : questionPrompt
        print(prompt)
        return prompt
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




