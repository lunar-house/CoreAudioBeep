import Foundation
import AVFoundation

class Beep {
    let engine = AVAudioEngine()
    var sourceNode: AVAudioSourceNode!
    
    init() {
        let sampleRate = 44100.0
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)
        
        sourceNode = AVAudioSourceNode {_, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            for frame in 0..<Int(frameCount) {
                let sample = Float.random(in: -1.0...1.0)
                for buffer in ablPointer {
                    let buf = UnsafeMutableBufferPointer<Float>(start: UnsafeMutablePointer(buffer.mData!.assumingMemoryBound(to: Float.self)), count: Int(frameCount))
                    buf[frame] = sample
                }
            }
            return noErr
        }
        
        engine.attach(sourceNode)
        engine.connect(sourceNode, to: engine.mainMixerNode, format: format)
    }
    
    func start() -> String {
        do {
            try engine.start()
        }
        catch {
            print("Engine failed to start: \(error)" )
        }
        return "Playing beep"
    }
    
    func stop() {
        engine.stop()
    }
}
