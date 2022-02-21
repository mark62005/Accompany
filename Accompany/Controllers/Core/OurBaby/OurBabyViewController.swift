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
  
  let leftNumberTitle = TitleLabel(title: "", size: .mini, color: .black)
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
    contentLabel.font = UIFont.systemFont(ofSize: 18)
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
    
    babyTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(imageView)
    
    imageView.snp.makeConstraints { make in
      make.top.equalTo(babyTitle.snp.bottom)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.1)
      make.height.equalTo(imageView.snp.width).multipliedBy(0.8)
   
    }
    
    let stackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [nameTitle, contentView])
      stackView.axis = .vertical
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = 10
      stackView.translatesAutoresizingMaskIntoConstraints = false

      return stackView
    }()

    view.addSubview(stackView)

    stackView.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(20)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.9)
    }
    
    let titleAndDueStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [leftNumberTitle, datePicker])
      stackView.axis = .horizontal
      stackView.distribution = .fill
      stackView.alignment = .center
      stackView.spacing = 5
      stackView.translatesAutoresizingMaskIntoConstraints = false
      
      return stackView
    }()
    
    let titlesStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [leftTitle, dueDateTitle])
      stackView.axis = .horizontal
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = 15
      stackView.translatesAutoresizingMaskIntoConstraints = false

      return stackView
    }()

    let showTitleDateStack: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [contentLabel,titleAndDueStack, titlesStack])
      stackView.axis = .vertical
      stackView.distribution = .fill
      stackView.alignment = .fill
      stackView.spacing = 15
      stackView.translatesAutoresizingMaskIntoConstraints = false

      return stackView
    }()

    contentView.addSubview(showTitleDateStack)

    showTitleDateStack.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(10)
      make.centerX.equalTo(contentView)
      make.bottom.equalTo(contentView.snp.bottom).offset(-15)
    }
    
    view.addSubview(babyImageView)
 
    babyImageView.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
      make.height.equalTo(view.snp.height).multipliedBy(0.3)
    }
  }
   
  @objc func datePickerValueChanged(_ sender: UIDatePicker) {


    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"

    let selectedDate: String = dateFormatter.string(from: sender.date)

    let currentDateTime = Date()

    let formatter = DateFormatter()
    formatter.timeStyle = .none
    formatter.dateStyle = .long
    formatter.dateFormat = "dd/MM/yyyy"
    let todayDate: String = formatter.string(from: currentDateTime)

    let dueDate = formatter.date(from: selectedDate)
    let currentDate = formatter.date(from: todayDate)
    let difference = (dueDate! - currentDate!)
    print(difference.asDays(), "days")

    leftNumberTitle.text = "\(difference.asDays()) days"

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
extension TimeInterval {
  func asDays()    -> Int { return Int(self / (60 * 60 * 24)) }
}
