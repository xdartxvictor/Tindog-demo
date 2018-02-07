//
//  MatchViewController.swift
//  Tindog
//
//  Created by Victor Aliaga on 2/7/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    @IBOutlet weak var copyMatchLbl: UILabel!
    @IBOutlet weak var firstUserMatchImage: UIImageView!
    @IBOutlet weak var secondUserMatchImage: UIImageView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var currentUserProfile: UserModel?
    var currentMatch: MatchModel?
    
    
    
    
    
    @IBAction func doneBtnAction(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondUserMatchImage.round()
        if let match = self.currentMatch{
            print("match:\(match)")
            if let profile = self.currentUserProfile{
                self.secondUserMatchImage.sd_setImage(with: URL(string:profile.profileImage), completed: nil)
                
            }
        }
        
        

        // Do any additional setup after loading the view.
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
