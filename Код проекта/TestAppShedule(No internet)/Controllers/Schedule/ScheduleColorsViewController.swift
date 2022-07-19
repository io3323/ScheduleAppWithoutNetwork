import UIKit

class ScheduleColorsViewController:UITableViewController{
    let idOptionsColorCell = "idOptionsColorCell"
    let idOptionsHeader = "idOptionsHeader"
    let headerNameArray = ["RED","ORANGE","YELLOW","GREEN","BLUE","DEEP BLUE","PURPLE"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        title = "Color Schedule"
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1) )
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces  = false
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idOptionsColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0: setColor(color: "FD7E79")
        case 1: setColor(color: "FED479")
        case 2: setColor(color: "FFFC78")
        case 3: setColor(color: "73FA79")
        case 4: setColor(color: "76D6FF")
        case 5: setColor(color: "7A81FF")
        case 6: setColor(color: "D783FF")
        default:
            setColor(color: "FFFFFF")
        }
    }
    private func setColor(color:String){
        let scheduleOptions = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheduleOptions?.hexColorCell = color
        scheduleOptions?.tableView.reloadRows(at: [[3,0],[4,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    func pushControllers(vc: UIViewController){
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(vc, animated: true)
    }
}

