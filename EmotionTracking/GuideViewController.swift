//
//  GuideViewController.swift
//  EmotionTracking
//
//  Created by 周桠媚 on 11/05/16.
//  Copyright © 2016年 NguyenTrung. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    
    private let numOfPages = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "GuideImage\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, atIndex: 0)
        
        
        startButton.layer.cornerRadius = 15.0
        
        startButton.alpha = 0.0
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animateWithDuration(0.5) {
                self.startButton.alpha = 1.0
            }
        } else {
            UIView.animateWithDuration(0.2) {
                self.startButton.alpha = 0.0
            }
        }
    }
}
 


