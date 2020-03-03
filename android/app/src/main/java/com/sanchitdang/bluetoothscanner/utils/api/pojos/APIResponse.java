package com.sanchitdang.bluetoothscanner.utils.api.pojos;


public class APIResponse {

    private boolean success;
    private Object data;


    public void setSuccess(boolean value) {
        success = value;
    }

    public boolean getSuccess() {
        return success;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object object) {
        data = object;
    }

}
