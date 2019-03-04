import UIKit

class PredictionsMakeAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {

    var predictions: [Prediction] = []
    var delegate: PredictionsMakeAdapterDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PredictionMakeCell.identifier) as! PredictionMakeCell

        cell.configure(prediction: predictions[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        delegate?.predictionWasSelected(prediction: predictions[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PredictionMakeCell.height
    }
}

protocol PredictionsMakeAdapterDelegate: class {
    func predictionWasSelected(prediction: Prediction)
}
