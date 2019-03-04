import UIKit

class PredictionsMakeViewController: UIViewController, PredictionsMakeAdapterDelegate {
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
        router.presentScorePicker(prediction: prediction, context: self)
    }

    @IBAction private func makePredictionsAction() {

    }

    private func validatePredictions() throws {

    }
}

