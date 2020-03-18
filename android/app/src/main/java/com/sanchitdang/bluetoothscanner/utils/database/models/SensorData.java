package com.sanchitdang.bluetoothscanner.utils.database.models;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

import java.util.Date;

@Entity(tableName = "sensorData")
public class SensorData {
    @PrimaryKey(autoGenerate = true)
    private int id;
    @ColumnInfo(name = "sensorId")
    private String sensorID;
    @ColumnInfo(name = "characteristic")
    private String characteristic;
    @ColumnInfo(name = "timestamp")
    private Date timestamp;
    @ColumnInfo(name = "data", typeAffinity = ColumnInfo.BLOB)
    private byte[] data;

    public SensorData(int id, String sensorID, String characteristic, byte[] data, Date timestamp) {
        this.id = id;
        this.sensorID = sensorID;
        this.characteristic = characteristic;
        this.data = data;
        this.timestamp = timestamp;
    }

    public String getSensorID() {
        return sensorID;
    }

    public String getCharacteristic() {
        return characteristic;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public byte[] getData() {
        return data;
    }

    public int getId() {
        return id;
    }
}
