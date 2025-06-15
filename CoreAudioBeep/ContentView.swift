//
//  ContentView.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 15/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showDetails = false
    var body: some View {
        VStack {
            Button("Play") {
                showDetails.toggle()
            }
            if showDetails {
                Text("Foo")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
