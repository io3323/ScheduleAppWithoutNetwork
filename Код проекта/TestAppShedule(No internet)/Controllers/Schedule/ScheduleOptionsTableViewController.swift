import UIKit

class ScheduleOptionsTableViewController:UITableViewController{
    let idOptionsScheduleCell = "idOptionsScheduleCell"
    let idOptionsHeader = "idOptionsHeader"
    let headerNameArray = ["DATE AND TIME","LESSON","TEACHER","COLOR","PERIOD"]
    var cellNameArray  = [["Date","Time"],
                          ["Name","Type","Building","Audienxe"],
                          ["Teacher Name"],
                          [""],
                          ["Repeat every 7 days"]]
    var scheduleModel = ScheduleModel()
    var hexColorCell = "76D6FF"
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        title = "Option Schedule"
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1) )
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces  = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsHeader)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    @objc private func saveButtonTapped(){
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleType == nil || scheduleModel.scheduleName == "Unknown"{
            alertOk(title: "Error", message: "Requered fields: DATE,TIME,NAME")
        }else{
            scheduleModel.scheduleColor = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            alertOk(title: "Success", message: nil)
            hexColorCell = "76D6FF"
            cellNameArray[2][0] = "Teacher Name"
            tableView.reloadData()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 4
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        
        cell.switchRepeatDelegate = self
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
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                self.scheduleModel.scheduleDate = date
                self.scheduleModel.scheduleWeekday = numberWeekday
            }
        case [0,1]:
            alertTime(label: cell.nameCellLabel) { (time) in
                self.scheduleModel.scheduleTime = time
            }
        case [1,0]:
            alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson"){ text in
                self.scheduleModel.scheduleName = text
            }
        case [1,1]:
            alertForCellName(label: cell.nameCellLabel, name: "Type lesson", placeholder: "Enter type lesson"){ text in
                self.scheduleModel.scheduleType = text
            }
        case [1,2]:
            alertForCellName(label: cell.nameCellLabel, name: "Building number", placeholder: "Enter building number"){ text in
                self.scheduleModel.scheduleBuilding = text
            }
        case [1,3]:
            alertForCellName(label: cell.nameCellLabel, name: "Audience", placeholder: "Enter number ofaudience"){ text in
                self.scheduleModel.scheduleAudience = text
            }
        case [2,0]:
            let teachers = TeachersTableViewController()
            pushControllers(vc: teachers)
        case [3,0]:
            let colors  = ScheduleColorsViewController()
            pushControllers(vc: colors)
        default:
            print("Tap OptionsTableView")
        }
    }
    
    func pushControllers(vc: UIViewController){
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ScheduleOptionsTableViewController:SwitchRepeatProtocol{
    func SwitchRepeate(value: Bool) {
        scheduleModel.scheduleRepeat = value
    }
    
    
}
