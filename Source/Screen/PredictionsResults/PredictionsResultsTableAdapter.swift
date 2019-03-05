import UIKit

class PredictionsResultsTableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {

    var results: [PredictionResult] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PredictionResultCell.identifier) as! PredictionResultCell

        cell.configure(result: results[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PredictionResultCell.height
    }
}
