//
//  File.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/18/19.
//  Copyright © 2019 demo. All rights reserved.
//


import UIKit
import Photos
class SelectPhotoCanCropPopUp: NSObject {
    
    var controller: UIViewController?
    var imagePickerUIKit = UIImagePickerController()
    var completionImage: CompletionUIImage?
    
    static let shared = SelectPhotoCanCropPopUp()
    
    func showCropPicker(controller: UIViewController?, completion: @escaping CompletionUIImage) {
        self.controller = controller
        self.completionImage = completion
        
        guard let controller = controller else { return }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let actionCamera = UIAlertAction(title: "\(LocalizableKey.camera.showLanguage)", style: UIAlertAction.Style.default) { [weak self] _ in
            guard let strongSelf = self else { return }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                strongSelf.presentImagePicker(sourceType: .camera)
            } else {
                print("No Camera")
            }
        }
        
        let actionPhoto = UIAlertAction(title: "\(LocalizableKey.library.showLanguage)", style: UIAlertAction.Style.default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.presentImagePicker(sourceType: .photoLibrary)
        }
        
        let actionCancel = UIAlertAction(title: "\(LocalizableKey.cancel.showLanguage)", style: UIAlertAction.Style.default) { _ in
            
        }
        
        alert.addAction(actionCamera)
        alert.addAction(actionPhoto)
        alert.addAction(actionCancel)
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = controller.view
            popoverController.sourceRect = CGRect(x: controller.view.bounds.midX, y: controller.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        
        guard let controller = controller else { return }
        imagePickerUIKit = UIImagePickerController()
        imagePickerUIKit.delegate = self
        imagePickerUIKit.allowsEditing = true
        imagePickerUIKit.sourceType = sourceType
        controller.present(imagePickerUIKit, animated: true, completion: nil)
    }
}

// MARK:
extension SelectPhotoCanCropPopUp:
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let imageEdit = info[.editedImage] as? UIImage {
            
            let assetPath = info[UIImagePickerController.InfoKey.referenceURL] as! NSURL
            if assetPath.absoluteString?.hasSuffix("GIF") ??  false {
                imagePickerUIKit.dismiss(animated: true, completion: nil)
                PopUpHelper.shared.showNoAllowGifPhoto(completionYes: nil)
            } else {
                imagePickerUIKit.dismiss(animated: true, completion: nil)
                //            delegate?.didReceivePhoto(image: imageEdit)
                self.completionImage?(imageEdit)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerUIKit.dismiss(animated: true, completion: nil)
    }
}

