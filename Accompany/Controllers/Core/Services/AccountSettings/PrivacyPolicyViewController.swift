//
//  PrivacyPolicyViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-17.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    let titleLabel = TitleLabel(title: AccountSettings.privacyPolicy.rawValue, size: .medium)
    
    let policyLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = .systemFont(ofSize: 16, weight: .regular)
      label.numberOfLines = 0
      
      return label
    }()
    
  override func viewDidLoad() {
    super.viewDidLoad()

    title = AccountSettings.privacyPolicy.rawValue
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    setupLayout()
    privacyPolicyText()
  }
    
    
    private func setupLayout() {
    
      let vStack = VStack(arrangedSubviews: [titleLabel, policyLabel])
      vStack.alignment = .center
      
      view.addSubview(vStack)
      vStack.snp.makeConstraints { make in
        make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        make.centerX.equalTo(view)
        make.width.equalTo(view.snp.width).multipliedBy(0.8)
      }
    }
    
    private func privacyPolicyText() {
      
      policyLabel.text = "his Privacy Policy applies to our all of the Services. By accessing or using our Services, or otherwise manifesting your assent to this Privacy Policy, you signify that you have read, understood and agree to our collection, storage, use and disclosure of your personal information as described in this Privacy Policy and our Terms of Use. If you are an individual acting on behalf of a Company, you represent and warrant that you are an authorized representative of Company with the authority to bind Company to this Privacy Policy Administrator, and that you agree to this Privacy Policy on Company’s behalf.Terms not defined in this Privacy Policy will have the meaning set forth in our Terms of Use."
    }
    
    
}
