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
    @SerializedName("data")
    private List<List<Double>> data;

    @SerializedName("timestamp")
    private String timestamp = DateFormatter.formatToISO();

    @SerializedName("latitude")
    private double latitude;

    @SerializedName("longitude")
    private double longitude;

    @SerializedName("message")
    private String message;

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public void setData(List<List<Double>> data) {
        this.data = data;
    }

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
