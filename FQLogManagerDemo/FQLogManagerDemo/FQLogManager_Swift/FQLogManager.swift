//
//  FQLogManager.swift
//  ColaSoundProject
//
//  Created by zpp on 2020/9/16.
//  Copyright © 2020 owen. All rights reserved.
//

import UIKit
import CocoaLumberjack

public func FQLogE(_ message: @autoclosure () -> String = "-",
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line) {
    BLog_e(message(), file: file, function: function, line: line)
}

public func FQLogW(_ message: @autoclosure () -> String = "-",
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line) {
    BLog_w(message(), file: file, function: function, line: line)
}

public func FQLogI(_ message: @autoclosure () -> String = "-",
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line) {
    BLog_i(message(), file: file, function: function, line: line)
}

public func FQLogD(_ message: @autoclosure () -> String = "-",
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line) {
    BLog_d(message(), file: file, function: function, line: line)
}

public func FQLogV(_ message: @autoclosure () -> String = "-",
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line) {
    BLog_v(message(), file: file, function: function, line: line)
}

public func FQLog(_ message: @autoclosure () -> String = "-",
                  file: StaticString = #file,
                  function: StaticString = #function,
                  line: UInt = #line) {
    BLog(message(), file: file, function: function, line: line)
}

/// Common
fileprivate func _BLog(_ message: @autoclosure () -> String,
                       level: DDLogLevel = DDDefaultLogLevel,
                       flag: DDLogFlag,
                       context: Int = 0,
                       file: StaticString = #file,
                       function: StaticString = #function,
                       line: UInt = #line,
                       tag: Any? = nil,
                       asynchronous async: Bool = false,
                       ddlog: DDLog = .sharedInstance) {
    
    _DDLogMessage(message(), level: level, flag: flag, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Default (Verbose)
public func BLog(_ message: @autoclosure () -> String = "-",
                 level: DDLogLevel = DDDefaultLogLevel,
                 context: Int = 0,
                 file: StaticString = #file,
                 function: StaticString = #function,
                 line: UInt = #line,
                 tag: Any? = nil,
                 asynchronous async: Bool = false,
                 ddlog: DDLog = .sharedInstance) {
    _BLog(message(), level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: "none", asynchronous: async, ddlog: ddlog)
}

/// Verbose
public func BLog_v(_ verbose: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(verbose(), level: level, flag: .verbose, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Debug
public func BLog_d(_ debug: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(debug(), level: level, flag: .debug, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Info
public func BLog_i(_ info: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(info(), level: level, flag: .info, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Warning
public func BLog_w(_ warning: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(warning(), level: level, flag: .warning, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}

/// Error
public func BLog_e(_ error: @autoclosure () -> String = "-",
                   level: DDLogLevel = DDDefaultLogLevel,
                   context: Int = 0,
                   file: StaticString = #file,
                   function: StaticString = #function,
                   line: UInt = #line,
                   tag: Any? = nil,
                   asynchronous async: Bool = false,
                   ddlog: DDLog = .sharedInstance) {
    _BLog(error(), level: level, flag: .error, context: context, file: file, function: function, line: line, tag: tag, asynchronous: async, ddlog: ddlog)
}




class FQLogManager {
    
    #if DEBUG
    private var ddLogLevel: DDLogLevel = DDLogLevel.debug
    #else
    private var ddLogLevel: DDLogLevel = DDLogLevel.warning
    #endif
    
    //控制台logger
    private var fileLogger: DDFileLogger = {
        let logManage = FQLogFileManager()
        let fileLogger = DDFileLogger(logFileManager: logManage)
        fileLogger.logFormatter = FQFileLogFormatter() as? DDLogFormatter
        //重用log文件，不要每次启动都创建新的log文件(默认值是NO)
        fileLogger.doNotReuseLogFiles = false
        //log文件在24小时内有效，超过时间创建新log文件(默认值是24小时)
        fileLogger.rollingFrequency = 60 * 60 * 24
        //log文件的最大3M(默认值1M)
        fileLogger.maximumFileSize = 1024 * 1024 * 3
        //最多保存7个log文件(默认值是5)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        //log文件夹最多保存10M(默认值是20M)
        fileLogger.logFileManager.logFilesDiskQuota = 1024 * 1024 * 10
        
        return fileLogger
    }()
    //文件写入Logger
    private var osLogger: DDOSLogger = {
        let osLogger = DDOSLogger.sharedInstance
        //自定义输出格式
        osLogger.logFormatter = FQLogFormatter() as? DDLogFormatter
        return osLogger
    }()

    //单例
    public static let shareInstance: FQLogManager = {
        let shareInstance = FQLogManager()
        return shareInstance
    }()
    //添加控制台logger
    public func addOSLogger() {
        DDLog.add(osLogger)
    }
    //添加文件写入Logger
    public func addFileLogger() {
        DDLog.add(fileLogger)
    }
    //移除控制台logger
    public func removeOSLogger() {
        DDLog.remove(osLogger)
    }
    //移除文件写入Logger
    public func removeFileLogger() {
        DDLog.remove(fileLogger)
    }
    
    // MARK: 等级切换
    //切换log等级
    public func switchLogLevel(logLevel: DDLogLevel) {
        ddLogLevel = logLevel
    }

    // MARK: 文件Log操作
    public func createAndRollToNewFile() {
        fileLogger.rollLogFile {
            print("rollLogFileWithCompletionBlock")
        }
        
    }
    //所有log文件路径
    public func filePaths() -> Array<Any> {
        return fileLogger.logFileManager.sortedLogFilePaths
    }
    //当前活跃的log文件路径
    public func currentFilePath() -> String {
        return fileLogger.currentLogFileInfo?.filePath ?? ""
    }
    
    
    
    
}
