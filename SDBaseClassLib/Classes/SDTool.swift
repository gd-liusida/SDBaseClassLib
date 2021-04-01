//
//  SDTool.swift
//  SDBaseClassLib
//
//  Created by Liu Sida on 2021/3/21.
//

import UIKit

/// 模拟器判断
public struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
        isSim = true
        #endif
        return isSim
    }()
}

public class SDTool: NSObject {

    /// 控制台输出内容
    public class func log<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
        if Platform.isSimulator {
            print("<\((file as NSString).lastPathComponent) : \(line)>, \(method) \(message)")
        }
    }
    
    /// data 转换JSON
    @discardableResult
    public class func dataOfJsonString(_ item: Any) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: item, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            if let jsonStr = String.init(data: data, encoding: .utf8) {
                return jsonStr
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    /// JSON 转类型
    @discardableResult
    public class func jsonStringOfData(_ jsonStr: String) -> Any {
        guard let jsonData = jsonStr.data(using: String.Encoding.utf8) else { return "" }
        do {
            let item = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
            return item
        } catch  {
            log(error)
        }
        return ""
    }
    
    @discardableResult
    public class func pathOfData<T: Codable>(_ type: T.Type, for resource: String, ofType: String) -> T? {
        guard let data = SDTool.fileData(for: resource, of: ofType) else {
            return nil
        }
        do {
            let json = try JSONDecoder().decode(type, from: data)
            return json
        } catch {
            SDTool.log("json error")
        }
        return nil
    }
    
    @discardableResult
    public class func path(for resource: String, of type: String) -> String? {
        guard let path = Bundle.main.path(forResource: resource, ofType: type) else {
            return nil
        }
        return path
    }
    
    @discardableResult
    public class func fileData(for resource: String, of type: String) -> Data? {
        guard let path = SDTool.path(for: resource, of: type) else {
            return nil
        }
        guard let data = NSData.init(contentsOfFile: path) else {
            return nil
        }
        return data as Data
    }
    
    @discardableResult
    public class func getUUIDString() -> String {
        guard let identifier = UIDevice.current.identifierForVendor else {
            return ""
        }
        return identifier.uuidString
    }
    
    public class func save<T: Codable>(_ model: T, name: String) {
        let path = getSavePath(name)
        do {
            SDTool.clear(name)
            let userInfoSetData = try PropertyListEncoder().encode(model)
            if #available(iOS 11.0, *) {
                let archivedData = try NSKeyedArchiver.archivedData(withRootObject: userInfoSetData, requiringSecureCoding: true)
                try archivedData.write(to: URL(fileURLWithPath: path))
            } else {
                NSKeyedArchiver.archiveRootObject(userInfoSetData, toFile: path)
            }
        } catch {
            SDTool.log(error.localizedDescription)
        }
    }
    
    @discardableResult
    public class func read<T: Codable>(_ name: String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: getSavePath(name)))
            let archivedData: Data? = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data
            guard let _archivedData = archivedData else {
                return nil
            }
            let decoder = PropertyListDecoder()
            let model = try decoder.decode(T.self, from: _archivedData)
            return model
        } catch {
            SDTool.log(error.localizedDescription)
        }
        return nil
    }
    
    public class func clear(_ name: String) {
        let savePath = getSavePath(name)
        if FileManager.default.fileExists(atPath: savePath) {
            do {
                try FileManager.default.removeItem(atPath: savePath)
                SDTool.log("delete file success: \(savePath)")
            } catch {
                SDTool.log("delete file failure: \(error.localizedDescription)")
            }
        }
    }
    
    @discardableResult
    public class func getSavePath(_ name: String) -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let savePath = documentDirectory.appending(name)
        return savePath
    }

    
}
