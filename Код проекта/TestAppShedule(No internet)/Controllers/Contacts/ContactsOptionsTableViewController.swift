//
//  ContactOptionTableViewController.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 07.07.2022.
//

import Foundation
import UIKit

class ContactsOptionsTableViewController:UITableViewController{
    let idOptionsContactCell = "idOptionsContactCell"
    let idOptionsContactHeader = "idOptionsContactHeader"
    let headerNameArray = ["NAME","PHONE","MAIL","TYPE","CHOOSE IMAGE"]
    var cellNameArray  = ["Name", "Phone","Mail","Type",""]
    var imageIsChanged = false
    var contactModel = ContactModel()
    var editModel = false
    var dataImage: Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        title = "Option Tasks"
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1) )
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces  = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactHeader)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    @objc private func saveButtonTapped(){
        if  cellNameArray[0] == "Name" || cellNameArray[3] == "Type"{
            alertOk(title: "Error", message: "Requered fields: NAME and TYPE")
        }else if editModel == false{
            setImageModel()
            setModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            cellNameArray = ["Name","Phone","Mail","Type",""]
            alertOk(title: "Success", message: nil)
            tableView.reloadData()
        }else{
            setImageModel()
            RealmManager.shared.updateContactModel(model: contactModel, nameArray: cellNameArray, imageData: dataImage)
            self.navigationController?.popViewController(animated: true)
        }
    }
    func pushControllers(vc: UIViewController){
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(vc, animated: true)
    }
    private func setModel(){
        contactModel.contactsName = cellNameArray[0]
        contactModel.contactsPhone = cellNameArray[1]
        contactModel.contactsMail = cellNameArray[2]
        contactModel.contactsType = cellNameArray[3]
        contactModel.contactsImage = dataImage
    }
    @objc private func setImageModel(){
        if imageIsChanged{
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else {return}
            dataImage = imageData
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        }else{
            dataImage = nil
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        if editModel == false {
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }else if let data = contactModel.contactsImage, let image = UIImage(data: data){
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        }else{
            cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 200 : 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter name contact"){ text in
            //self.contactModel.contactsName = text
            self.cellNameArray[0] = text
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone Contact", placeholder: "Enter phone conact"){ text in
           //self.contactModel.contactsPhone = text
            self.cellNameArray[1] = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter mail contact"){ text in
            //self.contactModel.contactsMail = text
            self.cellNameArray[2] = text
        }
        case 3: allertFriendOrTeacher(label: cell.nameCellLabel) { (type) in
            //self.contactModel.contactsType = type
            self.cellNameArray[3] = type
        }
        case 4:alertPhotoOrCamera { [self] source in
            chooseImagePicker(source: source)
        }
    
        default:
            print("Tap ContactTableView")
        }
    }
}
extension ContactsOptionsTableViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker  = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType  = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let cell = tableView.cellForRow(at: [4,0])  as! OptionsTableViewCell
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode  = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds  = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}


