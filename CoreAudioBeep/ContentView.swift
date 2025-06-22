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
    @State private var playSquare = false

    @State private var noiseButtonText = "Noise"
    @State private var binAuralButtonText = "Binaural"
    @State private var squareWaveButtonText = "Square"

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

            Button(squareWaveButtonText) {
                playSquare ? beep.stopSquare() : beep.startSquare()
                squareWaveButtonText = playSquare ? "Square" : "Stop"
                playSquare.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
