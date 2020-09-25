//
//  FQLogFileManager.swift
//  ColaSoundProject
//
//  Created by zpp on 2020/9/16.
//  Copyright © 2020 owen. All rights reserved.
//

import UIKit
import CocoaLumberjack

class FQLogFileManager: DDLogFileManagerDefault {

    fileprivate func newLogFileName() -> String {
        let timeStamp: String = self.getTimestamp() ?? "FQLogFile"
        return timeStamp + ".log"
    }
    
    internal override func isLogFile(withName fileName: String) -> Bool {
        let hasProperSuffix = fileName.hasSuffix(".log")

        return hasProperSuffix
    }
    static let getTimestampDateFormatter: DateFormatter? = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd-HH.mm.ss"
        return dateFormatter
    }()

    func getTimestamp() -> String? {
        // `dispatch_once()` call was converted to a static variable initializer
        return FQLogFileManager.getTimestampDateFormatter?.string(from: NSDate() as Date)
    }
    
}
