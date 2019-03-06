import UIKit

class PredictionResultCell: UITableViewCell {
    static let identifier = "PredictionResult"
    static let height: CGFloat = 93.0

    private let correctPredictionColor = UIColor(red: 52.0/255.0, green: 179.0/255.0, blue: 75.0/255.0, alpha: 1.0)
    private let incorrectPredictionColor = UIColor.red
    private let defaultPredictionColor = UIColor.lightGray

    @IBOutlet private weak var roundContentView: UIView!
    @IBOutlet private weak var team1Label: UILabel!
    @IBOutlet private weak var team2Label: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var predictedScoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        roundContentView.layer.cornerRadius = 4.0
        roundContentView.layer.borderWidth = 2.0
        roundContentView.layer.shadowOffset = .zero
        roundContentView.layer.shadowOpacity = 0.1
        roundContentView.layer.shadowRadius = 5
        roundContentView.layer.shadowColor = UIColor.black.cgColor
    }

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
            roundContentView.layer.borderColor = (isCorrectPrediction ? correctPredictionColor : .white).cgColor
        } else {
            predictedScoreLabel.textColor = defaultPredictionColor
            roundContentView.layer.borderColor = UIColor.white.cgColor
        }
    }
}
