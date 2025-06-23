//
//  SquareWave.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 23/06/2025.
//
import Foundation

class SquareWave: Wave {
  
    var phaseL: Float = 0
    var phaseR: Float = 0
    
    func nextSample(phase: Float) -> Float {
        return sin(phase) > 0 ? 1.0 : -1.0 * 0.1
    }
}
