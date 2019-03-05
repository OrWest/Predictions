import UIKit

class PredictionResultsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let adapter = PredictionsResultsTableAdapter()
    var predictions: [Prediction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        loadResults()
    }

    private func configureUI() {
        tableView.dataSource = adapter
        tableView.delegate = adapter
    }

    private func loadResults() {
        AppDelegate.getNetwork().loadResults(success: { [weak self] results in
            guard let `self` = self else { return }

            self.adapter.results = self.prepareResults(results)
            self.tableView.reloadData()

        }, failure: { [weak self] error in
            guard let `self` = self else { return }

            AlertPresenter.showError(text: error.localizedDescription, context: self)
        })
    }

    private func prepareResults(_ results: [MatchResult]) -> [PredictionResult] {
        let newResults = results.map { PredictionResult(result: $0) }

        for result in newResults {
            let team1 = result.match.team1
            let team2 = result.match.team2
            if let prediction = predictions.first(where: { $0.match.team1 == team1 && $0.match.team2 == team2 }) {
                result.predictedTeam1Score = prediction.team1Score
                result.predictedTeam2Score = prediction.team2Score
            }
        }

        return newResults
    }

    @IBAction private func closeAction() {
        AppDelegate.getRouter().showPredictionsMake()
    }
    
}
