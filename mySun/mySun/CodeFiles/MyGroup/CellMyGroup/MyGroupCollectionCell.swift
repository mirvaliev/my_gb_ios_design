//
//  MyGroupCollectionCell.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 18/08/21.
//

import UIKit
import Foundation

class MyGroupCollectionCell: UICollectionViewCell {
    
    static let idMyGroupCollectionCell = "MyGroupCollectionCell"
    
    @IBOutlet var photoInMyGroup: UIImageView!
    
    func configMyCollection (_ photoGroup: GroupPhotoColection) {
        
        photoInMyGroup.image = UIImage(named: photoGroup.photoImage)
    }
    
    
    
    
    
    
}
