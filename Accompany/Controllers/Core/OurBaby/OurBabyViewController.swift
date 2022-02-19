//
//  OurBabyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class OurBabyViewController: UIViewController {
  
  let babyTitle = TitleLabel(title: "Baby", size: .medium, color: .red)
  
  let nameTitle = TitleLabel(title: "Baby's name", size: .mini, color: .black)
  
  let leftNumberTitle = TitleLabel(title: nil, size: .mini, color: .black)
  let leftTitle = TitleLabel(title: "Days left", size: .mini, color: .grey)
  let dueDateTitle = TitleLabel(title: "Due Date", size: .mini, color: .grey)

  let contentView: UIView = {
    let contentView = UIView()
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 13
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    return contentView
  }()
  
  let contentLabel: UILabel = {
    let contentLabel = UILabel()
    contentLabel.text = "Hello🖐🏻 I'm your little baby.\n So excited to see this world!\n Can't wait to see everyone❤️"
    contentLabel.textColor = .gray
    contentLabel.textAlignment = .center
    contentLabel.font = UIFont.boldSystemFont(ofSize: 18)
    contentLabel.numberOfLines = 0
    contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    contentLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return contentLabel
  }()
  
  let imageView = ImageView()
  let babyImageView = ImageView()
  
  let datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.timeZone = NSTimeZone.local
    datePicker.backgroundColor = .white
    datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    
    return datePicker
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.image = UIImage(systemName: "photo.on.rectangle")
    babyImageView.image = UIImage(named: "baby-image")
    
    datePicker.datePickerMode = .date
   
   setupLayout()

  }
  
  private func setupLayout() {
    view.addSubview(babyTitle)
    view.addSubview(imageView)
    view.addSubview(nameTitle)
    view.addSubview(contentView)
    contentView.addSubview(contentLabel)
    contentView.addSubview(dueDateTitle)
    contentView.addSubview(datePicker)
    
    let stackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [leftNumberTitle, leftTitle])
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.axis = .vertical
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      return stackView
    }()
    
    contentView.addSubview(stackView)
    view.addSubview(babyImageView)
    
    babyTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    imageView.snp.makeConstraints { make in
      make.top.equalTo(babyTitle.snp.bottom).offset(5)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
    }
    
    nameTitle.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(5)
      make.centerX.equalTo(view)
    }
    
    contentView.snp.makeConstraints { make in
      make.top.equalTo(nameTitle.snp.bottom).offset(15)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(contentView.snp.width).multipliedBy(0.6)
    }
    
    contentLabel.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(15)
      make.left.equalTo(contentView.snp.left).offset(5)
      make.right.equalTo(contentView.snp.right).offset(-5)
    }
    
    babyImageView.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.bottom).offset(12)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.9)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-3)
    }
    
    stackView.snp.makeConstraints { make in
      make.bottom.equalTo(contentView.snp.bottom).offset(-20)
      make.left.equalTo(contentView.snp.left).offset(65)
    }
    
    dueDateTitle.snp.makeConstraints { make in
      make.bottom.equalTo(contentView.snp.bottom).offset(-20)
      make.right.equalTo(contentView.snp.right).offset(-65)
    }
    
    datePicker.snp.makeConstraints { make in
      make.bottom.equalTo(dueDateTitle.snp.top).offset(-15)
      make.right.equalTo(contentView.snp.right).offset(-65)
      make.left.equalTo(leftNumberTitle.snp.right).offset(10)
    }

  }
  
  @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    
   
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
//
//    let selectedDate: String = dateFormatter.string(from: sender.date)
//
//    let currentDateTime = Date()
//
//    let formatter = DateFormatter()
//    formatter.timeStyle = .none
//    formatter.dateStyle = .long
//    formatter.dateFormat = "dd/MM/yyyy"
//    let todayDate: String = formatter.string(from: currentDateTime)
//
//    let interval = DateInterval(start: <#T##Date#>, end: <#T##Date#>)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
extension Date {

    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

}
