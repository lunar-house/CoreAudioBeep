import AVFoundation
import Foundation

class Beep {

    let engine = AVAudioEngine()
    var noiseNode: AVAudioSourceNode!
    var binauralNode: AVAudioSourceNode!
    var squareNode: AVAudioSourceNode!
    var noiseMixer = AVAudioMixerNode()
    var binauralMixer = AVAudioMixerNode()
    var squareMixer = AVAudioMixerNode()

    let sampleRate: Double = 44100.0
    init() {
        let format = AVAudioFormat(
            standardFormatWithSampleRate: sampleRate,
            channels: 2
        )!

        // Move the logic out of the initialiser
        noiseNode = createNoiseNode()
//        
//        let freqL: Float = 140  // Left ear frequency (Hz)
//        let freqR: Float = 144  // Right ear frequency (Hz)
//
        
        let leftSineWave = SineWave(sampleRate: Float(sampleRate), frequency: 140.00)
        let rightSineWave = SineWave(sampleRate: Float(sampleRate), frequency: 144.00)


        binauralNode = createAudioSourceNode(rightWave: rightSineWave, leftWave: leftSineWave)

//        squareNode = createSquareWaveNode()
        let squareWave = SquareWave(sampleRate: Float(sampleRate), frequency: 70.0)
        squareNode = createAudioSourceNode(rightWave: squareWave, leftWave: squareWave)
        

        // connect the nodes to mixers, then conect the mixers to the engine
        attachAudionodeToEngine(
            audioNode: noiseNode,
            mixer: noiseMixer,
            format: format
        )

        attachAudionodeToEngine(
            audioNode: binauralNode,
            mixer: binauralMixer,
            format: format
        )

        attachAudionodeToEngine(
            audioNode: squareNode,
            mixer: squareMixer,
            format: format
        )

        // start the engine on initialising (this can be moved out of here too)
        do {
            try engine.start()
        } catch {
            print("Engine failed to start: \(error)")
        }
    }

    func attachAudionodeToEngine(
        audioNode: AVAudioNode,
        mixer: AVAudioMixerNode,
        format: AVAudioFormat
    ) {
        // Previously we attached a single node to the engine's main mixer
        // But if we have multiple nodes all connected to the main mixer we can't control output separately
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
        // Create an AVAudioSourceNode that generates white noise
        // We create this with a callback (the "Render block")
        // The audio engine will repeatedly call this block when it needs more data
        // At this point, we create a node that describes how to generate audio data
        // but no data is created yet - the engine generates this at run time
        return AVAudioSourceNode {
            _,
            _,
            frameCount,
            audioBufferList -> OSStatus in
            // ablPointer will contain a buffer for each channel
            // the channels are specifed in the AVAudioFormat that we pass to the engine
            // The engine will tell this node how many channels it has at runtime
            let ablPointer = UnsafeMutableAudioBufferListPointer(
                audioBufferList
            )

            // 2. Loop through each buffer (e.g., left and right channels for stereo)
            for buffer in ablPointer {
                // 3. Get a pointer to the buffer's memory as an array of Float samples
                let samples = buffer.mData?.bindMemory(
                    to: Float.self,
                    capacity: Int(frameCount)
                )

                // 4. For each frame (sample) in the buffer...
                for frame in 0..<Int(frameCount) {
                    // 5. ...write a random value between -1.0 and 1.0 (white noise)
                    samples?[frame] = Float.random(in: -1.0...1.0) * 0.2  // Lower volume
                }
            }
            // 6. Return noErr (0) to indicate success
            return noErr
        }
    }
    
    func createAudioSourceNode(rightWave: Wave, leftWave: Wave) -> AVAudioSourceNode {
        
        var rightWave = rightWave
        var leftWave = leftWave
        return AVAudioSourceNode {
            _,
            _,
            frameCount,
            audioBufferList -> OSStatus in
            let ablPointer = UnsafeMutableAudioBufferListPointer(
                audioBufferList
            )
            guard ablPointer.count == 2 else { return noErr }

            let left = ablPointer[0].mData?.bindMemory(
                to: Float.self,
                capacity: Int(frameCount)
            )
            let right = ablPointer[1].mData?.bindMemory(
                to: Float.self,
                capacity: Int(frameCount)
            )
            for frame in 0..<Int(frameCount) {
                left?[frame] = leftWave.nextSample()
                right?[frame] = rightWave.nextSample()
            }
            return noErr
        }
    }

    // When we had only one node we controlled output by starting and stopping the engine\
    // Doing so would start and stop all nodes
    // We want to use only one engine, since  multiple engines will compete for audio resources, memory and CPU usage
    // So now we attach nodes to individual mixers and control their volume to "start" and "stop" them

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

    func startSquare() {
        squareMixer.outputVolume = 1.0
    }

    func stopSquare() {
        squareMixer.outputVolume = 0.0
    }
}
