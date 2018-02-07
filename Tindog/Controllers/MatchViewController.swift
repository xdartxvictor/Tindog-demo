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
        self.firstUserMatchImage.round()
        if let match = self.currentMatch{
            print("match:\(match)")
            if let profile = self.currentUserProfile{
                var secondID: String = ""
                if profile.uid == match.uid{
                    secondID = match.uid2
                }else{
                    secondID = match.uid
                }
                
                DataBaseService.instance.getUserProfile(uid: secondID, handler: { (secondUser) in
                    if let secondUser = secondUser{
                        if profile.uid == match.uid{
                            // init match
                            self.firstUserMatchImage.sd_setImage(with: URL(string:profile.profileImage), completed: nil)
                            self.secondUserMatchImage.sd_setImage(with: URL(string:secondUser.profileImage), completed: nil)
                        }else{
                            // match
                            self.firstUserMatchImage.sd_setImage(with: URL(string:secondUser.profileImage), completed: nil)
                            self.secondUserMatchImage.sd_setImage(with: URL(string:profile.profileImage), completed: nil)
                            self.copyMatchLbl.text = "Tu mascota le gusta a  \(secondUser.displayName)"
                        }
                    }
                })
                
                
                
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
