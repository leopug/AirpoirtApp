//
//  Coordinator.swift
//  AirpoirtApp
//
//  Created by Leonardo Maia Pugliese on 29/04/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UIViewController? { get set }
    func start() -> UIViewController
}
