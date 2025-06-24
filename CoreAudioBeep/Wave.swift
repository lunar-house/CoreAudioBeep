//
//  Wave.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 23/06/2025.
//

import Foundation

protocol Wave {
    
    mutating func generateLeftFrame(sampleRate: Double) -> Float
    
    mutating func generateRightFrame(sampleRate: Double) -> Float
    
    func nextSample(phase: Float) -> Float
    
    func nextSample() -> Float
    
    var phaseL: Float { get set }
    
    var phaseR: Float { get set }
    
    var frequency: Float {get set }
    
    var sampleRate: Float {get set }
    
   
}


extension Wave {
    var twoPi: Float {
        get { return 2 * Float.pi }
    }
    
    var freqL: Float {
        get { return 70.0 }
    }
    
    var freqR: Float {
        get { return 70.0 }
    }
    
    mutating func generateLeftFrame(sampleRate: Double) -> Float {
        let frame = nextSample(phase: phaseL)
        phaseL += twoPi * freqL / Float(sampleRate)
        if phaseL > twoPi { phaseL -= twoPi }
        return frame
    }
    
    mutating func generateRightFrame(sampleRate: Double) -> Float {

        let frame = nextSample(phase: phaseR)
        phaseR += twoPi * freqR / Float(sampleRate)
        if phaseR > twoPi { phaseR -= twoPi }
        return frame
    }
    
    func nextSample() -> Float { return 0 }
}
