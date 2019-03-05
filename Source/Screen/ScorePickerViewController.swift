import UIKit

class ScorePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private let appearDisappearDuration = 0.2
    private let hideTransform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    private let emptyScorePlaceholder = "-"
    static let maxScore = 99

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var darkView: UIView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var team1Label: UILabel!
    @IBOutlet private weak var team2Label: UILabel!
    @IBOutlet private weak var team1ScorePicker: UIPickerView!
    @IBOutlet private weak var team2ScorePicker: UIPickerView!

    var prediction: Prediction!
    var dismissAction: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    private func configureUI() {
        contentView.layer.cornerRadius = 4.0
        team1Label.text = prediction.match.team1
        team2Label.text = prediction.match.team2

        contentView.layer.cornerRadius = 8.0

        shadowView.layer.cornerRadius = contentView.layer.cornerRadius
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowOffset = CGSize(width: 1, height: 2)
    }

    private func appearContainerAndDarkView() {
        darkView.alpha = 0.0
        containerView.transform = hideTransform

        UIView.animate(withDuration: appearDisappearDuration) {
            self.darkView.alpha = 1.0
            self.containerView.transform = .identity
        }
    }

    private func disappearController() {

        UIView.animate(withDuration: appearDisappearDuration, animations: {
            self.darkView.alpha = 0.0
            self.containerView.transform = self.hideTransform
        }, completion: { [weak self] _ in
            self?.dismissAction?()
            self?.dismiss(animated: false)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let score1 = prediction.team1Score {
            team1ScorePicker.selectRow(score1 + 1, inComponent: 0, animated: false)
        }

        if let score2 = prediction.team2Score {
            team2ScorePicker.selectRow(score2 + 1, inComponent: 0, animated: false)
        }

        appearContainerAndDarkView()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ScorePickerViewController.maxScore + 2 // 0 + '-'
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = row == 0 ? emptyScorePlaceholder : String(row - 1)
        label.font = UIFont.systemFont(ofSize: 50.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }

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
        disappearController()
    }
}
