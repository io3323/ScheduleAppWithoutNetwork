import UIKit
import FSCalendar
class ScheduleTableViewCell:UITableViewCell{
    let lessonName = UILabel(text: "", font: .avenirNextDemiBold20(), alignment: .left)
    let teacherName = UILabel(text: "", font: .avenirNext14(), alignment: .right)
    let lessonTime = UILabel(text: "", font: .avenirNextDemiBold20(), alignment: .left)
    let typeLabel = UILabel(text: "Type:", font: .avenirNext14(), alignment: .left)
    let lessonType = UILabel(text: "", font: .avenirNextDemiBold14(), alignment: .left)
    let buIldingLabel = UILabel(text: "Building:", font: .avenirNext14(), alignment: .right)
    let lessonBuilding = UILabel(text: "", font: .avenirNext14(), alignment: .left)
    let audLabel = UILabel(text: "Audience:", font: .avenirNext14(), alignment: .right)
    let lessonAud = UILabel(text: "", font: .avenirNextDemiBold14(), alignment: .left)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier:String?){
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impemented")
    }
    func configure(model:ScheduleModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        lessonName.text = model.scheduleName
        teacherName.text = model.scheduleTeacher
        guard let time = model.scheduleTime else {return}
        lessonTime.text = dateFormatter.string(from: time)
        lessonType.text = model.scheduleType
        lessonBuilding.text = model.scheduleBuilding
        lessonAud.text = model.scheduleAudience
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
        
        
    }
    func setConstraints(){
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.heightAnchor.constraint(equalToConstant: 25),
            lessonTime.widthAnchor.constraint(equalToConstant: 100)
        ])
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel,lessonType,buIldingLabel, lessonBuilding,audLabel,lessonAud], axis: .horizontal, spacing: 5, distribution: .fillEqually)
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
