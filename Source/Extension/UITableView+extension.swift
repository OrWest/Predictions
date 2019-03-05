import UIKit

extension UITableView {

    func showLoader() {
        let loader = UIActivityIndicatorView(style: .gray)
        loader.startAnimating()
        backgroundView = loader
    }

    func hideLoader() {
        backgroundView = nil
    }

}