//
//  Model.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

import Foundation

struct Root: Decodable {
    let choices: [Choice]
}

struct Choice: Decodable {
    let message: Message
}

struct Message: Decodable {
    let content: String
}


struct History: Hashable {
    var history: [String: String]
}

