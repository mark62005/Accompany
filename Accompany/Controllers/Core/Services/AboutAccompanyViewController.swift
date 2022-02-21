//
//  AboutAccompanyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class AboutAccompanyViewController: UIViewController {
  
  let aboutAccompanyTitle = TitleLabel(title: Services.aboutAccompany.description, size: .medium, color: .red)
  
  let contentTableView: UITableView = {
    let contentTableView = UITableView()
    contentTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    contentTableView.isUserInteractionEnabled = true
    
    return contentTableView
  }()
  
  let contentTextLabel: UILabel = {
    let contentTextLabel = UILabel()
    contentTextLabel.text = """
    Looking for the most user-friendly pregnant application in the world? Come to Use Accompany!
    We want to accompany the person who is ready to deliver the birth. Sometimes, people will be really nervous when they meet lots of problems during this pregnancy cycle. Therefore, we want to provide useful information, knowledge, and functions with this app.

    What you can do in Accompany:
     ·Get notifications to remind you to do things like ask medical history in the first trimester. You don’t need to worry about what you should do in different trimesters.
     ·Help you calculate the days left before your baby's due date. We will be looking forward to welcoming this baby to come together.
     ·Record photos and notes in this app. After your ultrasound, don’t forget to upload your baby’s sonograms. Create your own baby’s album. We believe all memories are cherishable and worth recording.
     ·Use our contraction timer to record your contraction. Analyzes the duration and frequency of contractions. It is one of the ways to estimate when you need to go to hospital.
     ·Read useful pregnant articles from our app. These articles are all from the NHS website pregnancy club. Read more information and help you get relieved.
     ·Invite your partner or your family to have all datas in this app. They can get detailed information from this app. Your partner can easily know when the next time you need to see an obstetrician. ( IT IS THE MOST IMPORTANT PART WE WANT TO CREATE!!)
    """
    contentTextLabel.textAlignment = .left
    contentTextLabel.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    contentTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    contentTextLabel.numberOfLines = 0
    
    return contentTextLabel
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
 
    setupLayout()
  }
  
  private func configureTableView() {
    contentTableView.delegate = self
    contentTableView.dataSource = self
  }
  
  private func setupLayout() {
    view.addSubview(aboutAccompanyTitle)
    
    aboutAccompanyTitle.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
    
    view.addSubview(contentTextLabel)
    
    contentTextLabel.snp.makeConstraints { make in
      make.top.equalTo(aboutAccompanyTitle.snp.bottom)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.95)
    }
  }

}

extension
