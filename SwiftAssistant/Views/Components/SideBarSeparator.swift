//
//  SideBarSeparator.swift
//  SwiftAssistant
//
//  Created by Alphonso Sensley II on 6/18/23.
//

import SwiftUI

struct SideBarSeparator: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .frame(height: 1)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

