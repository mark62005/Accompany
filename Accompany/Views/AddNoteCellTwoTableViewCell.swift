//
//  AddNoteCellTwoTableViewCellTableViewCell.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-10.
//

import UIKit
import SnapKit

class AddNoteCellTwoTableViewCell: UITableViewCell {

  let noteTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = .boldSystemFont(ofSize: 15)
    textView.isUserInteractionEnabled = true
    return textView
  }()
  
  let addNoteTVC = AddNoteDetailsTableViewController()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addSubview(noteTextView)
    noteTextView.snp.makeConstraints{(make) in
      make.top.bottom.equalTo(0)
      make.left.equalTo(0).offset(15)
      make.right.equalTo(0).offset(-15)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

