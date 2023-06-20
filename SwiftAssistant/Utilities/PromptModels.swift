//
//  PromptModels.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/17/23.
//

import Foundation

enum Tab {
        case settings, history, about
    }

enum RequestError: Error, LocalizedError, Identifiable {
    var id: Self { self }
    case failedRequest

    var errorDescription: String? {
        switch self {
        case .failedRequest: return "The request failed. Please try again."
        }
    }
}


enum ResponseLength: String, CaseIterable, Identifiable {
    var id: Self { self }
    case Swift = "very short"
    case Short = "short"
    case Medium = "medium"
    case Similar = "similar"
    case Long = "long"
}

enum QuestionType: String, CaseIterable, Identifiable  {
    var id: Self { self }
    case Code = "Code Refactor"
    case Question = "Word Problem"
}

enum HighlightrTheme: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case agate = "agate"
    case androidstudio = "androidstudio"
    case arduinoLight = "arduino-light"
    case arta = "arta"
    case ascetic = "ascetic"
    case atelierDuneDark = "atelier-dune-dark"
    case atelierDuneLight = "atelier-dune-light"
    case atelierForestDark = "atelier-forest-dark"
    case atelierForestLight = "atelier-forest-light"
    case atelierHeathDark = "atelier-heath-dark"
    case atelierHeathLight = "atelier-heath-light"
    case atelierLakesideDark = "atelier-lakeside-dark"
    case atelierLakesideLight = "atelier-lakeside-light"
    case atelierSeasideDark = "atelier-seaside-dark"
    case atelierSeasideLight = "atelier-seaside-light"
    case brownPaper = "brown-paper"
    case codepenEmbed = "codepen-embed"
    case colorBrewer = "color-brewer"
    case darcula = "darcula"
    case dark = "dark"
    case darkula = "darkula"
    case docco = "docco"
    case dracula = "dracula"
    case far = "far"
    case foundation = "foundation"
    case githubGist = "github-gist"
    case github = "github"
    case googlecode = "googlecode"
    case grayscale = "grayscale"
    case gruvboxDark = "gruvbox-dark"
    case gruvboxLight = "gruvbox-light"
    case hopscotch = "hopscotch"
    case hybrid = "hybrid"
    case idea = "idea"
    case irBlack = "ir-black"
    case kimbieDark = "kimbie.dark"
    case kimbieLight = "kimbie.light"
    case magula = "magula"
    case monoBlue = "mono-blue"
    case monokaiSublime = "monokai-sublime"
    case monokai = "monokai"
    case obsidian = "obsidian"
    case ocean = "ocean"
    case paraisoDark = "paraiso-dark"
    case paraisoLight = "paraiso-light"
    case pojoaque = "pojoaque"
    case purebasic = "purebasic"
    case qtcreatorDark = "qtcreator_dark"
    case qtcreatorLight = "qtcreator_light"
    case railscasts = "railscasts"
    case rainbow = "rainbow"
    case routeros = "routeros"
    case schoolBook = "school-book"
    case solarizedDark = "solarized-dark"
    case sunburst = "sunburst"
    case tomorrowNightBlue = "tomorrow-night-blue"
    case tomorrowNightBright = "tomorrow-night-bright"
    case tomorrowNightEighties = "tomorrow-night-eighties"
    case tomorrowNight = "tomorrow-night"
    case tomorrow = "tomorrow"
    case vs = "vs"
    case vs2015 = "vs2015"
    case xcode = "xcode"
    case xt256 = "xt256"
    case zenburn = "zenburn"
}
