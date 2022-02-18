//
//  RecordsViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class RecordsViewController: UIViewController {
  
  let recordLabel = TitleLabel(title: "Record While Pregnancy", size: .medium, color: .red)
  
  let goToAlbumButton = PrimaryButton(title: "Photo Album")
  let goToTimerButton = PrimaryButton(title: "Contraction Timer")
  let goToQAButton = PrimaryButton(title: "Q&A To Obstetrician")

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTitle()
    setupButtons()
    
  }
  
  private func setupTitle() {
    
    view.addSubview(recordLabel)
    
    recordLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
      make.width.equalTo(view.snp.width).multipliedBy(0.8)
    }
  }
  
  private func setupButtons() {
    
    let buttons = [goToAlbumButton, goToTimerButton, goToQAButton]
    buttons.forEach { $0.addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside) }
    
    let vStack = VStack(arrangedSubviews: buttons)
    view.addSubview(vStack)
    
    vStack.spacing = 45
  
    
    vStack.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.55)
      make.top.equalTo(recordLabel.snp.bottom).offset(80)
    }

  }
  
  @objc func goTo(_ button: UIButton) {
    let babyVC = BabySonogramController()
    
    navigationController?.pushViewController(babyVC, animated: true)

  }
  
  
}

