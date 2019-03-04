import Foundation

struct MatchesResults: Codable {
    let results: [MatchResult]
    
    enum CodingKeys: String, CodingKey {
        case results = "matches"
    }
}

struct MatchResult: Codable {
    let team1: String
    let team2: String
    let team1Points: Int
    let team2Points: Int
    
    enum CodingKeys: String, CodingKey {
        case team1
        case team2
        case team1Points = "team1_points"
        case team2Points = "team2_points"
    }
}
