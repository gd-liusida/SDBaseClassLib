//
//  SDCountdownButton.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/21.
//

import UIKit

public class SDCountdownButton: UIButton {

    var countdownTime = SDTimerTool()
    var seconds: Int = 0
//    var titleStr: String {
//        didSet {
//            self.setTitle(titleStr, for: .normal)
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setTime() {
        countdownTime.dispatchTime(1) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.handTimer()
        }
    }
    
    @objc func handTimer() {
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
