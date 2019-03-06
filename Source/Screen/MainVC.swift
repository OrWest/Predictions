import UIKit

class MainVC: UIViewController {
    private let labelAnimationDuration = 0.8
    private let navigationBarAnimationDuration = 0.5

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var navigationBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateLabel()
    }

    private func animateLabel() {
        UIView.animate(withDuration: labelAnimationDuration, animations: {
            let scaleTransform = CGAffineTransform(scaleX: 18.4 / 50.0, y: 17.5 / 50.0)
            let translateTransform = CGAffineTransform(translationX: 0, y: self.navigationBar.center.y - self.titleLabel.center.y)
            self.titleLabel.transform = scaleTransform.concatenating(translateTransform)
        }, completion: { _ in
            UIView.animate(withDuration: self.navigationBarAnimationDuration, animations: {
                self.navigationBar.alpha = 1.0
            }, completion: { _ in
                AppDelegate.getRouter().showPredictionsMake(animated: false)
            })
        })
    }
}
