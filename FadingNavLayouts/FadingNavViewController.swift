//
//  ViewController.swift
//  FadingNavLayouts
//
//  Created by Samira on 11/2/18.
//  Copyright © 2018 elhami. All rights reserved.
//

import UIKit
import SnapKit

class FadingNavViewController: UIViewController {

    var statusBar: UIView?
    private var previousNavBarHidden = false
    let textVal =  """
                    Across the millennia darkness occurring due to physical phenomena such as solar and lunar eclipses has been a source of fascination and awe, and as astronomical knowledge developed it was discovered that there was a dark side of the Moon never visible to the Earth.

                    With a deepening understanding of the field of cosmology, black holes were first predicted and then experimentally discovered. More recently theories of both dark matter and dark energy have been postulated to explain effects observed in the Universe caused by the presence of such unseen matter and the Universe's expansion. This conference will examine these different strands of the dark side of physics across the ages.
                    """
    
    lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    lazy var infoText: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.textAlignment = .justified
        lbl.text = textVal + textVal + textVal
        return lbl
    }()
    
    let imageViewHeader: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Header")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let viewNav: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.3748997318, blue: 0.3872253563, alpha: 1)
        return view
    }()
    
    let headerLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Black Hole"
        lbl.textColor = .white
        return lbl
    }()
    
    
    let textContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let imageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let textBacking: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
    }
    
}
extension FadingNavViewController {
    func setupview() {
        statusBar =  UIView(frame: UIApplication.shared.statusBarFrame)
        statusBar?.backgroundColor = #colorLiteral(red: 0, green: 0.3748997318, blue: 0.3872253563, alpha: 1)
        view.backgroundColor = .white
        view.addSubview(statusBar!)
        
        view.addSubview(viewNav)
        viewNav.addSubview(headerLbl)
        view.addSubview(scrollView)
        
        
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(imageViewHeader)
        
        scrollView.addSubview(textBacking)
        scrollView.addSubview(textContainer)
        
        
        textContainer.addSubview(infoText)
        
        headerLbl.snp.makeConstraints {
            make in
            
            make.center.equalToSuperview()
            
        }
        
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalToSuperview()
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }
        
        scrollView.snp.makeConstraints {
            make in
            
            make.edges.equalTo(view)
        }
        
        
        viewNav.snp.makeConstraints {
            make in
            make.top.equalTo((statusBar?.snp.bottom)!)
            make.left.right.equalTo(view)
            make.height.equalTo(60)
        }
        
        
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        }
        
        imageViewHeader.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(imageContainer)
            
            //** Note the priorities
            make.top.equalTo(view).priority(.high)
            
            //** We add a height constraint too
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            
            //** And keep the bottom constraint
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        textContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(imageContainer.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        textBacking.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(view)
            make.top.equalTo(textContainer)
            make.bottom.equalTo(view)
        }
        
        infoText.snp.makeConstraints {
            make in
            make.edges.equalTo(textContainer).inset(14)
        }
    }
    
    
}
extension FadingNavViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if previousNavBarHidden != shouldHideStatusBar {
            UIView.animate(withDuration: 0.05, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
                //bring navBar to front
                self.view.bringSubview(toFront: self.viewNav)
                self.view.bringSubview(toFront: self.statusBar!)
            })
        } else  if shouldHideStatusBar  == previousNavBarHidden {
            //send navBar to back
            self.view.sendSubview(toBack: self.viewNav)
            self.view.sendSubview(toBack: self.statusBar!)
            
            previousNavBarHidden = shouldHideStatusBar
            
        }
        
    }
    
    private var shouldHideStatusBar: Bool {
        let frame = textContainer.convert(textContainer.bounds, to: nil)
        if #available(iOS 11.0, *) {
            return frame.minY < view.safeAreaInsets.top
        } else {
            // Fallback on earlier versions
            return frame.minY < 0
        }
    }
}


