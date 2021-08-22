//
//  SetingsTableViewCelTableViewCell.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 14/08/21.
//
// Этот class отвечает за ячейку в TableView Настроек

import UIKit

class SetingsTableViewCelTableViewCell: UITableViewCell {
    
    // индитификатор для ячейки
    static let inditiferSetingsCel = "SetingsTableViewCelTableViewCell"
    
    @IBOutlet private var imageCell: UIImageView!
    @IBOutlet private var lableCell: UILabel!
    
    
    func configure (avatarName: String?, titlelCell: String) {
        imageCell.image = UIImage(named: "setingsMail")
        lableCell.text = titlelCell
    }

}
