//
//  ImageViewController.swift
//  Cassini
//
//  Created by Andrij Trubchanin on 4/6/17.
//  Copyright © 2017 Andrij Trubchanin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                // don't fetch any if MVC is not on the screen
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            if let urlContents = try? Data(contentsOf: url) {
                image = UIImage(data: urlContents)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageURL = DemoURL.stanford
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    private var imageView = UIImageView()   //frame: CGRect.zero by default
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
}
