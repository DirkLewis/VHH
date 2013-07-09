#import "DDLog.h"

#define klogContextAuthenticationError 0
#define klogContextAuthenticationWarning 1
#define klogContextAuthenticationInformation 2
#define klogContextAuthenticationVerbose 3

#define klogContextAccessError 4
#define klogContextAccessWarning 5
#define klogContextAccessInformation 6
#define klogContextAccessVerbose 7

#define klogContextDocumentError 8
#define klogContextDocumentWarning 9
#define klogContextDocumentInformation 10
#define klogContextDocumentVerbose 11

#define klogContextSystemError 12
#define klogContextSystemWarning 13
#define klogContextSystemInformation 14
#define klogContextSystemVerbose 15

#define klogContextPerformance 100


#define LOG_FLAG_AUTH_ERROR         (1 << 4)  //     16
#define LOG_FLAG_AUTH_WARN          (1 << 5)  //     32
#define LOG_FLAG_AUTH_INFO          (1 << 6)  //     64
#define LOG_FLAG_AUTH_VERBOSE       (1 << 7)  //    128 

#define LOG_FLAG_DOCUMENT_ERROR     (1 << 8)  //    256
#define LOG_FLAG_DOCUMENT_WARN      (1 << 9)  //    512
#define LOG_FLAG_DOCUMENT_INFO      (1 << 10) //   1024
#define LOG_FLAG_DOCUMENT_VERBOSE   (1 << 11) //   2048

#define LOG_FLAG_ACCESS_ERROR       (1 << 12) //   4096
#define LOG_FLAG_ACCESS_WARN        (1 << 13) //   8192
#define LOG_FLAG_ACCESS_INFO        (1 << 14) //  16384
#define LOG_FLAG_ACCESS_VERBOSE     (1 << 15) //  32768
//#define SOMETHING_HERE            (1 << 16) //  65536  
#define LOG_FLAG_SYSTEM_ERROR       (1 << 17) // 131702
#define LOG_FLAG_SYSTEM_WARN        (1 << 18) // 262144
#define LOG_FLAG_SYSTEM_INFO        (1 << 19) // 524288
#define LOG_FLAG_SYSTEM_VERBOSE     (1 << 20) //1048576

#define LOG_FLAG_PERFORMANCE_ON     (1 << 21) //2097152

#define LOG_AUTH_ERROR          (ddLogLevel & LOG_FLAG_AUTH_ERROR)
#define LOG_AUTH_WARN           (ddLogLevel & LOG_FLAG_AUTH_WARN)
#define LOG_AUTH_INFO           (ddLogLevel & LOG_FLAG_AUTH_INFO)
#define LOG_AUTH_VERBOSE        (ddLogLevel & LOG_FLAG_AUTH_VERBOSE)

#define LOG_DOCUMENT_ERROR      (ddLogLevel & LOG_FLAG_DOCUMENT_ERROR)
#define LOG_DOCUEMNT_WARN       (ddLogLevel & LOG_FLAG_DOCUMENT_WARN)
#define LOG_DOCUMENT_INFO       (ddLogLevel & LOG_FLAG_DOCUMENT_INFO)
#define LOG_DOCUMENT_VERBOSE    (ddLogLevel & LOG_FLAG_DOCUMENT_VERBOSE)

#define LOG_ACCESS_ERROR        (ddLogLevel & LOG_FLAG_ACCESS_ERROR)
#define LOG_ACCESS_WARN         (ddLogLevel & LOG_FLAG_ACCESS_WARN)
#define LOG_ACCESS_INFO         (ddLogLevel & LOG_FLAG_ACCESS_INFO)
#define LOG_ACCESS_VERBOSE      (ddLogLevel & LOG_FLAG_ACCESS_VERBOSE)

#define LOG_SYSTEM_ERROR        (ddLogLevel & LOG_FLAG_SYSTEM_ERROR)
#define LOG_SYSTEM_WARN         (ddLogLevel & LOG_FLAG_SYSTEM_WARN)
#define LOG_SYSTEM_INFO         (ddLogLevel & LOG_FLAG_SYSTEM_INFO)
#define LOG_SYSTEM_VERBOSE      (ddLogLevel & LOG_FLAG_SYSTEM_VERBOSE)

#define LOG_PERFORMANCE         (ddLogLevel & LOG_FLAG_PERFORMANCE_ON)


#define ROLogAuthError(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_AUTH_ERROR,  klogContextAuthenticationError, frmt, ##__VA_ARGS__)
#define ROLogAuthWarning(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_AUTH_WARN,  klogContextAuthenticationWarning, frmt, ##__VA_ARGS__)
#define ROLogAuthInformation(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_AUTH_INFO,  klogContextAuthenticationInformation, frmt, ##__VA_ARGS__)
#define ROLogAuthVerbose(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_AUTH_VERBOSE,  klogContextAuthenticationVerbose, frmt, ##__VA_ARGS__)

