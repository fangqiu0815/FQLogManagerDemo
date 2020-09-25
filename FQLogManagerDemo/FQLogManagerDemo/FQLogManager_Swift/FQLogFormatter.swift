//
//  FQLogFormatter.swift
//  ColaSoundProject
//
//  Created by zpp on 2020/9/16.
//  Copyright © 2020 owen. All rights reserved.
//

import UIKit
import CocoaLumberjack

class FQLogFormatter: NSObject , DDLogFormatter {

    //实现方法
    func format(message logMessage: DDLogMessage) -> String? {
        var logLevel: String = ""
        switch logMessage.flag {
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
        let funcStr = FQLogFormatter.funcCut(logMessage.function)
        return String(format: "[FQ]-\(logLevel)-\(logMessage.fileName)-\(funcStr)-\(logMessage.line)\n\(logMessage.message)" )
    }
    
    /// 时间格式
    static fileprivate func dateToLocalStr(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.dateFormat = "yyMMdd.HHmmss"
        
        return formatter.string(from: date)
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
