//
//  ContentCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-21.
//

import UIKit

class ContentCell: UITableViewCell {
  
  static let identifier = "ContentCell"
 
  let contentTextLabel: UILabel = {
    let contentTextLabel = UILabel()
    contentTextLabel.text = """
    Looking for the most user-friendly pregnant application in the world? Come to Use Accompany!
    
    We want to accompany the person who is ready to deliver the birth. Sometimes, people will be really nervous when they meet lots of problems during this pregnancy cycle. Therefore, we want to be the most useful applications for the pregnant people.

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
    contentTextLabel.numberOfLines = 0
    contentTextLabel.translatesAutoresizingMaskIntoConstraints = false
    
    return contentTextLabel
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    addSubview(contentTextLabel)
    contentTextLabel.snp.makeConstraints{(make) in
      make.edges.equalTo(0).inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
