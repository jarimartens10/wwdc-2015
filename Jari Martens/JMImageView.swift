//
//  JMImageView.swift
//  Jari Martens
//
//  Created by Jari Martens on 14-04-15.
//  Copyright (c) 2015 Jari Martens. All rights reserved.
//

import UIKit

 protocol JMImageViewDelegate: JTSImageViewControllerInteractionsDelegate{
    func didTapImageView(imageView: JMImageView)
}

final class JMImageView: UIImageView {
    var delegate: JMImageViewDelegate?
    private var tapGesture: UITapGestureRecognizer?
    
    override init(image: UIImage!) {
        super.init(image: image)
        userInteractionEnabled = true
        setupTapGestureRecognizer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled = true
        setupTapGestureRecognizer()
    }

    required convenience init(coder aDecoder: NSCoder) {
        let image = UIImage(named: "backgroundImage")!
        self.init(image: image)
    }
    
    private func setupTapGestureRecognizer() {
        tapGesture = UITapGestureRecognizer(target: self, action: "didTapImage")
        addGestureRecognizer(tapGesture!)
    }
    
    func didTapImage(){
        delegate?.didTapImageView(self)
    }
}
