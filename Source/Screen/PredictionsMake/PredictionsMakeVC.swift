import UIKit

class PredictionsMakeViewController: UIViewController, PredictionsMakeAdapterDelegate {
// TODO: show button and bar animated

    private enum ValidationError: Error {
        case emptyScore(Match)
        case emptyScoreForTeam(errorTeam: String, vsTeam: String)
    }

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var predictedCountLabel: UILabel!

    private let adapter = PredictionsMakeAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        loadMatches()
    }

    private func configureUI() {
        adapter.delegate = self

        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.tableFooterView = UIView()

        predictedCountLabel.text = nil
    }

    private func loadMatches() {
        tableView.showLoader()

        AppDelegate.getNetwork().loadMatches(success: { [weak self] matches in
            self?.adapter.predictions = matches.map { Prediction(match: $0) }
            self?.updatePredictedCounter()
            self?.tableView.hideLoader()
            self?.tableView.reloadData()
        }, failure: { [weak self] error in
            guard let `self` = self else { return }

            self.tableView.hideLoader()
            AlertPresenter.showError(text: error.localizedDescription, context: self)
        })
    }

    private func updatePredictedCounter() {
        let predicted = adapter.predictions.filter { $0.team1Score != nil && $0.team2Score != nil }.count
        predictedCountLabel.text = "\(predicted)/\(adapter.predictions.count)"
    }

    func predictionWasSelected(prediction: Prediction) {
        AppDelegate.getRouter().presentScorePicker(prediction: prediction, context: self) { [unowned self] in
            self.updatePredictedCounter()
            self.tableView.reloadData()
        }
    }

    @IBAction private func autofillAction() {
        for prediction in adapter.predictions {
            prediction.team1Score = Int.random(max: ScorePickerViewController.maxScore)
            prediction.team2Score = Int.random(max: ScorePickerViewController.maxScore)
        }
        updatePredictedCounter()
        tableView.reloadData()
    }

    @IBAction private func makePredictionsAction() {
        do {
            try validatePredictions()

            AppDelegate.getRouter().showPredictionsResults(predictions: adapter.predictions)
        } catch ValidationError.emptyScore(let match) {
            let text = String(format: "prediction_make_validation_empty_score".localized, match.team1, match.team2)
            AlertPresenter.showError(text: text, context: self)
        } catch ValidationError.emptyScoreForTeam(let errorTeam, let vsTeam) {
            let text = String(format: "prediction_make_validation_empty_score_for_team".localized, errorTeam, vsTeam)
            AlertPresenter.showError(text: text, context: self)
        } catch {
            AlertPresenter.showError(text: "Unknown error", context: self)
        }
    }

    private func validatePredictions() throws {
        if let emptyScorePrediction = adapter.predictions.first(where: { $0.team1Score == nil && $0.team2Score == nil }) {
            throw ValidationError.emptyScore(emptyScorePrediction.match)
        }

        if let notFullScorePrediction = adapter.predictions.first(where: { $0.team1Score == nil || $0.team2Score == nil }) {
            let match = notFullScorePrediction.match
            if notFullScorePrediction.team1Score == nil {
                throw ValidationError.emptyScoreForTeam(errorTeam: match.team1, vsTeam: match.team2)
            } else {
                throw ValidationError.emptyScoreForTeam(errorTeam: match.team2, vsTeam: match.team1)
            }
        }
    }
}

