//
//  TitleLabel.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-16.
//

import UIKit
import SnapKit

class TitleLabel: UILabel {
  
  enum Size {
    case small, medium, large
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  convenience init(title: String?, size: Size = .medium) {
    self.init(frame: .zero)
    self.textColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    self.textAlignment = .center
    self.translatesAutoresizingMaskIntoConstraints = false
    
    if let title = title {
      self.text = title
    }
    
    switch size {
    case .small:
      self.font = UIFont(name: "SimpleBoy", size: 40)
    case .medium:
      self.font = UIFont(name: "SimpleBoy", size: 60)
    case .large:
      self.font = UIFont(name: "SimpleBoy", size: 80)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLayout(superView: UIView) {
    self.snp.makeConstraints { make in
      make.top.equalTo(superView).offset(30)
      make.centerX.equalTo(superView)
      make.width.equalTo(superView.snp.width).multipliedBy(0.8)
    }
  }

}
