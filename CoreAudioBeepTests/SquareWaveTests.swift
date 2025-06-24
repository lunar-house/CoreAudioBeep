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
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let squareWave = SquareWave()
        #expect(squareWave.nextSample(phase: 3.3) == 0)
        
    }

}
