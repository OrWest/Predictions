import Foundation

class Prediction {
    let match: Match
    var team1Score: Int?
    var team2Score: Int?

    init(match: Match) {
        self.match = match
    }

}
