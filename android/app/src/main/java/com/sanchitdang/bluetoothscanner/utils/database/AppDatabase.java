package com.sanchitdang.bluetoothscanner.utils.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;

import com.sanchitdang.bluetoothscanner.utils.database.dao.SensorDataDao;
import com.sanchitdang.bluetoothscanner.utils.database.models.SensorData;

@Database(entities = {SensorData.class}, exportSchema = false, version = 1)
@TypeConverters({Converters.class})
public abstract class AppDatabase extends RoomDatabase {
    private static AppDatabase instance;
    private static final String dbname = "bluetoothScanner.db";

    public static synchronized AppDatabase getInstance(Context context) {
        if (null == instance) {
            instance = Room.databaseBuilder(context.getApplicationContext(), AppDatabase.class, dbname).fallbackToDestructiveMigration().build();
        }
        return instance;
    }

    // Define your DAOs below
    public abstract SensorDataDao sensorDataDao();
}

