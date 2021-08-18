//
//  MyGroupCollactionViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 15/08/21.
//

import UIKit

class MyGroupCollactionViewController: UIViewController {
    
    var myGroupPhoto: [GroupPhotoColection] = []
    
    @IBOutlet var myPhotoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        myPhotoCollectionView.delegate = self
        myPhotoCollectionView.dataSource = self
    }
}

extension MyGroupCollactionViewController: UICollectionViewDelegate {
    
}

extension MyGroupCollactionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myGroupPhoto.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGroupCollectionCell.idMyGroupCollectionCell, for: indexPath) as! MyGroupCollectionCell
        let photoGroup = myGroupPhoto[indexPath.row]
        photoCell.configMyCollection(photoGroup)
        return photoCell
    }
    
    
}
