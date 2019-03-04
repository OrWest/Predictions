import UIKit

class ScorePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private let emptyScorePlaceholder = "-"
    private let maxScore = 99

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var team1Label: UILabel!
    @IBOutlet private weak var team2Label: UILabel!
    @IBOutlet private weak var team1ScorePicker: UIPickerView!
    @IBOutlet private weak var team2ScorePicker: UIPickerView!

    var prediction: Prediction!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        contentView.layer.cornerRadius = 4.0
        team1Label.text = prediction.match.team1
        team2Label.text = prediction.match.team2
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxScore + 1
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? emptyScorePlaceholder : String(row - 1)
    }

//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        fatalError("pickerView(_:attributedTitleForRow:forComponent:) has not been implemented")
//    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let newValue: Int?
        if row == 0 {
            newValue = nil
        } else {
            newValue = row - 1
        }

        if pickerView == team1ScorePicker {
            prediction.team1Score = newValue
        } else {
            prediction.team2Score = newValue
        }
    }

    @IBAction private func closeAction() {
        dismiss(animated: false)
    }
}
