//
//  RecordsViewController.swift
//  Accompany
//
//  Created by Mark Wong on 2022-02-04.
//

import UIKit
import SnapKit

class RecordsViewController: UIViewController {
  
  let button: UIButton = {
    let button = UIButton()
    button.setTitle("Go Baby Album", for: .normal)
    button.addTarget(self, action: #selector(gotoBabyAlbum(_:)), for: .touchUpInside)
    button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3882352941, blue: 0.5333333333, alpha: 1)
    button.layer.cornerRadius = 10
    return button
  }()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBtnLayout()
      
      
      
      
     

        // Do any additional setup after loading the view.
    }
  
  @objc func gotoBabyAlbum(_ button: UIButton) {
    let babyVC = BabySonogramController()
    babyVC.babyTitleLabel.text = "Baby's Sonogram"
    
    navigationController?.pushViewController(babyVC, animated: true)
  }
    
    func setupBtnLayout() {
      view.addSubview(button)
      button.snp.makeConstraints { make in
        make.centerX.equalTo(view)
        make.centerY.equalTo(view)
        make.width.equalTo(150)
        make.height.equalTo(40)
        
      }
      
    }
    
    
  }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


