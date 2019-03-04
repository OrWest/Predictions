import Foundation

class Formatter {
    private static let scorePlaceholder = "-"

    static func formatScore(part1: Int?, part2: Int?) -> String {
        var part1String = scorePlaceholder
        if let part1 = part1 {
            part1String = String(part1)
        }
        var part2String = scorePlaceholder
        if let part2 = part2 {
            part2String = String(part2)
        }

        return part1String + " : " + part2String
    }

}
