//
//  FQFileLogFormatter.m
//  FQColaSoundProject
//
//  Created by owen on 2020/7/3.
//  Copyright © 2020 owen. All rights reserved.
//

#import "FQFileLogFormatter.h"

@implementation FQFileLogFormatter

//实现方法
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel = nil;
    switch (logMessage->_flag) {
        case DDLogFlagError:
            logLevel = @"Error";
            break;
        case DDLogFlagWarning:
            logLevel = @"Warn";
            break;
        case DDLogFlagInfo:
            logLevel = @"Info";
            break;
        case DDLogFlagDebug:
            logLevel = @"Debug";
            break;
        default:
            logLevel = @"Verbose";
            break;
    }
    NSString *formatLog = [NSString stringWithFormat:@"%@[FQ]%@%@-%lu\n%@",[self getTimeStringWithDate:logMessage->_timestamp], logLevel,logMessage->_function,(unsigned long)logMessage->_line,logMessage->_message];
    return formatLog;
}

- (NSString *)getTimeStringWithDate:(NSDate *)date {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    });
    return [dateFormatter stringFromDate:date];
}


@end
