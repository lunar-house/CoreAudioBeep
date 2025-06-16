//
//  ContentView.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 15/06/2025.
//

import SwiftUI

struct ContentView: View {
    let beep = Beep()
    @State private var playSound = false
    @State private var buttonText = "Play"
    var body: some View {
        VStack {
            Button(buttonText) {
                playSound ? beep.stop() : beep.start()
                buttonText = playSound ? "Play" : "Stop"
                playSound.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
