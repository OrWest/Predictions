import UIKit

class PredictionResultCell: UITableViewCell {
    static let identifier = "PredictionResult"
    static let height: CGFloat = 74.0

    private let correctPredictionColor = UIColor.green
    private let incorrectPredictionColor = UIColor.red
    private let defaultPredictionColor = UIColor.lightGray

    @IBOutlet private weak var team1Label: UILabel!
    @IBOutlet private weak var team2Label: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var predictedScoreLabel: UILabel!

    func configure(result: PredictionResult) {
        team1Label.text = result.match.team1
        team2Label.text = result.match.team2

        scoreLabel.text = Formatter.formatScore(
                part1: result.resultTeam1Score,
                part2: result.resultTeam2Score
        )
        predictedScoreLabel.text = Formatter.formatScore(
                part1: result.predictedTeam1Score,
                part2: result.predictedTeam2Score
        )

        if let isCorrectPrediction = result.isCorrectPrediction {
            predictedScoreLabel.textColor = isCorrectPrediction ? correctPredictionColor : incorrectPredictionColor
        } else {
            predictedScoreLabel.textColor = defaultPredictionColor
        }
    }
}
