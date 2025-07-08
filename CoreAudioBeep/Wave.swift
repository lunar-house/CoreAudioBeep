//
//  Wave.swift
//  CoreAudioBeep
//
//  Created by Petar Simonovic on 23/06/2025.
//

import Foundation

protocol Wave {

    mutating func nextSample(phase: Float) -> Float

    mutating func nextSample() -> Float

    var phase: Float { get set }

    var frequency: Float { get set }

    var sampleRate: Float { get set }

}

extension Wave {
    var twoPi: Float {
        return 2 * Float.pi
    }

    var freqL: Float {
        return 70.0
    }

    var freqR: Float {
        return 70.0
    }

    mutating func nextSample() -> Float {
        let frame = nextSample(phase: phase)
        phase += twoPi * freqL / Float(sampleRate)
        if phase > twoPi { phase -= twoPi }
        return frame
    }
}
