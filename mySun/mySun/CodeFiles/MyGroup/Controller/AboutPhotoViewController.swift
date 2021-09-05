//
//  AboutPhotoViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 02/09/21.
//

import UIKit

class AboutPhotoViewController: UIViewController {
    
    var abautImage: UIImage?
    
    @IBOutlet var abautThisPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        abautThisPhoto.contentMode = .scaleAspectFill
        abautThisPhoto.image = abautImage
    }
    

    

}
