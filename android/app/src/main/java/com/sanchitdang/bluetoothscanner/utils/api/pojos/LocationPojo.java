package com.sanchitdang.bluetoothscanner.utils.api.pojos;

import com.google.gson.annotations.SerializedName;


public class LocationPojo {

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
