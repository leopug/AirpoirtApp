//
//  UIViewController+Extension.swift
//  AirportApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
