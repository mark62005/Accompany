//
//  DoctorNoteViewController.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//

import UIKit
import SnapKit

class DoctorNoteViewController: UIViewController {

  var noteContent : String?
  
  let titleLabel : UILabel = {
    let label = UILabel()
    label.text = """
                  Q&A To
                  Obstetrician
                """
    label.font = UIFont(name: "SimpleBoy", size: 50)
    label.textColor = #colorLiteral(red: 0.9926157594, green: 0.3876789808, blue: 0.5335384011, alpha: 1)
    label.numberOfLines = 2
    label.textAlignment = .center
    label.setLineSpacing(lineSpacing: 1, lineHeightMultiple: 0.5)
    
    return label
  }()
  
  let rightBarButton : UIButton = {
    let button = UIButton()
    button.setTitle("Edit", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    return button
  }()
  
  let DrNoteTextView : UITextView = {
    let textView = UITextView()
    textView.isUserInteractionEnabled = false
    textView.font = .boldSystemFont(ofSize: 20)
    return textView
  }()
  
  let noteViewContainer : UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  let titleAndNoteStackView : UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fill
    //stackView.spacing = 20
    stackView.alignment = .center
    return stackView
  }()
  
  var isEditingTextView : Bool = false {
    didSet {
      rightBarButton.setTitle(isEditingTextView ? "Save" : "Edit", for: .normal)
      if isEditingTextView {
        DrNoteTextView.becomeFirstResponder()
      } else {
        noteContent = DrNoteTextView.text
      }
      DrNoteTextView.isUserInteractionEnabled.toggle()
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.8832569771, alpha: 1)
      
      addSubview()
      
      DrNoteTextView.text = noteContent
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
      rightBarButton.addTarget(self, action: #selector(rightBarButtonTapped), for: .touchUpInside)
    }
    
  private func addSubview() {
    noteViewContainer.addSubview(DrNoteTextView)
    titleAndNoteStackView.addArrangedSubview(titleLabel)
    titleAndNoteStackView.addArrangedSubview(noteViewContainer)
    view.addSubview(titleAndNoteStackView)
    addConstraints()
  }
  
  private func addConstraints() {
    titleAndNoteStackView.snp.makeConstraints { make in
      make.edges.equalTo(UIEdgeInsets(top: 100, left: 30, bottom: 100, right: 30))
    }
    
    noteViewContainer.snp.makeConstraints{ make in
      make.left.right.bottom.equalTo(0)
      make.top.equalTo(titleLabel.snp.bottom)
    }
    
    DrNoteTextView.snp.makeConstraints{ make in
      make.edges.equalTo(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    }
    
    rightBarButton.snp.makeConstraints{ make in
      make.width.equalTo(40)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.left.right.equalTo(0)
      make.height.equalTo(175)
    }
  }
  
  @objc func rightBarButtonTapped() {
    isEditingTextView.toggle()
  }
}
