//
//  SideBarView.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/18/23.
//

import SwiftUI

// SidebarView Component
struct SidebarView: View {
    @Binding var selectedTheme: HighlightrTheme
    @Binding var analysisLength: ResponseLength
    @State var selectedTab: Tab = .settings
    @ObservedObject var viewModel: ContentEditorView_ViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text(""), content:{
                Text("Settings").tag(Tab.settings)
                Text("History").tag(Tab.history)
                Text("About").tag(Tab.about)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            ZStack {
                switch selectedTab {
                case .settings:
                    // Show settings view
                    VStack {
                        SideBarSeparator()
                        
                        Picker("Question Type", selection: $viewModel.questionType) {
                            ForEach(QuestionType.allCases) { question in
                                Text(question.rawValue).tag(question)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        HStack {
                            Text("Syntax Style")
                                .accentColor(Color(uiColor: .secondaryLabel))
                            Picker("Syntax Style", selection: $selectedTheme) {
                                ForEach(HighlightrTheme.allCases) { theme in
                                    Text(theme.rawValue)
                                        .foregroundColor(.primary)
                                        .tag(theme)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(Color(uiColor: .label))
                            .background(Color(uiColor: .tertiarySystemBackground))
                            Spacer()
                        }
                        HStack {
                            Text("Analysis Length")
                                .accentColor(Color(uiColor: .secondaryLabel))
                            Picker("Analysis Length", selection: $analysisLength) {
                                ForEach(ResponseLength.allCases) { length in
                                    Text(length.rawValue)
                                        .foregroundColor(.primary)
                                        .tag(length)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .accentColor(Color(uiColor: .label))
                            .background(Color(uiColor: .tertiarySystemBackground))
                            Spacer()
                        }
                        Spacer()
                    }
                case .history:
                    // Show history view
                    VStack {
                        
                        SideBarSeparator()
                        List(viewModel.historyDictionary.history.keys.sorted(), id: \.self) { key in
                                   Text(key)
                               }
                    }
                case .about:
                    // Show about view
                    VStack {
                        SideBarSeparator()
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}
