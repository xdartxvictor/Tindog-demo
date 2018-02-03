//
//  HomeViewController.swift
//  Tindog
//
//  Created by Victor Aliaga on 1/24/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit
import RevealingSplashView
import Firebase

class NavigationImageView : UIImageView{
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height: 39)
    }
}

class HomeViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    @IBOutlet weak var likeImage: UIImageView!
    
    let leftBtn = UIButton(type: .custom)
    
    let revealingSplashScreen = RevealingSplashView(iconImage: UIImage(named:"splash_icon")!, iconInitialSize: CGSize(width:80, height:80), backgroundColor: UIColor.white)
    
    @IBOutlet weak var nopeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.revealingSplashScreen)
        
        self.revealingSplashScreen.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashScreen.startAnimation()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named:"Actions")
        self.navigationItem.titleView = titleView
        
        let homeGR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecognizer:)))
        self.cardView.addGestureRecognizer(homeGR)
        
        
        self.leftBtn.imageView?.contentMode = .scaleAspectFit
        let leftBarButton = UIBarButtonItem(customView: self.leftBtn)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            self.leftBtn.setImage(UIImage(named:"login_active"), for: .normal)
            self.leftBtn.removeTarget(nil, action: nil, for: .allEvents)
            self.leftBtn.addTarget(self, action: #selector(goToProfile(sender:)), for: .touchUpInside)
        }else{
            self.leftBtn.setImage(UIImage(named:"login"), for: .normal)
            self.leftBtn.removeTarget(nil, action: nil, for: .allEvents)
            self.leftBtn.addTarget(self, action: #selector(goToLogin(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func goToLogin(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginVC")
        present(loginViewController, animated: true, completion: nil)
    }
    
    @objc func goToProfile(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profileVC")
        present(profileViewController, animated: true, completion: nil)
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
