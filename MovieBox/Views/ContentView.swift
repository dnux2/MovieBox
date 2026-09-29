//
//  ContentView.swift
//  MovieBox
//
//  Created by Shoog Alzaid on 18/04/1448 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(Config.tmdbToken.isEmpty ? "❌ التوكن فاضي" : "✅ التوكن مقروء")
    }
}
#Preview {
    ContentView()
}
