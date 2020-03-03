package com.sanchitdang.bluetoothscanner.utils;

import android.content.Context;

import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkInfo;
import android.util.Log;


public class ConnectivityManagerService {
    private static final String TAG = "ConnectivityMANService";
    private ConnectivityManager manager;

    public ConnectivityManagerService(Context context) {
        this.manager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

    }

    public boolean getServiceStatus() {
        Log.d(TAG, "getServiceStatus: Checking Internet Connection");
        NetworkInfo networkInfo = this.manager.getActiveNetworkInfo();
        Log.d(TAG, "getServiceStatus: Service status is: " + (networkInfo != null && networkInfo.isConnected()));
        return (networkInfo != null && networkInfo.isConnected());
    }
}
