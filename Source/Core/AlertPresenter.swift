import UIKit

class AlertPresenter {
    private static let errorTitle = "Error"
    
    static func showError(text: String, context: UIViewController) {
        let alertController = UIAlertController(title: errorTitle, message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default)
        context.present(alertController, animated: true)
    }
    
}
