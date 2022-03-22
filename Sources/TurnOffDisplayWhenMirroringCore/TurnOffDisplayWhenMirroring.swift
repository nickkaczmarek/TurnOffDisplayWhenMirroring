import Foundation
import AppKit
import CoreGraphics

extension NSScreen {
    class func externalScreens() -> [NSScreen] {
        let screens = NSScreen.screens
        let description: NSDeviceDescriptionKey = NSDeviceDescriptionKey(rawValue: "NSScreenNumber")

        return screens.filter {
            guard let deviceID = $0.deviceDescription[description] as? NSNumber else { return false }
            return CGDisplayIsBuiltin(deviceID.uint32Value) == 0
        }
    }
}

public final class TurnOffDisplayWhenMirroring {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {
        guard arguments.count > 1 else {
            throw Error.missingBrightness
        }

        if isDisplayMirroring() && isConnectedToMonitor() {
            _ = shell("/usr/local/bin/brightness \(arguments[1])")
        }
    }

    private func isDisplayMirroring() -> Bool {
        CGDisplayIsInMirrorSet(CGMainDisplayID()) == 1
    }

    private func isConnectedToMonitor() -> Bool {
        NSScreen.externalScreens().count > 0
    }

    private func shell(_ command: String) -> String {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String

        return output
    }
}

public extension TurnOffDisplayWhenMirroring {
    enum Error: Swift.Error {
        case missingBrightness
    }
}
