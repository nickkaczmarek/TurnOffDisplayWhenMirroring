import TurnOffDisplayWhenMirroringCore

let turnOff = TurnOffDisplayWhenMirroring()

do {
    try turnOff.run()
} catch {
    print("Something went wrong trying to turn off: \(error)")
}
