import Down
import SwiftUI
import Highlightr


struct TypingView: View {
    @State private var textToDisplay = AttributedString("")
    
    @ObservedObject var viewModel = ContentEditorView_ViewModel()
    let highlightr = Highlightr()!
   
    var fullText: String
    var theme: String

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(textToDisplay)
                        .id(UUID())
                        
                    Spacer()
                }
                .padding(.leading)
                .padding(.trailing)
                Spacer()
            }
        }
        .onAppear {
            print("Full text: \(fullText)") // Debug output
            let highlightr = Highlightr()!
            if let attrString = highlightCodeBlocks(in: fullText,with:theme) {
                textToDisplay = attrString
                print("Successfully converted to AttributedString") // Debug output
            } else {
                print("Failed to convert to AttributedString") // Debug output
            }
        }
    }
    
    func highlightCodeBlocks(in text: String, with theme:String) -> AttributedString? {
        let codeBlockPattern = "(?s)```swift(.*?)```"
        let regex = try! NSRegularExpression(pattern: codeBlockPattern)

        let nsText = text as NSString
        let all = NSRange(location: 0, length: nsText.length)
        let matches = regex.matches(in: text, options: [], range: all)

        // Start with the entire text
        let highlightedText = NSMutableAttributedString(string: text)
        highlightr.setTheme(to:theme)
        // Go through each match (in reverse order so that the ranges stay correct after each replacement)
        for match in matches.reversed() {
            let nsRange = match.range(at: 1)
            let codeBlock = nsText.substring(with: nsRange)

            // Highlight the code block
            
            let highlightedBlock = highlightr.highlight(codeBlock, as: "swift")!

            // Replace the original code block with the highlighted version
            let fullRange = match.range(at: 0)
            highlightedText.replaceCharacters(in: fullRange, with: highlightedBlock)
        }

        return AttributedString(highlightedText)
    }
}
