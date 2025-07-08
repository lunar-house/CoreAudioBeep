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

    @Test func sampleRateOf2AndFrequency1_nextSample_oscillatesBetweenExtremes()
        async throws
    {
        var squareWave = SquareWave(sampleRate: 2, frequency: 1)
        #expect(squareWave.nextSample() == 1.0)
        #expect(squareWave.nextSample() == -1.0)
        #expect(squareWave.nextSample() == 1.0)
        #expect(squareWave.nextSample() == -1.0)
    }

    @Test
    func
        sampleRateDoubleTheFrequency_nextSample_oscillatesBetweenExtremesEveryOtherTime()
        async throws
    {
        var squareWave = SquareWave(sampleRate: 12, frequency: 3)
        #expect(squareWave.nextSample() == 1.0)
        #expect(squareWave.nextSample() == 1.0)
        #expect(squareWave.nextSample() == -1.0)
        #expect(squareWave.nextSample() == -1.0)
        #expect(squareWave.nextSample() == 1.0)
        #expect(squareWave.nextSample() == 1.0)
    }

}
