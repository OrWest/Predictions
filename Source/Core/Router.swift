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

    func showPredictionsResults(predictions: [Prediction]) {
        switchToVC(.predictionsResults) { vc in
            guard let controller = vc as? PredictionResultsViewController else {
                return
            }

            controller.predictions = predictions
        }
    }

    func presentScorePicker(prediction: Prediction, context: UIViewController, dismissAction: @escaping () -> Void) {
        let vc = storyboard.instantiateViewController(withIdentifier: Screen.scorePicker.rawValue) as! ScorePickerViewController
        vc.prediction = prediction
        vc.dismissAction = dismissAction

        vc.modalPresentationStyle = .overFullScreen
        context.present(vc, animated: false)
    }

    private func switchToVC(_ screen: Screen, setup: ((UIViewController) -> Void)? = nil ) {
        guard let window = window else { return }

        let vc = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        setup?(vc)
        UIView.transition(with: window, duration: animationDuration, options: [.transitionFlipFromRight, .allowAnimatedContent], animations: {
            self.window?.rootViewController = vc
        }, completion:nil)
    }
}
