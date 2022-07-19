//
//  ColorTaskTableViewController.swift
//  TestAppShedule(No internet)
//
//  Created by Игорь Островский on 06.07.2022.
//

import Foundation
import UIKit

class TaskColorsTableViewController:UITableViewController{
    let idTaskColorCell = "idTaskColorCell"
    let idTaskHeader = "idTaskHeader"
    let headerNameArray = ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        title = "Color Tasks"
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1) )
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces  = false
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idTaskColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idTaskHeader)
    }
    private func setColor(color:String){
        let taskOptions = self.navigationController?.viewControllers[1] as? TaskOptionsTableView
        taskOptions?.hexColorCell = color
        taskOptions?.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTaskColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idTaskHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func pushControllers(vc: UIViewController){
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(vc, animated: true)
    }
}

