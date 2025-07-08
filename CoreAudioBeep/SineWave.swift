import Foundation

class SineWave: Wave {

    var sampleRate: Float
    var phase: Float = 0.0
    var frequency: Float

    init(sampleRate: Float, frequency: Float) {
        self.sampleRate = sampleRate
        self.frequency = frequency
    }

    func nextSample(phase: Float) -> Float {
        return sin(phase);
    }
}
