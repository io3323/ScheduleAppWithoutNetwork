//
//  PhotoCameraAlert.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 08.07.2022.
//

import Foundation
import UIKit
extension UIViewController{
    func alertPhotoOrCamera(complitionHandler:@escaping(UIImagePickerController.SourceType) -> Void){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (_) in
            let camera = UIImagePickerController.SourceType.camera
            complitionHandler(camera)
        }
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            let photoLibrary = UIImagePickerController.SourceType.photoLibrary
            complitionHandler(photoLibrary)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.negativeWidtConsraint()
        alertController.addAction(camera)
        alertController.addAction(photoLibrary)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}
