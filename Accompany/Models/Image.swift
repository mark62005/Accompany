//
//  Image.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-25.
//

import Foundation
import UIKit

struct Image: Hashable {
  var id: Int
  var uiImage: UIImage
  var category: BabySonogramController.Section
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(uiImage)
    hasher.combine(category)
  }
  
  static func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.id == rhs.id && lhs.category == rhs.category
  }
  
}
