//
//  SigninHeaderView.swift
//  InstagramClone
//
//  Created by Dariy Kutelov on 27.12.21.
//

import UIKit

class SigninHeaderView: UIView {
    private var gradientLayer: CALayer?
    
    //Anonymous closure pattern
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "text_logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        createGradient()
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = layer.bounds //takes whole layer areas
        imageView.frame = CGRect(x: width/4, y: 20, width: width/2, height: height-40)
    }
    
    private func createGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        //gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }
}
