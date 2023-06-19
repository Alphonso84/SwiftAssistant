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
    @Binding var questionType: QuestionType
    @Binding var selectedTab: Tab

    var body: some View {
        List {
            VStack {
                HStack {
                    Button(action: {
                        selectedTab = .settings
                    }) {
                        VStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
                    
                    Button(action: {
                        selectedTab = .analytics
                    }) {
                        VStack {
                            Image(systemName: "chart.bar")
                            Text("Analytics")
                        }
                    }
                    
                    Button(action: {
                        selectedTab = .about
                    }) {
                        VStack {
                            Image(systemName: "info.circle")
                            Text("About")
                        }
                    }
                }
                SideBarSeparator()
                Spacer()
                
                Picker("Question Type", selection: $questionType) {
                    ForEach(QuestionType.allCases) { question in
                        Text(question.rawValue).tag(question)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker("Syntax Style", selection: $selectedTheme) {
                    ForEach(HighlightrTheme.allCases) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker("Analysis Length", selection: $analysisLength) {
                    ForEach(ResponseLength.allCases) { length in
                        Text(length.rawValue).tag(length)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                if questionType == .Question {
                    SideBarSeparator()
                    Spacer()
                    VStack {
                        Button(action: {
                            // selectedTab = .settings
                        }) {
                            HStack {
                                Image(systemName: "books.vertical")
                                Text("iOS Interview Question")
                            }
                        }
                        
                        Button(action: {
                            // selectedTab = .analytics
                        }) {
                            HStack {
                                Image(systemName: "books.vertical")
                                Text("Swift Basics")
                            }
                        }
                        
                        Button(action: {
                            // selectedTab = .about
                        }) {
                            HStack {
                                Image(systemName: "books.vertical")
                                Text("Swift Intermediate")
                            }
                        }
                    }
                    
                }
                
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 200)
    }
}

