package com.sanchitdang.bluetoothscanner.utils.api.pojos;

import com.google.gson.annotations.SerializedName;


public class MessageResponse {

    @SerializedName("message")
    private String message;

    @SerializedName("statusCode")
    private int code;


    public String getMessage() {
        if (null != message)
            return message;
        return "message was found to be null";
    }

    public int getCode() {
        return code;
    }

}
