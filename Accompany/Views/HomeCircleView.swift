//
//  HomeCircleView.swift
//  Accompany
//
//  Created by Esperanza on 2022-02-13.
//

import Foundation
import UIKit

@IBDesignable
class HomeCircleView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: .zero)
    self.backgroundColor = #colorLiteral(red: 0.631372549, green: 0.631372549, blue: 0.631372549, alpha: 1)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

func draw(_ rect: CGRect) {

       guard let context = UIGraphicsGetCurrentContext() else {
           print("could not get graphics context")
           return
       }

       context.setLineWidth(2)

       context.setStrokeColor(UIColor.blue.cgColor)

       context.addEllipse(in: CGRect(x: 30, y: 30, width: 50.0, height: 50.0))

       context.strokePath()

       context.setStrokeColor(UIColor.red.cgColor)

       context.beginPath() // this prevents a straight line being drawn from the current point to the arc

       context.addArc(center: CGPoint(x:100, y: 100), radius: 20, startAngle: 0, endAngle: 2.0*CGFloat.pi, clockwise: false)

       context.strokePath()
   }
}

}
