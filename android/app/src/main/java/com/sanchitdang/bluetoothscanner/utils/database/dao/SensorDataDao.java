package com.sanchitdang.bluetoothscanner.utils.database.dao;


import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import com.sanchitdang.bluetoothscanner.utils.database.models.SensorData;

import java.util.List;

@Dao
public interface SensorDataDao {
    @Query("Select * from sensorData")
    List<SensorData> getSensorData();

    @Insert
    void insertSensorData(SensorData sensorData);

    @Update
    void updateSensorData(SensorData sensorData);

    @Delete
    void DeleteSensorData(SensorData sensorData);

    @Query("DELETE FROM sensorData WHERE id between :start and :end")
    void DeleteSensorDataWithinRange(int start, int end);
}
