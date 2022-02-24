//
//  ProfileCell.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-22.
//
import UIKit

class ProfileCell: UITableViewCell {
  
  static let identifier = "ProfileCell"

  let label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.textColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    addSubview(label)
    
    label.snp.makeConstraints { make in
      make.edges.equalTo(0).inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10))
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with value: String) {
    self.label.text = value
  }

}
