//
//  SDKeyboardAccessory.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

public protocol SDKeyboardAccessoryDelegate: class {
    func keyboardAccessoryDone()
}

public extension SDKeyboardAccessoryDelegate {
    func keyboardAccessoryDone() {}
}

public class SDKeyboardAccessory: UIView {
    public weak var delegate: SDKeyboardAccessoryDelegate?
    public var doneBtn: UIButton = {
        let doneBtn = UIButton(type: .system).title("完成").font(UIFont.systemFont(ofSize: 13))
        doneBtn.addTarget(self, action: #selector(done), for: .touchUpInside)
        return doneBtn
    }()
    
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 36))
        backgroundColor = .white
        doneBtn.frame = CGRect(x: kScreenW - 50, y: 0, width: 50, height: self.sd.height)
        doneBtn.addTo(self)
        let line = UIView().backgroundColor(UIColor.hexStringColor(hexString: "#E6E6E6"))
        line.frame = CGRect(x: 0, y: 0, width: self.sd.width, height: 1)
        line.addTo(self)
    }
    
    @objc func done() {
        if let _delegate = delegate {
            _delegate.keyboardAccessoryDone()
        } else {
            UIApplication.shared.keyWindow?.endEditing(true)
        }
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
