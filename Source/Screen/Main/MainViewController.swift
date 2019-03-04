import UIKit

class MainViewController: UIViewController {
    private var router: Router {
        return AppDelegate.getRouter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        router.showPredictionsMake()
    }
}
