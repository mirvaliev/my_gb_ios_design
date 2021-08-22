//
//  MyGroupTableViewCell.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 15/08/21.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {

    static let indetifarMyGroup = "MyGroupTableViewCell"
    
    @IBOutlet var myAvatatarLogoImageView: UIImageView!
    @IBOutlet var myLabelGroupName: UILabel!
    
    func configureMyGroup (groups: GroupsModel) {
        myAvatatarLogoImageView.image = UIImage(named: groups.groupLogo)
        myLabelGroupName.text = groups.groupName
    }
}
