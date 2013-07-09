//
//  FileLevelSecurityStrategy.m
//  VHHCoreRepository
//
//  Created by Dirk Lewis on 7/2/13.
//  Copyright (c) 2013 VideoHooHaa. All rights reserved.
//

#import "FileLevelSecurityStrategy.h"
#import "DataEncryption.h"
#import "Repository.h"

@implementation FileLevelSecurityStrategy{

}

#pragma mark - Private
- (NSDictionary*)securityDataPathsForFile:(NSString*)filename{
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *fileNameComponents = [filename componentsSeparatedByString:@"."];
    NSString *securedFileName = [NSString stringWithFormat:@"%@.secured", [fileNameComponents objectAtIndex:0]];
    NSString *backupFileName = [NSString stringWithFormat:@"%@.secured.bak", [fileNameComponents objectAtIndex:0]];
    
    NSString *backupDataPath = [documentsPath stringByAppendingPathComponent:backupFileName];
    NSString *securedDataPath = [documentsPath stringByAppendingPathComponent:securedFileName];
    NSString *unsecuredDataPath = [documentsPath stringByAppendingPathComponent:filename];
    
    NSMutableDictionary *paths = [NSMutableDictionary dictionary];
    
    [paths setObject:securedDataPath forKey:@"SecureDataPath"];
    [paths setObject:unsecuredDataPath forKey:@"UnsecureDataPath"];
    [paths setObject:backupDataPath forKey:@"BackupDataPath"];
    
    return paths;
}


#pragma mark - Protocol

+ (instancetype)securityStrategyInstance{

    return [[self alloc]init];
}

- (BOOL)isRepositorySecured:(Repository*)repository{
    
    NSDictionary *paths = [self securityDataPathsForFile:[repository.backingstore fileName]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:[paths objectForKey:@"SecureDataPath"]]) {
        return YES;
    }
    
    return NO;
}

- (RepositorySecurityType)repositorySecurityType{
    
    return RepositorySecurityTypeFileBased;
}

- (RepositoryOperationStatus)resetSecuredRepository:(Repository*)repository{
    NSDictionary *paths = [self securityDataPathsForFile:[repository.backingstore fileName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    
    if ([fm fileExistsAtPath:[paths objectForKey:@"SecureDataPath"]]) {
        [fm removeItemAtPath:[paths objectForKey:@"SecureDataPath"] error:&error];
        
        if (error) {
            return RepositoryOperationStatusSecuredRemoveFail;
        }
    }
    
    return RepositoryOperationStatusSuccess;
}

- (RepositoryOperationStatus)secureRepository:(Repository*)repository withPassword:(NSString*)password{
    
    NSDictionary *paths = [self securityDataPathsForFile:[repository.backingstore fileName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:paths[@"UnsecureDataPath"]]) {
        
        NSData *unsecuredData = [fm contentsAtPath:paths[@"UnsecureDataPath"]];
        
        NSData *securedData = [DataEncryption encryptData:unsecuredData withPassword:password];
        
        if (![fm createFileAtPath:paths[@"SecureDataPath"] contents:securedData attributes:nil]) {
            return RepositoryOperationStatusSecuredWriteFail;
        }
        else{
            
            NSError *error;
            
            if ([fm fileExistsAtPath:paths[@"BackupDataPath"]]) {
                [fm removeItemAtPath:paths[@"BackupDataPath"] error:&error];
                
                if (error) {
                    
                    return RepositoryOperationStatusBackupRemoveFail;
                }
            }
            
            
            if ([fm fileExistsAtPath:paths[@"SecureDataPath"]]) {
                [fm copyItemAtPath:paths[@"SecureDataPath"] toPath:paths[@"BackupDataPath"] error:&error];
                
                if (error) {
                    return RepositoryOperationStatusBackupWriteFail;
                }
            }
            
            
            if ([fm fileExistsAtPath:paths[@"UnsecureDataPath"]]) {
                [fm removeItemAtPath:paths[@"UnsecureDataPath"] error:&error];
                
                if (error) {
                    return RepositoryOperationStatusUnsecuredRemoveFail;
                }
            }
        }
    }
    return RepositoryOperationStatusSuccess;
    
}

- (RepositoryOperationStatus)unsecureRepository:(Repository*)repository withPassword:(NSString*)password{
    
    NSDictionary *paths = [self securityDataPathsForFile:[repository.backingstore fileName]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:paths[@"SecureDataPath"]]) {
        
        NSData *securedData = [fm contentsAtPath:paths[@"SecureDataPath"]];
        
        NSData *unsecuredData = [DataEncryption decryptData:securedData withPassword:password];
        
        if ([unsecuredData length] == 0) {
            //we have an issue
            return RepositoryOperationStatusPasswordIncorrect;
        }
        
        if (![fm createFileAtPath:paths[@"UnsecureDataPath"] contents:unsecuredData attributes:nil]) {
            return RepositoryOperationStatusUnsecuredWriteFail;
        }
        else{
            
            NSError *error;
            
            [fm removeItemAtPath:paths[@"SecureDataPath"] error:&error];
            
            if (error) {
                return RepositoryOperationStatusSecuredRemoveFail;
            }
        }
    }
    else {
        return RepositoryOperationStatusSecuredFileNotFound;
    }
    return RepositoryOperationStatusSuccess;
    
}


@end
