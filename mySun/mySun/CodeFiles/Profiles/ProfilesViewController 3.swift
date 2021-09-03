//
//  ProfilesViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 21/08/21.
//

import UIKit

class ProfilesViewController: UIViewController {

    
    @IBOutlet private var profileLogoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileLogoView.layer.cornerRadius = 80
        profileLogoView.clipsToBounds = true
        
    }
    


}
