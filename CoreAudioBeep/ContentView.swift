//
//  ContentView.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 15/06/2025.
//

import SwiftUI

struct ContentView: View {
    let beep = Beep()
    @State private var playNoise = false
    @State private var playBinaural = false

    @State private var noiseButtonText = "Noise"
    @State private var binAuralButtonText = "Binaural"

    var body: some View {
        VStack {
            Button(noiseButtonText) {
                playNoise ? beep.stopNoise() : beep.startNoise()
                noiseButtonText = playNoise ? "Noise" : "Stop"
                playNoise.toggle()
            }
            
            Button(binAuralButtonText) {
                playBinaural ? beep.stopBinaural() : beep.startBinaural()
                binAuralButtonText = playBinaural ? "Binaural" : "Stop"
                playBinaural.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
