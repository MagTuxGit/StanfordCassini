//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Andrij Trubchanin on 4/6/17.
//  Copyright © 2017 Andrij Trubchanin. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination.contents
        if let imageVC = destinationVC as? ImageViewController,
            let identifier = segue.identifier,
            let imageURL = DemoURL.NASA[identifier] {
            imageVC.imageURL = imageURL
            imageVC.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let imageVC = secondaryViewController.contents as? ImageViewController, imageVC.imageURL == nil {
                // I say I want to collapse it but I don't do it really, so no collapse happens
                return true
            }
        }
        return false
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
