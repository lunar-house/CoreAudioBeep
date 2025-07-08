import Foundation

class SquareWave: Wave {

    var sampleRate: Float
    var phase: Float = 1.0
    var frequency: Float

    init(sampleRate: Float, frequency: Float) {
        self.sampleRate = sampleRate
        self.frequency = frequency
    }

    func nextSample(phase: Float) -> Float {
        return sin(phase) > 0 ? 1.0 : -1.0
    }
}
