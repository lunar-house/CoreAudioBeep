import Testing

@testable import CoreAudioBeep

struct BeepTests {

    @Test func testSomething() async throws {
        let beep = Beep()

        #expect(beep.start() == "Playing beep")
    }
}
