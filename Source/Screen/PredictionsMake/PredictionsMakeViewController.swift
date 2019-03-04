import UIKit

class PredictionsMakeViewController: UIViewController, PredictionsMakeAdapterDelegate {
    private var network: NetworkManager {
        return AppDelegate.getNetwork()
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
        tableView.dataSource = adapter
        tableView.delegate = adapter
        tableView.tableFooterView = UIView()
    }

    private func loadMatches() {
        network.loadMatches(success: { [weak self] matches in
            self?.adapter.predictions = matches.map { Prediction(match: $0) }
            self?.adapter.predictions.append(contentsOf: matches.map { Prediction(match: $0) })
            self?.tableView.reloadData()
        }, failure: { [weak self] error in
            guard let `self` = self else { return }
        
            AlertPresenter.showError(text: error.localizedDescription, context: self)
        })
    }

    func predictionWasSelected(prediction: Prediction) {

    }

    @IBAction private func makePredictionsAction() {

    }

    private func validatePredictions() throws {

    }
}

