//
//  PhotoLikeViewController.swift
//  mySun
//
//  Created by Sagit Mirvaliev on 28/08/21.
//

import UIKit

class PhotoLikeViewController: UIViewController {
    
    var image: UIImage?
    private var numberTouch: Int = 0
    private var myLike: Int = 0
    
    @IBOutlet var photoImageSend: UIImageView!
    @IBOutlet var sendToImange: UIButton!
    @IBOutlet var likeButtom: UIButton!
    @IBOutlet var likeCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageSend.contentMode = .scaleAspectFill
        photoImageSend.image = image
    }
    

    @IBAction func sendToImageAction(_ sender: Any) {
        
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, Bool, _, _ in
            if Bool { print("Ok") }
        }
        
        present(shareController, animated: true, completion: nil)
        
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        if sender.isTouchInside == true {
            numberTouch += 1
            
            if numberTouch % 2 != 0 {
                myLike += 1
                likeCount.text = String(myLike)
            } else {
                myLike -= 1
                likeCount.text = String(myLike)
            }
        }
    }
    
    @IBAction func goToReview(_ segue: UIStoryboardSegue) {
        
    }
    
    // !!!!!! МЕТОД ПЕРЕДАЧИ ДАННЫХ ОТ ОДНОГО VC В ДРУГОЙ VC !!!!!!!
    
    @IBAction func aboutPhotoViewController(_ sender: UIButton) {
        
        // получаем доступ к свойствам класса AboutPhotoViewController
        let storyBoardAboutPhoto = UIStoryboard(name: "Main", bundle: nil)
        if let aboutPhotoViewController = storyBoardAboutPhoto.instantiateViewController(identifier: "aboutPhotoViewController") as? AboutPhotoViewController {
            aboutPhotoViewController.abautImage = photoImageSend.image!
            show(aboutPhotoViewController, sender: nil)
        }
        
    }
    
}


