//
//  Contraction.swift
//  Accompany
//
//  Created by Kelbin David on 2022-02-17.
//

import Foundation

struct Contractions {
  let contractionDate: Date?
  var contractionRecord = [Detail]()
  
  var dictionary: [String: Any] {
    return [
      "date": contractionDate!,
      "records": contractionRecord.map { $0.dictionary }
    ]
  }
}

struct Detail {
  let state : String?
  let length : String?
  
  var dictionary: [String: Any] {
    return [
      "state": state ?? "",
      "length": length ?? ""
    ]
  }
}
