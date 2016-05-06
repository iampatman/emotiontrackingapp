# emotiontrackingapp
MTECH Mobile application project
1. Send HTTP Post request to server</br>

URL: http://emotionstrackingapp.herokuapp.com</br>
Tool sugested: HTTPRequester in Firefox or Postman in Chorme</br>
<b>For posting new activity: </b></br>

URL: http://emotionstrackingapp.herokuapp.com/postActivity</br>
HTTP Method: Post</br>
<b>Sample data body: </b></br>
{
   "username": "tangting",
   "longitude": 123,
   "latitude": 12345,
   "thought": "Hello i am happy",
   "emotionId": 1
}

2. Save to SQLiteDB

Users table has structure as following:</br>

CREATE TABLE IF NOT EXISTS USERS (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, MOBILENUMBER TEXT)

Activities table has structure as following</br>

CREATE TABLE IF NOT EXISTS ACTIVITIES (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, LONGITUDE DOUBLE, LATITUDE DOUBLE, THOUGHT TEXT, EMOTIONID INT, TIME DATETIME)

3. Tasks assignment:</br>

Haijun: Server code, Activities History (app)</br>
TangTing and Chenyao: Add Emotion Screen </br>
    1. postActivity to server </br>
    2. Save to Sqlite database</br>
Ngoc & Trung: Main screen </br>
    1. Load list of current activities and show on the map</br>
    2. Reload the list after 30s (define later)</br>
    3. Connect to AddEmotionScreen (later)</br>
    4. Connect to History Screen (later)</br>
  
<b>Next meeting: This Thursday</b>
