//
//  FQFileLogFormatter.swift
//  ColaSoundProject
//
//  Created by zpp on 2020/9/16.
//  Copyright © 2020 owen. All rights reserved.
//

import UIKit
import CocoaLumberjack

class FQFileLogFormatter: NSObject , DDLogFormatter {

    //实现方法
    func format(message logMessage: DDLogMessage) -> String? {
        var logLevel: String = ""
        switch (logMessage.flag) {
            case DDLogFlag.error:
                logLevel = "Error"
            case DDLogFlag.warning:
                logLevel = "Warn"
            case DDLogFlag.info:
                logLevel = "Info"
            case DDLogFlag.debug:
                logLevel = "Debug"
            default:
                logLevel = "Verbose"
        }
        let function = FQFileLogFormatter.funcCut(logMessage.function)
        return String(format: "%@ [FQ]%@-%@-%@-%lu\n%@", getTimeString(with: logMessage.timestamp) , logLevel, logMessage.fileName, function, UInt(logMessage.line ), logMessage.message)
    }
    static let getTimeStringDateFormatter: DateFormatter? = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss.SSS"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 8 * 60 * 60) as TimeZone
        return dateFormatter
    }()

    func getTimeString(with date: Date?) -> String {
        // `dispatch_once()` call was converted to a static variable initializer
        if let date = date {
            return FQFileLogFormatter.getTimeStringDateFormatter?.string(from: date) ?? ""
        }
        return ""
    }
    
    /// 方法名简化
    static fileprivate func funcCut(_ funcStr: String?) -> String {
        
        guard let funcStr = funcStr else {
            return "-"
        }
        
        guard let range = funcStr.range(of: "(") else {
            return funcStr
        }
        
        return String(funcStr[funcStr.startIndex ..< range.lowerBound])
    }
    
}
