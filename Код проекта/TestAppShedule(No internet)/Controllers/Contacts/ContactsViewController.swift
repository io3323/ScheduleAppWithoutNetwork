//
//  ContactsTableViewController.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 07.07.2022.
//

import Foundation
import UIKit
import RealmSwift
import SwiftUI

class ContactsViewController:UIViewController{
    let searchController = UISearchController()
    let idContactsCell = "idContactsCell"
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private var filterArray: Results<ContactModel>!
    private let segmentedControll:UISegmentedControl = {
        let segmentedControll = UISegmentedControl(items: ["Friends","Teachers"])
        segmentedControll.selectedSegmentIndex = 0
        return segmentedControll
    }()
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1) )
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    var searchBarIsEmpty:Bool{
        guard let text = searchController.searchBar.text else {return true}
        return  text.isEmpty
    }
    var isFiltering:Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setContraint()
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        title = "Contacts"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddButtonTapped))
        contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
        segmentedControll.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc func segmentChanged(){
        if segmentedControll.selectedSegmentIndex == 0{
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
            tableView.reloadData()
        }else{
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Teacher'")
            tableView.reloadData()
        }
    }
    @objc func AddButtonTapped(){
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    @objc func editingModel(contactModel: ContactModel){
        let contactOption = ContactsOptionsTableViewController()
        contactOption.contactModel = contactModel
        contactOption.editModel = true
        contactOption.cellNameArray = [
            contactModel.contactsName,
            contactModel.contactsPhone,
            contactModel.contactsMail,
            contactModel.contactsType,
            ""
        ]
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
   
   
}
extension ContactsViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isFiltering ? filterArray.count : contactsArray.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        let model = (isFiltering ? filterArray[indexPath.row] : contactsArray[indexPath.row])
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        editingModel(contactModel: model)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        let deleteAcion = UIContextualAction(style: .destructive, title: "Delete") { _, _, competionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAcion])
    }
}
extension ContactsViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText:String){
        filterArray = contactsArray.filter("contactsName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
}
extension ContactsViewController{
    private func setContraint(){
        let stackView = UIStackView(arrangedSubviews: [tableView,segmentedControll], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

