//
//  SDTimerTool.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/21.
//

import UIKit

/// 控制定时器的类
public class SDTimerTool: NSObject {
    
    /// GCD 定时器
    private var GCDTimer: DispatchSourceTimer?
    
    /// GCD定时器的挂起状态
    private var isSuspend: Bool = false
    
    override init() {
        super.init()
    }
    
    deinit {
        self.invaliGCDTimer()
    }
    
    
}

public extension SDTimerTool {
    /// 初始化得到GCD定时器
    func dispatchTime(_ timeInterval: TimeInterval, handleBlock: @escaping (() -> Void)) {
        if self.GCDTimer == nil {
            self.GCDTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            self.GCDTimer?.schedule(deadline: DispatchTime.now(), repeating: timeInterval)
            self.GCDTimer?.setEventHandler(handler: {
                DispatchQueue.main.async {
                    handleBlock()
                }
            })
            self.GCDTimer?.resume()
            self.GCDTimer?.schedule(deadline: DispatchTime.now(), repeating: timeInterval)
        } else {
            self.stopOrResumeGCDTimer(isStop: false)
        }
    }
    
    /// 暂停或者重启GCDTimer
    func stopOrResumeGCDTimer(isStop: Bool) {
        guard self.isSuspend == isStop else {
            return
        }
        isStop ? self.GCDTimer?.suspend() : self.GCDTimer?.resume()
        self.isSuspend = isStop
    }
    
    /// 销毁GCD定时器
    func invaliGCDTimer() {
        if self.isSuspend {
            self.GCDTimer?.resume()
        }
        self.GCDTimer?.cancel()
        self.GCDTimer = nil
    }
}
