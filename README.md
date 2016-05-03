# emotiontrackingapp
MTECH Mobile application project
1. Send HTTP Post request to server

URL: http://emotionstrackingapp.herokuapp.com
Tool sugested: HTTPRequester in Firefox or Postman in Chorme
<b>For posting new activity: </b>

URL: http://emotionstrackingapp.herokuapp.com/postActivity
HTTP Method: Post
<b>Sample data body: </b>
{
   "username": "tangting",
   "longitude": 123,
   "latitude": 12345,
   "thought": "Hello i am happy",
   "emotionId": 1
}

2. Save to SQLiteDB

Users table has structure as following:

CREATE TABLE IF NOT EXISTS USERS (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, MOBILENUMBER TEXT)

Activities table has structure as following

CREATE TABLE IF NOT EXISTS ACTIVITIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, LONGITUDE DOUBLE, LATITUDE DOUBLE, THOUGHT TEXT, EMOTIONID INT, TIME DATETIME)

3. Tasks assignment:

Haijun: Server code, Activities History (app)
TangTing and Chenyao: Add Emotion Screen 
    1. postActivity to server
    2. Save to Sqlite database
Ngoc & Trung: Main screen 
    1. Load list of current activities and show on the map
    2. Reload the list after 30s (define later)
    3. Connect to AddEmotionScreen (later)
    4. Connect to History Screen (later)
  
<b>Next meeting: This Thursday</b>
