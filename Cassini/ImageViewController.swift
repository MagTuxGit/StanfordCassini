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
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
            scrollView.maximumZoomScale = 5.0
            scrollView.minimumZoomScale = 0.5
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
        imageURL = DemoURL.stanford
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    // fileprivate allows the extension to use this
    fileprivate var imageView = UIImageView()   //frame: CGRect.zero by default
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // can be executed in viewDidLoad when outlet scrollView is not set yet
            scrollView?.contentSize = imageView.frame.size
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
