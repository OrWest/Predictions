import Foundation
import Alamofire

struct MatchesInfo: Codable {
    let matches: [Match]
}

struct Match: Codable {
    let team1: String
    let team2: String
}
