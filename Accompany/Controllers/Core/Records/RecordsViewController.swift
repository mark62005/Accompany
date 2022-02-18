//
//  RecordsViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class RecordsViewController: UIViewController {
  
//<<<<<<< HEAD
//  let titleLabel : UILabel = {
//    let label = UILabel()
//    label.text = """
//                  Record While
//                  Pregnancy
//                """
//    label.font = UIFont(name: "SimpleBoy", size: 50)
//    label.textColor = #colorLiteral(red: 0.9926157594, green: 0.3876789808, blue: 0.5335384011, alpha: 1)
//    label.numberOfLines = 2
//    label.textAlignment = .center
//    label.setLineSpacing(lineSpacing: 1, lineHeightMultiple: 0.5)
//
//    return label
//  }()
//
//  let photoAlbumButton : UIButton = {
//    let button = UIButton()
//    button.setTitle("Photo Album", for: .normal)
//    button.backgroundColor = #colorLiteral(red: 0.9926157594, green: 0.3876789808, blue: 0.5335384011, alpha: 1)
//    button.layer.cornerRadius = 20
//    button.addTarget(self, action: #selector(photoAlbumButtonTapped), for: .touchUpInside)
//
//    return button
//  }()
//
//  let QAtoObsterianButton : UIButton = {
//    let button = UIButton()
//    button.setTitle("Q&A to Obstetrician", for: .normal)
//    button.addTarget(self, action: #selector(QAtoObsterianButtonTapped), for: .touchUpInside)
//    button.backgroundColor = #colorLiteral(red: 0.9926157594, green: 0.3876789808, blue: 0.5335384011, alpha: 1)
//    button.layer.cornerRadius = 20
//
//    return button
//  }()
//
//  let buttonsStackView : UIStackView = {
//    let stackView = UIStackView()
//    stackView.axis = .vertical
//    stackView.distribution = .equalSpacing
//    stackView.spacing = 50
//    stackView.alignment = .center
//
//    return stackView
//  }()
//
//  let topView : UIView = {
//    let view = UIView()
//    view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8832569771, alpha: 1)
//
//    return view
//  }()
//
//  let bottomView : UIView = {
//    let view = UIView()
//    view.backgroundColor = #colorLiteral(red: 0.980392158, green: 0.980392158, blue: 0.980392158, alpha: 1)
//
//    return view
//  }()
//
//  let dummyBorder : UIView = {
//    let view = UIView()
//    view.backgroundColor = #colorLiteral(red: 0.5476409197, green: 0.4594882727, blue: 0.9680611491, alpha: 1)
//
//    return view
//  }()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8832569771, alpha: 1)
//    addSubView()
//
//    bottomView.frame.size.width = view.frame.width
//    bottomView.frame.size.height = view.frame.height
//    dummyBorder.frame.size.width = view.frame.width
//    dummyBorder.frame.size.height = view.frame.height
//    bottomView.addTopRoundedCornerToView(targetView: bottomView, desiredCurve: 1.5)
//    dummyBorder.addTopRoundedCornerToView(targetView: dummyBorder, desiredCurve: 1.5)
//  }
//
//  private func addSubView() {
//    topView.addSubview(titleLabel)
//    buttonsStackView.addArrangedSubview(photoAlbumButton)
//    buttonsStackView.addArrangedSubview(QAtoObsterianButton)
//    bottomView.addSubview(buttonsStackView)
//
//    view.addSubview(topView)
//    view.addSubview(dummyBorder)
//    view.addSubview(bottomView)
//
//    addConstraints()
//  }
//
//  private func addConstraints() {
//    buttonsStackView.snp.makeConstraints { make in
//      make.center.equalTo(bottomView)
//      make.width.equalTo(200)
//=======
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
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
//>>>>>>> 9903c4c8e23d8a9206e5c617a1558e3302bd1bc9
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
  
  // TODO: NOT DONE
  @objc func goTo(_ button: UIButton) {
    let babyVC = BabySonogramController()
    
    navigationController?.pushViewController(babyVC, animated: true)

  }
  
  
}

