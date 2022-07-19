//
//  ContactsTableViewCell.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 07.07.2022.
//

import Foundation
import UIKit
import FSCalendar
class ContactsTableViewCell:UITableViewCell{
    let contactImageView:UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        return imageView
    }()
    let phoneImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(cgColor: #colorLiteral(red: 0.07100383192, green: 0.4770585895, blue: 0.998074472, alpha: 1))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let mailImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image  = UIImage(systemName: "envelope.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(cgColor: #colorLiteral(red: 0.07100383192, green: 0.4770585895, blue: 0.998074472, alpha: 1))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let nameLabel  = UILabel(text: "Cruella De Vill", font: .avenirNext20(), alignment: .left)
    let phoneLabel  = UILabel(text: "+7 878 768 44 54", font: .avenirNext14(), alignment: .left)
    let mailLabel  = UILabel(text: "CruellaDeVill@mail.ru", font: .avenirNext14(), alignment: .left)
    override func layoutIfNeeded() {
        super.layoutSubviews()
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impemented")
    }
    func configure(model: ContactModel){
        nameLabel.text = model.contactsName
        phoneLabel.text = model.contactsPhone
        mailLabel.text = model.contactsMail
        if let data = model.contactsImage, let image = UIImage(data: data){
            contactImageView.image = image
        }else{
            contactImageView.image = UIImage(systemName: "person.fill")
        }
       

    }
    func setConstraints(){
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 15),
            contactImageView.widthAnchor.constraint(equalToConstant: 70),
            contactImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        let stackView = UIStackView(arrangedSubviews: [phoneImageView,phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor,  constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        ])
    }
}

