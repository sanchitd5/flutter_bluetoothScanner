package com.sanchitdang.bluetoothscanner;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.location.Location;

import com.sanchitdang.bluetoothscanner.services.*;
import com.sanchitdang.bluetoothscanner.utils.*;
import com.sanchitdang.bluetoothscanner.utils.api.API;
import com.sanchitdang.bluetoothscanner.utils.api.pojos.LocationPojo;
import com.sanchitdang.bluetoothscanner.utils.database.AppDatabase;


public class MainActivity extends FlutterActivity {
    private static final String TAG = "MainActivity";


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        Log.d("Flutter Engine", "inside configuration function");
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        Context myAppContext = this.getApplicationContext();
        LocationService locationService = LocationService.getInstance();
        locationService.setLocationServiceEnabled(true);
        ConnectivityManagerService connectivityManagerService = new ConnectivityManagerService(this.getApplicationContext());
        API _apiInstance = new API(myAppContext);
        AlarmManagerService _myAlarmManager = new AlarmManagerService(this.getApplicationContext());

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.sanchitdang.channels").setMethodCallHandler(
                (call, result) -> {
                    Log.d("Channel", "Channel Called: " + call.method);
                    switch (call.method) {
                        case "getLastLocation": {
                            locationService.initLocationService(this.getApplicationContext());
                            Location currentData = locationService.getLastLocation();
                            if (null != currentData) {
                                double currentLatitude = currentData.getLatitude();
                                double currentLongitude = currentData.getLongitude();
                                LocationPojo _locationData = new LocationPojo();
                                _locationData.setLatitude(currentLatitude);
                                _locationData.setLongitude(currentLongitude);
                                Log.d(TAG, "configureFlutterEngine: " + _locationData);
                                _apiInstance.sendLocationData(_locationData);
                                locationService.stopLocationUpdates();
                            } else {
                                result.error("Result found null", "result found null", "null result");
                                Log.d(TAG, "configureFlutterEngine: result found null");
                            }
                            break;
                        }
                        case "logAccessTokenFromSharedPrefs": {
                            SharedPreferences sharedPreferences = getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);
                            String accessToken = sharedPreferences.getString("flutter.accessToken", null);
                            Log.d(TAG, "configureFlutterEngine: " + accessToken);
                            _apiInstance.accessTokenLogin(result);

                            break;
                        }

                        case "checkInternetConnection": {
                            boolean internetStatus = connectivityManagerService.getServiceStatus();
                            Log.d(TAG, "configureFlutterEngine: Current Internet Status is" + internetStatus);
                            result.success(String.valueOf(internetStatus));
                            break;
                        }

                        case "triggerAlarmManager": {
                            Log.d(TAG, "configureFlutterEngine: inside triggerAlarmManager");
                            _myAlarmManager.initService(this.getApplicationContext());
                            result.success("SUCCESS");
                            break;
                        }

                        default: {
                            Log.d(TAG, "configureFlutterEngine: Switch default case called");
                        }
                    }
                }
        );
    }
}
