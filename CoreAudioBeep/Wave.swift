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

    mutating func nextSample() -> Float {
        let frame = nextSample(phase: phase)
        phase += twoPi * frequency / Float(sampleRate)
        if phase > twoPi { phase -= twoPi }
        return frame
    }
}
