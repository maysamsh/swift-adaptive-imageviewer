//
//  ViewController.swift
//  adaptiveScrollViewWithImage
//
//  Created by Maysam Shahsavari on 8/19/19.
//  Copyright © 2019 Maysam Shahsavari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupViews()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let image = UIImage(named: "image.jpg") {
            scrollView.contentSize = image.size
            imageView.image = image
            let minZoom = min(self.view.bounds.size.width / image.size.width, self.view.bounds.size.height / image.size.height)
            self.scrollView.minimumZoomScale = minZoom
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let vertical = (self.view.bounds.size.height - (image.size.height * minZoom)) / 2
                self.scrollView.contentInset = UIEdgeInsets(top: vertical, left: 0, bottom: vertical, right: 0)
                self.scrollView.setZoomScale(minZoom, animated: true)
            }
        }
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.minimumZoomScale = 0.2
    }
    
    func setupViews(){
        contentView.backgroundColor = UIColor.red
        scrollView.addSubview(imageView)
    }
    
    func centerContent() {
        var top: CGFloat = 0
        var left: CGFloat = 0
        if scrollView.contentSize.width < scrollView.bounds.size.width {
            left = (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5
        }
        if scrollView.contentSize.height < scrollView.bounds.size.height {
            top = (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5
        }
        scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
    }
    
    let imageView: UIImageView = {
        let _imageView = UIImageView()
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return _imageView
    }()

}

extension ViewController: UIScrollViewDelegate {
   
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerContent()
    }
}
