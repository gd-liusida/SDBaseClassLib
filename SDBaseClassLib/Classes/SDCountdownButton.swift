//
//  SDCountdownButton.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/21.
//

import UIKit

class SDCountdownButton: UIButton {

    var countdownTime = SDTimerTool()
    var seconds: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setTime() {
//        countdownTime.dis
    }
    
    @objc func startTime() {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
