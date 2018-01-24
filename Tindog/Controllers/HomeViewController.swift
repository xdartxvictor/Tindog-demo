//
//  HomeViewController.swift
//  Tindog
//
//  Created by Victor Aliaga on 1/24/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit
class NavigationImageView : UIImageView{
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height: 39)
    }
}

class HomeViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var nopeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named:"Actions")
        self.navigationItem.titleView = titleView
        
        let homeGR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecognizer:)))
        self.cardView.addGestureRecognizer(homeGR)
        // Do any additional setup after loading the view.
    }
    @objc func cardDragged(gestureRecognizer : UIPanGestureRecognizer){
        let cardPoint = gestureRecognizer.translation(in: view)
        self.cardView.center = CGPoint(x: self.view.bounds.width / 2 + cardPoint.x , y: self.view.bounds.height / 2 + cardPoint.y)
        
        let xFromCenter = self.view.bounds.width / 2 - self.cardView.center.x
        var rotate = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter), 1)
        var finalTransform = rotate.scaledBy(x: scale, y: scale)
        
        self.cardView.transform = finalTransform
        
        if self.cardView.center.x < (self.view.bounds.width / 2 - 100){
            self.nopeImage.alpha = min(abs(xFromCenter) / 100, 1)
        }
        if self.cardView.center.x > (self.view.bounds.width / 2 + 100){
            self.likeImage.alpha = min(abs(xFromCenter) / 100, 1)
        }
        
        
        
        
        if gestureRecognizer.state == .ended{
            if self.cardView.center.x < (self.view.bounds.width / 2 - 100){
                print("dislike")
            }
            if self.cardView.center.x > (self.view.bounds.width / 2 + 100){
                print("like")
            }
            
            rotate = CGAffineTransform(rotationAngle: 0)
            finalTransform  = rotate.scaledBy(x: 1, y: 1)
            self.cardView.transform = finalTransform
            self.likeImage.alpha = 0
            self.nopeImage.alpha = 0
            
            self.cardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2 , y: (self.homeWrapper.bounds.height / 2 - 30) )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
