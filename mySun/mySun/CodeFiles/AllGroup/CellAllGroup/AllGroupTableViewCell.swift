//
//  AllGroupTableViewCell.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 15/08/21.
//

import UIKit

class AllGroupTableViewCell: UITableViewCell {

    static let indetifarAllGroup = "AllGroupTableViewCell"
    
    @IBOutlet private var avatarLogoImagesView: UIImageView!
    @IBOutlet private var lableGroupName: UILabel!
    
    func configureAllGroup (avatarLogoName: String?, lableName: String) {
        avatarLogoImagesView.image = UIImage(named: "photo")
        lableGroupName.text = lableName
    }
}
