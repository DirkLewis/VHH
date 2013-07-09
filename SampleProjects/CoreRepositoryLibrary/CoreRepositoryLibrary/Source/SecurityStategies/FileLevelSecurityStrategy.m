//
//  FileLevelSecurityStrategy.m
//  CoreDataRepositoryFramework
//
//  Created by Dirk Lewis on 7/19/12.
//  Copyright (c) 2012 Optima HCS. All rights reserved.
//

#import "FileLevelSecurityStrategy.h"
#import "DataEncryption.h"
#import "Repository.h"
#import "BackingstoreProtocol.h"


@implementation FileLevelSecurityStrategy

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

- (BOOL)isRepositorySecured:(Repository*)repository{

    NSDictionary *paths = [self securityDataPathsForFile:[repository.backingstore fileName]];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:[paths objectForKey:@"SecureDataPath"]]) {
        return YES;
    }
    
    return NO;}

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
    
    if ([fm fileExistsAtPath:[paths objectForKey:@"UnsecureDataPath"]]) {
        
        NSData *unsecuredData = [fm contentsAtPath:[paths objectForKey:@"UnsecureDataPath"]];
        
        NSData *securedData = [DataEncryption encryptData:unsecuredData withPassword:password];
        
        if (![fm createFileAtPath:[paths objectForKey:@"SecureDataPath"] contents:securedData attributes:nil]) {
            return RepositoryOperationStatusSecuredWriteFail;
        }
        else{
            
            NSError *error;
            
            if ([fm fileExistsAtPath:[paths objectForKey:@"BackupDataPath"]]) {
                [fm removeItemAtPath:[paths objectForKey:@"BackupDataPath"] error:&error];
                
                if (error) {
                    
                    return RepositoryOperationStatusBackupRemoveFail;
                }
            }
            
            
            if ([fm fileExistsAtPath:[paths objectForKey:@"SecureDataPath"]]) {
                [fm copyItemAtPath:[paths objectForKey:@"SecureDataPath"] toPath:[paths objectForKey:@"BackupDataPath"] error:&error];
                
                if (error) {
                    return RepositoryOperationStatusBackupWriteFail;
                }
            }
            
            
            if ([fm fileExistsAtPath:[paths objectForKey:@"UnsecureDataPath"]]) {
                [fm removeItemAtPath:[paths objectForKey:@"UnsecureDataPath"] error:&error];
                
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
    
    if ([fm fileExistsAtPath:[paths objectForKey:@"SecureDataPath"]]) {
        
        NSData *securedData = [fm contentsAtPath:[paths objectForKey:@"SecureDataPath"]];
        
        NSData *unsecuredData = [DataEncryption decryptData:securedData withPassword:password];
        
        if ([unsecuredData length] == 0) {
            //we have an issue
            return RepositoryOperationStatusPasswordIncorrect;
        }
        
        if (![fm createFileAtPath:[paths objectForKey:@"UnsecureDataPath"] contents:unsecuredData attributes:nil]) {
            return RepositoryOperationStatusUnsecuredWriteFail;
        }
        else{
            
            NSError *error;
            
            [fm removeItemAtPath:[paths objectForKey:@"SecureDataPath"] error:&error];
            
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
