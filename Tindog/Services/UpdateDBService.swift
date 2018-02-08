//
//  UpdateDBService.swift
//  Tindog
//
//  Created by Victor Aliaga on 2/7/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UpdateDBService {
    static let instance = UpdateDBService()
    
    func observeMatch(handler: @escaping(_ matchDict: MatchModel?) -> Void){
        DataBaseService.instance.Match_Ref.observe(.value, with: { (snapshot) in
            if let matchSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                if matchSnapshot.count > 0{
                    for match in matchSnapshot{
                        if match.hasChild("uid2") && match.hasChild("matchIsAccepted"){
                            if let matchDict = MatchModel(snapshot: match){
                                handler(matchDict)
                            }
                        }
                    }
                }else{
                    handler(nil)
                }
            }
        })
    }
}
