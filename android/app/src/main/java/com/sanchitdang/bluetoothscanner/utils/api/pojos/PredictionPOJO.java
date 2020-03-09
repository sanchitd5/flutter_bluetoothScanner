package com.sanchitdang.bluetoothscanner.utils.api.pojos;

import com.google.gson.annotations.SerializedName;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

class DateFormatter {
    static String formatToISO() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ", Locale.ENGLISH);
        return sdf.format(new Date());
    }
}

public class PredictionPOJO {

    public static class SensorData {
        @SerializedName("raw_sensor_data")
        private List<List<Double>> raw_sensor_data;
        @SerializedName("timestamp")
        private String timestamp = DateFormatter.formatToISO();

        public void setTimestamp(String timestamp) {
            this.timestamp = timestamp;
        }

        public void setSensorData(List<List<Double>> data) {
            this.raw_sensor_data = data;
        }
    }

    public static class LocationData {

        @SerializedName("lat")
        private double latitude;

        @SerializedName("lon")
        private double longitude;

        @SerializedName("message")
        private String message;

        public String getMessage() {
            return message;
        }

        public void setLatitude(double value) {
            latitude = value;
        }

        public void setLongitude(double value) {
            longitude = value;
        }

    }


    @SerializedName("data")
    private SensorData data;


    @SerializedName("mode")
    private String mode;

    public void setMode(String mode) {
        this.mode = mode;
    }

    @SerializedName("location")
    private LocationData location;

    public void setSensorData(SensorData data) {
        this.data = data;
    }

    public void setLocationData(LocationData locationData) {
        this.location = locationData;

    }


    @SerializedName("message")
    private String message;

    public String getMessage() {
        return message;
    }

}
