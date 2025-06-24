//
//  SquareWaveTests.swift
//  CoreAudioBeepTests
//
//  Created by Hugo Jeffreys on 24/06/2025.
//

import Testing
@testable import CoreAudioBeep

struct SquareWaveTests {

    @Test func squareWaveTest() async throws {
        let squareWave = SquareWave(sampleRate: 0, frequency: 0)
        #expect(squareWave.nextSample() == 0.0)
    }

}
