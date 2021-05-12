//
//  NSFileManager.swift
//  SwiftUtils
//
//  Created by DaoNV on 10/23/15.
//  Copyright © 2016 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension FileManager {
    public class var homeDir: String! {
        return NSHomeDirectory()
    }

    public class var homeUrl: URL! {
        return URL(fileURLWithPath: homeDir, isDirectory: true)
    }

    public class var docDir: String! {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    }

    public class var docUrl: URL! {
        return URL(fileURLWithPath: docDir, isDirectory: true)
    }

    public class var libraryDir: String! {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first
    }

    public class var libraryUrl: URL! {
        return URL(fileURLWithPath: libraryDir, isDirectory: true)
    }

    public class var appSupportDir: String! {
        return NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first
    }

    public class var appSupportUrl: URL! {
        return URL(fileURLWithPath: appSupportDir, isDirectory: true)
    }

    public class var tmpDir: String {
        return NSTemporaryDirectory()
    }

    public class var tmpUrl: URL {
        return URL(fileURLWithPath: tmpDir, isDirectory: true)
    }

    public class func skipBackup(_ path: String) -> Bool {
        let fileManager = `default`
        var isDir: ObjCBool = true
        if fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            if isDir.boolValue {
                var success = true
                do {
                    let urls = try fileManager.contentsOfDirectory(atPath: path)
                    for url in urls {
                        success = success && skipBackup(url)
                    }
                    return success
                } catch { }
            } else {
                do {
                    let url = URL(fileURLWithPath: path)
                    try (url as NSURL).setResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
                    return true
                } catch { }
            }
        }
        return false
    }

    public class func skipBackup() {
       _ = skipBackup(docDir)
       _ = skipBackup(libraryDir)
    }
}
