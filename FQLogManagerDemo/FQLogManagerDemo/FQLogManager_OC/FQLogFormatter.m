//
//  FQLogFormatter.m
//  FQColaSoundProject
//
//  Created by owen on 2020/7/3.
//  Copyright © 2020 owen. All rights reserved.
//

#import "FQLogFormatter.h"

@implementation FQLogFormatter


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
    NSString *formatLog = [NSString stringWithFormat:@"[FQ]%@%@-%lu\n%@",logLevel,logMessage->_function,(unsigned long)logMessage->_line,logMessage->_message];
     return formatLog;
}


@end