#define ROLogDocumentError(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_DOCUMENT_ERROR,  klogContextDocumentError, frmt, ##__VA_ARGS__)
#define ROLogDocumentWarning(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_DOCUMENT_WARN,  klogContextDocumentWarning, frmt, ##__VA_ARGS__)
#define ROLogDocumentInformation(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_DOCUMENT_INFO,  klogContextDocumentInformation, frmt, ##__VA_ARGS__)
#define ROLogDocumentVerbose(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_DOCUMENT_VERBOSE,  klogContextDocumentVerbose, frmt, ##__VA_ARGS__)

#define ROLogAccessError(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_ACCESS_ERROR,  klogContextAccessError, frmt, ##__VA_ARGS__)
#define ROLogAccessWarning(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_ACCESS_WARN,  klogContextAccessWarning, frmt, ##__VA_ARGS__)
#define ROLogAccessInformation(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_ACCESS_INFO,  klogContextAccessInformation, frmt, ##__VA_ARGS__)
#define ROLogAccessVerbose(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_ACCESS_VERBOSE,  klogContextAccessVerbose, frmt, ##__VA_ARGS__)

#define ROLogSystemError(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_SYSTEM_ERROR,  klogContextSystemError, frmt, ##__VA_ARGS__)
#define ROLogSystemWarning(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_SYSTEM_WARN,  klogContextSystemWarning, frmt, ##__VA_ARGS__)
#define ROLogSystemInformation(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_SYSTEM_INFO,  klogContextSystemInformation, frmt, ##__VA_ARGS__)
#define ROLogSystemVerbose(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_SYSTEM_VERBOSE,  klogContextSystemVerbose, frmt, ##__VA_ARGS__)

#define ROLogPerformance(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(ddLogLevel, LOG_FLAG_PERFORMANCE_ON,  klogContextPerformance, frmt, ##__VA_ARGS__)


#define LOG_LEVEL_AUTH_OFF     0
#define LOG_LEVEL_AUTH_ERROR   (LOG_FLAG_AUTH_ERROR)                                                                   
#define LOG_LEVEL_AUTH_WARN    (LOG_FLAG_AUTH_ERROR | LOG_FLAG_AUTH_WARN)                                              
#define LOG_LEVEL_AUTH_INFO    (LOG_FLAG_AUTH_ERROR | LOG_FLAG_AUTH_WARN | LOG_FLAG_AUTH_INFO)                         
#define LOG_LEVEL_AUTH_VERBOSE (LOG_FLAG_AUTH_ERROR | LOG_FLAG_AUTH_WARN | LOG_FLAG_AUTH_INFO | LOG_FLAG_AUTH_VERBOSE) 

#define LOG_LEVEL_DOCUMENT_OFF     0
#define LOG_LEVEL_DOCUMENT_ERROR   (LOG_FLAG_DOCUMENT_ERROR)                                                                   
#define LOG_LEVEL_DOCUMENT_WARN    (LOG_FLAG_DOCUMENT_ERROR | LOG_FLAG_DOCUMENT_WARN)                                              
#define LOG_LEVEL_DOCUMENT_INFO    (LOG_FLAG_DOCUMENT_ERROR | LOG_FLAG_DOCUMENT_WARN | LOG_FLAG_DOCUMENT_INFO)                         
#define LOG_LEVEL_DOCUMENT_VERBOSE (LOG_FLAG_DOCUMENT_ERROR | LOG_FLAG_DOCUMENT_WARN | LOG_FLAG_DOCUMENT_INFO | LOG_FLAG_DOCUMENT_VERBOSE)

#define LOG_LEVEL_ACCESS_OFF     0
#define LOG_LEVEL_ACCESS_ERROR   (LOG_FLAG_ACCESS_ERROR)                                                                   
#define LOG_LEVEL_ACCESS_WARN    (LOG_FLAG_ACCESS_ERROR | LOG_FLAG_ACCESS_WARN)                                              
#define LOG_LEVEL_ACCESS_INFO    (LOG_FLAG_ACCESS_ERROR | LOG_FLAG_ACCESS_WARN | LOG_FLAG_ACCESS_INFO)                         
#define LOG_LEVEL_ACCESS_VERBOSE (LOG_FLAG_ACCESS_ERROR | LOG_FLAG_ACCESS_WARN | LOG_FLAG_ACCESS_INFO | LOG_FLAG_ACCESS_VERBOSE)

#define LOG_LEVEL_SYSTEM_OFF     0
#define LOG_LEVEL_SYSTEM_ERROR   (LOG_FLAG_SYSTEM_ERROR)                                                                   
#define LOG_LEVEL_SYSTEM_WARN    (LOG_FLAG_SYSTEM_ERROR | LOG_FLAG_SYSTEM_WARN)                                              
#define LOG_LEVEL_SYSTEM_INFO    (LOG_FLAG_SYSTEM_ERROR | LOG_FLAG_SYSTEM_WARN | LOG_FLAG_SYSTEM_INFO)                         
#define LOG_LEVEL_SYSTEM_VERBOSE (LOG_FLAG_SYSTEM_ERROR | LOG_FLAG_SYSTEM_WARN | LOG_FLAG_SYSTEM_INFO | LOG_FLAG_SYSTEM_VERBOSE)

#define LOG_LEVEL_PERFORMANCE_OFF   0
#define LOG_LEVEL_PERFORMANCE_ON    (LOG_FLAG_PERFORMANCE_ON)


