import UIKit

class PredictionMakeCell: UITableViewCell {
    static let identifier = "PredictionMake"
    static let height: CGFloat = 74.0

    @IBOutlet private weak var team1Label: UILabel!
    @IBOutlet private weak var team2Label: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    func configure(prediction: Prediction) {
        team1Label.text = prediction.match.team1
        team2Label.text = prediction.match.team2

        scoreLabel.text = Formatter.formatScore(part1: prediction.team1Score, part2: prediction.team2Score)
    }
}
