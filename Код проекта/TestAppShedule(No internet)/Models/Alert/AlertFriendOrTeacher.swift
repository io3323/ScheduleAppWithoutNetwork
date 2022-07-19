//
//  AlertFriendOrTeacher.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 07.07.2022.
//

import UIKit
extension UIViewController{
    func allertFriendOrTeacher(label:UILabel, complitionHandler:@escaping(String) -> Void){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let friend = UIAlertAction(title: "Friend", style: .default) { (_) in
            label.text = "Friend"
            let typeContact = "Friend"
            complitionHandler(typeContact)
        }
        let teacher = UIAlertAction(title: "Teacher", style: .default) { (_) in
            label.text = "Teacher"
            let typeContact = "Teacher"
            complitionHandler(typeContact)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.negativeWidtConsraint()
        alertController.addAction(friend)
        alertController.addAction(teacher)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}
