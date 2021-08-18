//
//  GroupData.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 16/08/21.
//

import UIKit
import Foundation

class GroupData {
    var myGroup: [GroupsModel]
    var allGroup: [GroupsModel]
    
    init() {
        myGroup = [
            GroupsModel(groupName: "Фотография", groupLogo: "photo", groupPhoto: [
                GroupPhotoColection(photoImage: "1_p"),
                GroupPhotoColection(photoImage: "2_p"),
                GroupPhotoColection(photoImage: "3_p"),
                GroupPhotoColection(photoImage: "4_p"),
                GroupPhotoColection(photoImage: "5_p"),
                GroupPhotoColection(photoImage: "6_p"),
                GroupPhotoColection(photoImage: "7_p")
            ])
        ]
        
        allGroup = [
            GroupsModel(groupName: "Фотография", groupLogo: "photo", groupPhoto: [
                GroupPhotoColection(photoImage: "1_p"),
                GroupPhotoColection(photoImage: "2_p"),
                GroupPhotoColection(photoImage: "3_p"),
                GroupPhotoColection(photoImage: "4_p"),
                GroupPhotoColection(photoImage: "5_p"),
                GroupPhotoColection(photoImage: "6_p"),
                GroupPhotoColection(photoImage: "7_p")
            ]),
            GroupsModel(groupName: "Программиование", groupLogo: "logo_it", groupPhoto: [
                GroupPhotoColection(photoImage: "1_it"),
                GroupPhotoColection(photoImage: "2_it"),
                GroupPhotoColection(photoImage: "3_it"),
                GroupPhotoColection(photoImage: "4_it"),
                GroupPhotoColection(photoImage: "5_it"),
                GroupPhotoColection(photoImage: "6_it"),
                GroupPhotoColection(photoImage: "7_it")
            ]),
            GroupsModel(groupName: "История", groupLogo: "logo_h", groupPhoto: [
                GroupPhotoColection(photoImage: "1_h"),
                GroupPhotoColection(photoImage: "2_h"),
                GroupPhotoColection(photoImage: "3_h"),
                GroupPhotoColection(photoImage: "4_h"),
                GroupPhotoColection(photoImage: "5_h"),
                GroupPhotoColection(photoImage: "6_h"),
                GroupPhotoColection(photoImage: "7_h")
            ]),
            GroupsModel(groupName: "Религия", groupLogo: "logo_r", groupPhoto: [
                GroupPhotoColection(photoImage: "1_r"),
                GroupPhotoColection(photoImage: "2_r"),
                GroupPhotoColection(photoImage: "3_r"),
                GroupPhotoColection(photoImage: "4_r"),
                GroupPhotoColection(photoImage: "5_r"),
                GroupPhotoColection(photoImage: "6_r"),
                GroupPhotoColection(photoImage: "7_r")
            ])
        ]
    }
}
