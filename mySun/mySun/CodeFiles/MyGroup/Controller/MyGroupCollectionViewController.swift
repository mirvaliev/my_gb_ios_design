//
//  MyGroupCollectionViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 28/08/21.
//

import UIKit

class MyGroupCollectionViewController: UICollectionViewController {
  
    let itemPerRow: CGFloat = 2
    let sectionEndsers = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    var myGroupPhoto: [GroupPhotoColection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let loyaut = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        collectionView.contentMode = .scaleAspectFill
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sharePhoto" {
            let photoVC = segue.destination as! PhotoLikeViewController
            let cell = sender as! MyGroupCollectionCell
            photoVC.image = cell.photoInMyGroup.image
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyGroupCollectionCell", for: indexPath) as! MyGroupCollectionCell
        
        let photoGroup = myGroupPhoto[indexPath.row]
        cell.configMyCollection(photoGroup)
        
    
        return cell
    }

    
}

extension MyGroupCollectionViewController: UICollectionViewDelegateFlowLayout {
    // явное определение размера наших ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // для посчета ширины ячейки коллекции
        let padingWidth = sectionEndsers.left * (itemPerRow + 1)
        let avalibleVidth = collectionView.frame.width - padingWidth
        let widthPerItem = avalibleVidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // настройка отстура от краёв экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionEndsers
    }
    
    // растояние между ячейками по горизонтали в линию столбец
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionEndsers.left
    }
    
    // растояние между ячейками по вертикали в линию строка
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionEndsers.right
    }
}
