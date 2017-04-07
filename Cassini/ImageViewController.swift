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
            scrollView.maximumZoomScale = 1.0
            scrollView.minimumZoomScale = 0.03
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            // fetching data blocks UI so do it in global thread
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                // fetch data, additionally check whether url is a current imageURL
                if let urlContents = try? Data(contentsOf: url), url == self?.imageURL {
                    // UI stuff put back on the main queue
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: urlContents)
                    }
                }
            }
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imageURL = DemoURL.stanford
//    }
    
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
            // can be executed in viewDidLoad when outlets are not set yet, so put ? after outlets
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
