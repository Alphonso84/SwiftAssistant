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
    @Published var selectedResponseTone: ResponseTone = .Friendly
    @Published var syntaxStyle: HighlightrTheme = .githubGist
    @Published var requestError: RequestError?
    //let speechSynthesizer = AVSpeechSynthesizer()
    let APIKey = "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"
    
    func analyzeWriting() {
        self.isLoading = true
        let codePrompt = "Can you analyze the following Swift code? Give a \(selectedResponseLength.rawValue) length explaination of what the code does. Then give a refactored improved code example and explain how it improved the code from the previous version. Here is the Swift code: \(writing)"
        let questionPrompt = "Answer the following iOS or Swift related propblem or question to the best of your ability. Give examples in code if it will be helpful for demonstrating the answer to the question or problem. Here is the question:\(writing)"
        let prompt = questionType == .Code ? codePrompt : questionPrompt
        print(prompt)
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(APIKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "model": "gpt-4",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    print("Error: \(error)")
                    self.requestError = .failedRequest
                } else if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let choices = json["choices"] as? [[String: Any]],
                           let firstChoice = choices.first,
                           let message = firstChoice["message"] as? [String: Any],
                           let content = message["content"] as? String {
                            self.analysis = content
                            //self.speakText(content)
                        }
                    } catch {
                        print("Error: \(error)")
                        self.requestError = .failedRequest
                    }
                }
            }
        }
        task.resume()
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




