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
  
  let titleLabel = TitleLabel(title: "Q&A To\nObstetrician", size: .medium, color: .red)

  let rightBarButton : UIButton = {
    let button = UIButton()
    button.setTitle("Edit", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  let DrNoteTextView : UITextView = {
    let textView = UITextView()
    textView.isUserInteractionEnabled = false
    textView.font = .boldSystemFont(ofSize: 20)
    textView.translatesAutoresizingMaskIntoConstraints = false
    
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
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
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
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9411764706, blue: 0.9568627451, alpha: 1)
    
    addSubview()
    
    titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    
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
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
    }
  }
  
  @objc func rightBarButtonTapped() {
    isEditingTextView.toggle()
    
  }
}
