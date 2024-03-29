#!/usr/bin/env swift

import Foundation

let shouldPrint = true
@discardableResult
func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    if shouldPrint {
        print(output)
    }
    return output
}

shell("export PATH=\"/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin\"")
shell("echo \"Start SwiftFormat.swift script\"")
shell("git diff --diff-filter=d --staged --name-only --output gitDiff")
shell("""
    IFS=$'\n'
    for line in $(grep -e '\\.swift$' gitDiff); do
        swiftformat --swiftversion 5.9 -disable wrapMultilineStatementBraces -disable enumnamespaces "$line"
        git add "$line"
    done
    """
)
shell("rm gitDiff")
