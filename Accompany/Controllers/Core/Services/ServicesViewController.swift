//
//  ServicesViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit

enum Services: CustomStringConvertible, CaseIterable {
  
  case myProfile
  case invitePartner
  case accountSettings
  case pregnantArticles
  case aboutAccompany
  case logOut
  
  var description: String {
    switch self {
    case .myProfile:
      return "My Profile"
    case .invitePartner:
      return "Invite Partner"
    case .accountSettings:
      return "Account Settings"
    case .pregnantArticles:
      return "Pregnant Articles"
    case .aboutAccompany:
      return "About Accompany"
    case .logOut:
      return "Log Out"
    }
  }
  
}

class ServicesViewController: UIViewController {
  
  let titleLabel = TitleLabel(title: nil, size: .large, color: .red)
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupTitleLabel()
    setupButtons()
  }
  
  private func setupTitleLabel() {
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setupButtons() {
    var buttons = [UIButton]()
    for i in 0..<Services.allCases.count {
      switch i {
      case 0, 1:
        buttons.append(SecondaryButton(title: Services.allCases[i].description))
      case 2, 3, 4:
        buttons.append(PrimaryButton(title: Services.allCases[i].description))
      case 5:
        buttons.append(OutlineButton(title: Services.allCases[i].description))
      default:
        return
      }

      buttons[i].addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside)
    }
    
    buttons.forEach { $0.addTarget(self, action: #selector(goTo(_:)), for: .touchUpInside) }
    
    let vStack = VStack(arrangedSubviews: buttons)
    view.addSubview(vStack)
    
    vStack.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(50)
      make.centerX.equalTo(view.safeAreaLayoutGuide)
      make.width.equalTo(view.snp.width).multipliedBy(0.55)
    }
  }
  
  @objc func goTo(_ button: UIButton) {
    switch button.titleLabel?.text {
    // My Profile
    case Services.myProfile.description:
      let myProfileVC = MyProfileViewController()
      
      // TODO: fetch user info
      
      navigationController?.pushViewController(myProfileVC, animated: true)
    // Invite Partner
    case Services.invitePartner.description:
      let invitePartnerVC = InvitePartnerViewController()
      
      // TODO: do something?
      
      navigationController?.pushViewController(invitePartnerVC, animated: true)
    // Account Settings
    case Services.accountSettings.description:
      navigationController?.pushViewController(AccountSettingsViewController(), animated: true)
    // Pregnant Articles
    case Services.pregnantArticles.description:
      let pregnantArticlesTVC = PregnantArticlesTableViewController()
      
      // TODO: fetch articles
      
      navigationController?.pushViewController(pregnantArticlesTVC, animated: true)
    // About Accompany
    case Services.aboutAccompany.description:
      navigationController?.pushViewController(AboutAccompanyViewController(), animated: true)
    // Log Out
    case Services.logOut.description:
      navigationController?.pushViewController(LogOutViewController(), animated: true)
    default:
      return
    }
  }
    
}
