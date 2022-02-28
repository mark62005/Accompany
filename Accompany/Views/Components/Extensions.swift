//
//  Extensions.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-18.
//

import Foundation
import UIKit

extension UILabel {
  // Pass value for any one of both parameters and see result
  func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
    
    guard let labelText = self.text else { return }

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.lineHeightMultiple = lineHeightMultiple
    paragraphStyle.alignment = .center
    
    let attributedString:NSMutableAttributedString
    if let labelattributedText = self.attributedText {
      attributedString = NSMutableAttributedString(attributedString: labelattributedText)
    } else {
      attributedString = NSMutableAttributedString(string: labelText)
    }

    // Line spacing attribute
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

    self.attributedText = attributedString
  }

}

extension Date {
  
  var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
//    dateFormatter.timeStyle = .none
//    dateFormatter.dateStyle = .short
    
    let formattedDate = dateFormatter.string(from: self)
    print("Formatted Date: \(formattedDate)")

    return formattedDate
  }
  
  static func getDateFrom(string str: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    return dateFormatter.date(from: str)
  }
  
}
