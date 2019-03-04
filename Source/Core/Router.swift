import UIKit

class Router {
    private let animationDuration = 0.5

    private enum Screen: String {
        case predictionsMake
        case predictionsResults
        case scorePicker
    }

    private weak var window: UIWindow?
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)

    init(window: UIWindow) {
        self.window = window
    }

    func showPredictionsMake() {
        switchToVC(.predictionsMake)
    }

    func showPredictionsResults() {
        switchToVC(.predictionsResults)
    }

    func presentScorePicker(prediction: Prediction, context: UIViewController) {
        let vc = storyboard.instantiateViewController(withIdentifier: Screen.scorePicker.rawValue) as! ScorePickerViewController
        vc.prediction = prediction

        vc.modalPresentationStyle = .overFullScreen
        context.present(vc, animated: false)
    }

    private func switchToVC(_ screen: Screen) {
        guard let window = window else { return }

        let vc = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        UIView.transition(with: window, duration: animationDuration, options: [.transitionFlipFromRight, .allowAnimatedContent], animations: {
            self.window?.rootViewController = vc
        }, completion:nil)
    }
}
