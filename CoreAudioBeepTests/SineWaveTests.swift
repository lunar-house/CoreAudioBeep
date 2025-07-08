import Testing
import Foundation
import Numerics


@testable import CoreAudioBeep

struct SineWaveTests {
    
    @Test func sampleRateOf2AndFrequency1_nextSample_oscillatesBetweenExtremes()
        async throws
    {
        var sineWave = SineWave(sampleRate: 2, frequency: 1)
        #expect(sineWave.nextSample().isApproximatelyEqual(to: 0.0, absoluteTolerance: 1.0e-6))
        #expect(sineWave.nextSample().isApproximatelyEqual(to: 0.0, absoluteTolerance: 1.0e-6))

      }
    
    @Test
    func
        sampleRateDoubleTheFrequency_nextSample_oscillatesBetweenExtremesEveryOtherTime()
        async throws
    {
        var sineWave = SineWave(sampleRate: 4, frequency: 1)
        #expect(sineWave.nextSample().isApproximatelyEqual(to: 0.0, absoluteTolerance: 1.0e-6))
        #expect(sineWave.nextSample().isApproximatelyEqual(to: 1.0, absoluteTolerance: 1.0e-6))
        #expect(sineWave.nextSample().isApproximatelyEqual(to: 0.0, absoluteTolerance: 1.0e-6))
        #expect(sineWave.nextSample().isApproximatelyEqual(to: -1.0, absoluteTolerance: 1.0e-6))

    }
    
    @Test
    func
        sampleRateEightTimesTheFrequency_nextSample_calculatesValuesBetweenExtremes()
        async throws
    {
        var sineWave = SineWave(sampleRate: 8, frequency: 1)
        #expect(sineWave.nextSample() == sin(0))
        #expect(sineWave.nextSample() == sin(Float.pi / 4.0))
        #expect(sineWave.nextSample() == sin(Float.pi / 2.0))
        #expect(sineWave.nextSample() == sin((3 * Float.pi) / 4.0))
        #expect(sineWave.nextSample() == sin(Float.pi))

    }
    
    
}
