package com.sanchitdang.bluetoothscanner.utils.api.pojos;

import com.google.gson.annotations.SerializedName;


public class PredictionResponsePOJO {
    @SerializedName("data")
    private Data data;

    @SerializedName("message")
    private String message;

    public static class Data {

        @SerializedName("activity")
        private String activity;

        public String getActivity() {
            return activity;
        }

    }

    public Data getData() {
        return data;
    }

    public String getMessage() {
        return message;
    }
}
