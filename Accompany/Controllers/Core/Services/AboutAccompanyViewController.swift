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
    contentTableView.register(ContentCell.self, forCellReuseIdentifier: ContentCell.identifier)
    contentTableView.isUserInteractionEnabled = true
    contentTableView.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    contentTableView.separatorStyle = .none
    
    return contentTableView
  }()
 
  let contentCell = ContentCell()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
  
    configureTableView()
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
    
    view.addSubview(contentTableView)
    
    contentTableView.snp.makeConstraints { make in
      make.top.equalTo(aboutAccompanyTitle.snp.bottom)
      make.centerX.equalTo(view)
      make.width.equalTo(view.snp.width).multipliedBy(0.95)
      make.height.equalTo(view.snp.height).multipliedBy(0.7)
    }
  }

}

extension AboutAccompanyViewController: UITableViewDelegate {
  
}

extension AboutAccompanyViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContentCell.identifier, for: indexPath) as! ContentCell

    return cell
  }
    
}
