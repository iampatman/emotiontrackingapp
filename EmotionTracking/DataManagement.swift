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
    var selectAllStatement:COpaquePointer = nil
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
       prepareStatement()
    }
    
    func prepareStatement(){
        var sqlString: String
        //prepare statement select all
        sqlString = "SELECT * FROM ACTIVITIES"
        var cSql = sqlString.cStringUsingEncoding(NSUTF8StringEncoding)
        sqlite3_prepare_v2(emotionsDB, cSql!, -1, &selectAllStatement, nil)
        
        //insert into tables
        sqlString = "INSERT INTO ACTIVITIES (username, longitude, latitude, thought, emotionId) VALUES (?, ?, ?, ?, ?)"
        cSql = sqlString.cStringUsingEncoding(NSUTF8StringEncoding)
        sqlite3_prepare_v2(emotionsDB, cSql!, -1, &insertStatement, nil)
    }
    
    func addNewActivity(activity: Activity){
        //Add new activity to db
        //Chenyao and TangTing
        let usernameStr = activity.username
        let longitudeDob = activity.longitude
        let latitudeDob = activity.latitude
        let thoughtStr = activity.thought
        let emotionIdInt = Int32(activity.emotionId)
        
        sqlite3_bind_text(insertStatement, 1, usernameStr, -1, SQLITE_TRANSIENT)
        sqlite3_bind_double(insertStatement, 2, longitudeDob)
        sqlite3_bind_double(insertStatement, 3, latitudeDob)
        sqlite3_bind_text(insertStatement, 4, thoughtStr, -1, SQLITE_TRANSIENT)
        sqlite3_bind_int(insertStatement, 5, emotionIdInt)
        if (sqlite3_step(insertStatement) == SQLITE_DONE) {
            print("Add avtivity successful")
        }else{
            print("Error code: ", sqlite3_errcode(emotionsDB))
        }
        sqlite3_reset(insertStatement)
        sqlite3_clear_bindings(insertStatement)
    }
        
    func selectAllActivities(username: String) -> [Activity]{
        //select new activity to db
        var activities:[Activity] = []
        
        //Haijun
        while(sqlite3_step(selectAllStatement) == SQLITE_ROW)
        {
            let username_buf = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(selectAllStatement, 1)))
            let longitude_buf = sqlite3_column_double(selectAllStatement, 2)
            let latitude_buf = sqlite3_column_double(selectAllStatement, 3)
            let thought_buf = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(selectAllStatement, 4)))
            let emotionid_buf:Int32 = sqlite3_column_int(selectAllStatement, 5)
            var time_buf = String.fromCString(UnsafePointer<CChar>(sqlite3_column_text(selectAllStatement, 6)))
            if (time_buf) == nil {
                time_buf = ""
            }
            if(username == username_buf) {
                activities.append(Activity(username: username_buf!, emotionId: Int(emotionid_buf), longitude: longitude_buf, latitude: latitude_buf, thought: thought_buf!, time: time_buf!))
            }
        }
        sqlite3_reset(selectAllStatement)
        sqlite3_clear_bindings(selectAllStatement)
        print("Read from SQLITE: \(activities.count)")
        return activities
    }
    
    
    
}