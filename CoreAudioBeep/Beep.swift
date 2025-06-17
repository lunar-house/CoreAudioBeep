import Foundation
import AVFoundation

class Beep {
    let engine = AVAudioEngine()
    var noiseNode: AVAudioSourceNode!
    var binauralNode: AVAudioSourceNode!
    var noiseMixer = AVAudioMixerNode()
    var binauralMixer = AVAudioMixerNode()
    
    let sampleRate = 44100.0
    init() {
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 2)!
        
        // White noise node (stereo)
        noiseNode = createNoiseNode()
        binauralNode = createBinauralNode()
        
     
        attachAudionodeToEngine(audioNode: noiseNode, mixer: noiseMixer, format: format)
       
        attachAudionodeToEngine(audioNode: binauralNode, mixer: binauralMixer, format: format)
        do {
            try engine.start()
        }
        catch {
            print("Engine failed to start: \(error)" )
        }
    }
    
    func attachAudionodeToEngine(audioNode: AVAudioNode, mixer: AVAudioMixerNode, format: AVAudioFormat) {
        // We can't stop and start nodes without stopping and starting the engine
        // We should use only one engine - multiple engines will compete for audio resources, memory and CPU usage
        // So we attach each node to its own mixer, then connect that to the engine's mainMixerNode
        // We can then control the node's volume independently of other nodes
        
        // Attach the node to the engine
        engine.attach(audioNode)
        
        // Attach the node's mixer to the engine
        engine.attach(mixer)
        
        // Connect the node to its mixer
        engine.connect(audioNode, to: mixer, format: format)
        
        // Connect the mixer to the engine's mainMixer
        engine.connect(mixer, to: engine.mainMixerNode, format: format)

        // set the node mixer's volume to 0.0 since we're currently starting the engine in the initialiser
        mixer.outputVolume = 0.0
    }
    
    func createNoiseNode() -> AVAudioSourceNode {
        
        // Create an AVAUdioSourceNode that generates white noise
        return AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            for buffer in ablPointer {
                let samples = buffer.mData?.bindMemory(to: Float.self, capacity: Int(frameCount))
                for frame in 0..<Int(frameCount) {
                    samples?[frame] = Float.random(in: -1.0...1.0) * 0.2 // Lower volume
                }
            }
            return noErr
        }
        
    }
    
    func createBinauralNode() -> AVAudioSourceNode {
        
        // Create an AVAudioSourceNode that creates a binaural tone
        // Binaural tone node (stereo)
        var phaseL: Float = 0
        var phaseR: Float = 0
        let freqL: Float = 140      // Left ear frequency (Hz)
        let freqR: Float = 144      // Right ear frequency (Hz)
        let twoPi = 2 * Float.pi
        
        return AVAudioSourceNode { _, _, frameCount, audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            guard ablPointer.count == 2 else { return noErr }
            let left = ablPointer[0].mData?.bindMemory(to: Float.self, capacity: Int(frameCount))
            let right = ablPointer[1].mData?.bindMemory(to: Float.self, capacity: Int(frameCount))
            for frame in 0..<Int(frameCount) {
                left?[frame] = sin(phaseL) * 0.1
                right?[frame] = sin(phaseR) * 0.1
                phaseL += twoPi * freqL / Float(self.sampleRate)
                phaseR += twoPi * freqR / Float(self.sampleRate)
                if phaseL > twoPi { phaseL -= twoPi }
                if phaseR > twoPi { phaseR -= twoPi }
            }
            return noErr
        }
    }

    // Instead of starting and stopping the engine,
    // Change the volume of the custom mixers
    
    func startNoise() {
        noiseMixer.outputVolume = 0.5

    }
    
    func stopNoise() {
        noiseMixer.outputVolume = 0.0
    }
    
    func startBinaural() {
        binauralMixer.outputVolume = 1.0
    }
    
    func stopBinaural() {
        binauralMixer.outputVolume = 0.0
    }
}
