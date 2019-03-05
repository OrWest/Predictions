import UIKit

class MainVC: UIViewController {
    private let animationDuration = 0.5

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var navigationBar: UINavigationBar!

    @objc func injected() {
        titleLabel.transform = .identity

        animateLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        animateLabel()
    }

    private func animateLabel() {
        UIView.animate(withDuration: animationDuration, animations: {
            let scaleTransform = CGAffineTransform(scaleX: 18.4 / 50.0, y: 17.5 / 50.0)
            let translateTransform = CGAffineTransform(translationX: 0, y: self.navigationBar.center.y - self.titleLabel.center.y)
            self.titleLabel.transform = scaleTransform.concatenating(translateTransform)
        }, completion: { _ in
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.navigationBar.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: self.animationDuration) {
                    self.navigationBar.alpha = 1.0
                }
                AppDelegate.getRouter().showPredictionsMake(animated: false)
            })
        })
    }
}
