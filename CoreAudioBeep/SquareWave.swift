//
//  SquareWave.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 23/06/2025.
//
import Foundation

class SquareWave: Wave {
    var sampleRate: Float
    var phaseL: Float = 0
    var phaseR: Float = 0
    var frequency: Float
    
    init(sampleRate: Float, frequency: Float) {
        self.sampleRate = sampleRate
        self.frequency = frequency
    }
    
    func nextSample(phase: Float) -> Float {
        return sin(phase) > 0 ? 1.0 : -1.0 * 0.1
    }
}
