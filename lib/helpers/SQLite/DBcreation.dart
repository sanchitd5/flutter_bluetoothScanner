import 'package:sqflite/sqflite.dart';
import '../../utils/Logger/logger.dart';

class DBDefinition {
  static void onCreate(Database db, int version) async {
    //Write your dbCreation Commands here.
    logger.i("database is being created");
    await db.execute("CREATE TABLE sensorData ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "sensorId TEXT,"
        "characteristic TEXT,"
        "timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,"
        "time FLOAT"
        "angle FLOAT"
        "accelX FLOAT"
        "accelY FLOAT"
        "accelZ FLOAT"
        "gyroX FLOAT"
        "gyroY FLOAT"
        "gyroZ FLOAT"
        "magX FLOAT"
        "magY FLOAT"
        "magZ FLOAT");
  }
}
