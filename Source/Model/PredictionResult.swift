import Foundation

class PredictionResult {

    let match: Match
    let resultTeam1Score: Int
    let resultTeam2Score: Int

    var predictedTeam1Score: Int? = nil
    var predictedTeam2Score: Int? = nil

    var isCorrectPrediction: Bool? {
        guard let predictedTeam1Score = predictedTeam1Score, let predictedTeam2Score = predictedTeam2Score else {
            return nil
        }
        return resultTeam1Score == predictedTeam1Score && resultTeam2Score == predictedTeam2Score
    }

    init(result: MatchResult) {
        match = Match(team1: result.team1, team2: result.team2)
        
        resultTeam1Score = result.team1Score
        resultTeam2Score = result.team2Score
    }

}
