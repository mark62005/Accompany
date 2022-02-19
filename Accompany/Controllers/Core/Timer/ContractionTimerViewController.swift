//
//  ContractionTimerViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-15.
//

import UIKit

class ContractionTimerViewController: UIViewController {
  
  let timerLabel = TitleLabel(title: "Contraction Timer", size: .medium, color: .red)

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    setupLayout()
  }
  
  private func setupLayout() {
    view.addSubview(timerLabel)
    
    timerLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
    }
  }
    
}
