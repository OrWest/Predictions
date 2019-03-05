import UIKit

class PredictionsMakeViewController: UIViewController, PredictionsMakeAdapterDelegate {

    private enum ValidationError: Error {
        case emptyScore(Match)
        case emptyScoreForTeam(errorTeam: String, vsTeam: String)
    }

    private var network: NetworkManager {
        return AppDelegate.getNetwork()
    }
    private var router: Router {
        return AppDelegate.getRouter()
    }

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var navigationBar: UINavigationBar!

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
    }

    private func loadMatches() {
        network.loadMatches(success: { [weak self] matches in
            self?.adapter.predictions = matches.map { Prediction(match: $0) }
            self?.tableView.reloadData()
        }, failure: { [weak self] error in
            guard let `self` = self else { return }
        
            AlertPresenter.showError(text: error.localizedDescription, context: self)
        })
    }

    func predictionWasSelected(prediction: Prediction) {
        router.presentScorePicker(prediction: prediction, context: self) { [unowned self] in
            self.tableView.reloadData()
        }
    }

    @IBAction private func autofillAction() {
        for prediction in adapter.predictions {
            prediction.team1Score = Int.random(max: ScorePickerViewController.maxScore)
            prediction.team2Score = Int.random(max: ScorePickerViewController.maxScore)
        }
        tableView.reloadData()
    }

    @IBAction private func makePredictionsAction() {
        do {
            try validatePredictions()

            router.showPredictionsResults(predictions: adapter.predictions)
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

