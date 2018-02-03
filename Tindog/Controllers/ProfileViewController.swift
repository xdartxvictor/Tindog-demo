//
//  ProfileViewController.swift
//  Tindog
//
//  Created by Victor Aliaga on 2/3/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileDisplaynameLbl: UILabel!
    @IBOutlet weak var profileEmailLbl: UILabel!
    
    var currentUserProfile: UserModel?
    
    @IBAction func closeProfileBtn(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.sd_setImage(with: URL(string: (self.currentUserProfile?.profileImage)!), completed: nil)
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.borderWidth = 1.0
        self.profileImage.clipsToBounds = true
        
        self.profileEmailLbl.text = self.currentUserProfile?.email
        self.profileDisplaynameLbl.text = self.currentUserProfile?.displayName
        
        
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
