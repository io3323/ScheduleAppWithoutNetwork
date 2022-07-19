//
//  AlertOk.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 08.07.2022.
//

import Foundation
import UIKit
extension  UIViewController{
    func alertOk(title: String, message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
