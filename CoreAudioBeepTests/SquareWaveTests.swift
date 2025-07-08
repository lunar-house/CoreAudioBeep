//
//  SquareWaveTests.swift
//  CoreAudioBeepTests
//
//  Created by Hugo Jeffreys on 24/06/2025.
//

import Testing

@testable import CoreAudioBeep

struct SquareWaveTests {

    @Test func zeroSampleRateAndFrequency_nextSample_isZero() async throws {
        var squareWave = SquareWave(sampleRate: 0, frequency: 0)
        #expect(squareWave.nextSample() == 1.0)
        #expect(squareWave.nextSample() == -1.0)
        #expect(squareWave.nextSample() == -1.0)
        #expect(squareWave.nextSample() == -1.0)
    }

    @Test func nextSample_isOne() async throws {
        var squareWave = SquareWave(sampleRate: 2, frequency: 1)
        #expect(squareWave.nextSample() == 1.0)
    }

}
