//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Andrij Trubchanin on 4/6/17.
//  Copyright © 2017 Andrij Trubchanin. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination.contents
        if let imageVC = destinationVC as? ImageViewController,
            let identifier = segue.identifier,
            let imageURL = DemoURL.NASA[identifier] {
            imageVC.imageURL = imageURL
            imageVC.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navigationVC = self as? UINavigationController {
            return navigationVC.visibleViewController ?? self
        }
        return self
    }
}
