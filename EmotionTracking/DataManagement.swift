//
//  DataManagement.swift
//  EmotionTracking
//
//  Created by student on 3/5/16.
//  Copyright © 2016 NguyenTrung. All rights reserved.
//

import Foundation

class DataManagement{
    
    static var _instance: DataManagement?
    var emotionsDB: COpaquePointer = nil
    var insertStatement: COpaquePointer = nil
    
    
    let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)
    static func getInstance() -> DataManagement {
        if (_instance == nil){
            _instance = DataManagement()
        }
        return _instance!
    }
    func initDatabase(){
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        print(paths)
        
        let docsDir = paths + "/emotionsDB.sqlite"
        if (sqlite3_open(docsDir, &emotionsDB) == SQLITE_OK){
            //create users table
            var sql = "CREATE TABLE IF NOT EXISTS USERS (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, MOBILENUMBER TEXT)"
            if (sqlite3_exec(emotionsDB, sql, nil, nil, nil) != SQLITE_OK) {
                print("Failed to create USERS table")
                print(sqlite3_errmsg(emotionsDB))
            }
            //create activities table
            sql = "CREATE TABLE IF NOT EXISTS ACTIVITIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, LONGITUDE DOUBLE, LATITUDE DOUBLE, THOUGHT TEXT, EMOTIONID INT, TIME DATETIME)"
            if (sqlite3_exec(emotionsDB, sql, nil, nil, nil) != SQLITE_OK) {
                print("Failed to create ACTIVITIES table")
                print(sqlite3_errmsg(emotionsDB))
            }            
        } else {
            print("Failed to open the DB")
            print(sqlite3_errmsg(emotionsDB))
        }
        
        print("DB Created successfully")
    }
    
    func addNewActivity(activity: Activity){
        //Add new activity to db 
        //Chenyao and TangTing
        
        
    }
    
        
    func selectAllActivities(username: String) -> [Activity]{
        //select new activity to db
        //Haijun
        return []
    }
    
    
    
}