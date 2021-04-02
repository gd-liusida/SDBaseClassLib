//
//  SDAsyncs.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/4/3.
//

import UIKit

public typealias SDTask = () -> Void

public struct SDAsyncs {
    // MARK: 1.1、异步做一些任务
    /// 异步做一些任务
    /// - Parameter SDTask: 任务
    @discardableResult
    public static func async(_ sdTask: @escaping SDTask) -> DispatchWorkItem {
        return _asyncDelay(0, sdTask)
    }
    
    // MARK: 1.2、异步做任务后回到主线程做任务
    /// 异步做任务后回到主线程做任务
    /// - Parameters:
    ///   - SDTask: 异步任务
    ///   - mainSDTask: 主线程任务
    @discardableResult
    public static func async(_ sdTask: @escaping SDTask,
                             _ mainSDTask: @escaping SDTask) -> DispatchWorkItem{
        return _asyncDelay(0, sdTask, mainSDTask)
    }
    
    // MARK: 1.3、异步延迟(子线程执行任务)
    /// 异步延迟(子线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter SDTask: 延迟的block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ sdTask: @escaping SDTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, sdTask)
    }
    
    // MARK: 1.4、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// 异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter JKTask: 延迟的block
    /// - Parameter mainJKTask: 延迟的主线程block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ sdTask: @escaping SDTask,
                                  _ mainSDTask: @escaping SDTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, sdTask, mainSDTask)
    }
}

// MARK:- 私有的方法
extension SDAsyncs {
    
    /// 延迟任务
    /// - Parameters:
    ///   - seconds: 延迟时间
    ///   - JKTask: 任务
    ///   - mainJKTask: 任务
    /// - Returns: DispatchWorkItem
    fileprivate static func _asyncDelay(_ seconds: Double,
                                        _ sdTask: @escaping SDTask,
                                        _ mainSDTask: SDTask? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: sdTask)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainSDTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}

