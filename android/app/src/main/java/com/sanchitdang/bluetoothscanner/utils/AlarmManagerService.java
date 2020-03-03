package com.sanchitdang.bluetoothscanner.utils;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.util.Log;

import com.sanchitdang.bluetoothscanner.services.LocationService;
import com.sanchitdang.bluetoothscanner.utils.api.API;
import com.sanchitdang.bluetoothscanner.utils.api.pojos.LocationPojo;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import static android.content.Context.ALARM_SERVICE;


class AlarmData {
    private String title;
    private long time;
    private String type;
    private int requestCode;

    AlarmData(String _title, int _time, String _type, int requestCode) {
        this.title = _title;
        this.time = _time;
        this.type = _type;
        this.requestCode = requestCode;
    }

    String getTitle() {
        return title;
    }

    long getTime() {
        return time;
    }

    String getType() {
        return type;
    }

    int getRequestCode() {
        return requestCode;
    }


}


public class AlarmManagerService extends BroadcastReceiver {
    private static final String TAG = "AlarmManagerService";
    private static int alarmCounter = 0;
    public Context myContext;
    private AlarmManager _manager;
    private static List<AlarmData> alarms = new ArrayList<>();


    public AlarmManagerService() {
    }

    public AlarmManagerService(Context context) {
        Log.d(TAG, "AlarmManagerService() called with: context = [" + context + "]");
        if (null == myContext) {
            myContext = context;
        }
        if (null == _manager) {
            if (null != myContext) {
                _manager = (AlarmManager) myContext.getSystemService(ALARM_SERVICE);
            }
        }
    }

    /**
     * @return number of alarms
     */
    public int getNumberOfAlarms() {
        return alarmCounter;
    }


    private void initiateManager(Context context) {
        if (null == _manager) {
            _manager = (AlarmManager) context.getSystemService(ALARM_SERVICE);
        }
    }

    public void initService(Context context) {
        Log.d(TAG, "initService() called with: context = [" + context + "]");
        if (null == _manager)
            initiateManager(context);
        if (null != alarms) {
            alarms.add(new AlarmData("startLocationService", 100, "REPEAT", 1));
        } else Log.d(TAG, "AlarmManagerService: alarms are null");

        for (AlarmData _data : alarms) {
            this.addToQueue(context, _data.getTitle(), _data.getTime(), _data.getType(), _data.getRequestCode());
        }

    }

    public void removeAlarmFromQueue(int requestCode) {
        if (null != myContext) {
            Intent localIntent = new Intent(myContext, AlarmManagerService.class);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(myContext, requestCode, localIntent, 0);
            _manager.cancel(pendingIntent);
        }
    }

    public void addToQueue(Context context, String title, long time, String type, int requestCode) {
        Log.d(TAG, "addToQueue() called with: context = [" + context + "], title = [" + title + "], time = [" + time + "], type = [" + type + "], requestCode = [" + requestCode + "]");
        Intent localIntent = new Intent(context, AlarmManagerService.class);
        if (null == _manager) {
            Log.d(TAG, "addToQueue: Manager found NULL at this point");
            initiateManager(context);
        } else Log.d(TAG, "addToQueue: Manager was not NULL");
        localIntent.setAction(title);
        int flag = 0;
        PendingIntent pendingIntent = PendingIntent.getBroadcast(context, requestCode, localIntent, flag);
        switch (type.toUpperCase()) {
            case "ONETIME": {
                long alarmTimeAtUTC = System.currentTimeMillis() + (time * 1_000L);
                _manager.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, alarmTimeAtUTC, pendingIntent);
                Log.d(TAG, "addToQueue: Added " + "[" + title + "] to queue for one time execution");
                break;
            }
            case "REPEAT": {
                long currentTime = System.currentTimeMillis() + 5_000L;
                long timeInterval = time * 1_000L;
                _manager.setRepeating(AlarmManager.RTC_WAKEUP, currentTime, timeInterval, pendingIntent);
                Log.d(TAG, "addToQueue: Added " + "[" + title + "] to queue for repeating execution");

                break;
            }
        }
        alarmCounter = alarmCounter + 1;
    }


    @Override
    public void onReceive(Context context, Intent intent) {
        Log.d(TAG, "onReceive() called with: context = [" + context + "], intent = [" + intent + "]");
        switch (Objects.requireNonNull(intent.getAction())) {
            case "startLocationService": {
                Log.d(TAG, "onReceive: Starting location service.");
                LocationService locationService = LocationService.getInstance();
                locationService.setLocationServiceEnabled(true);
                locationService.initLocationService(context);
                Log.d(TAG, "onReceive: Started location service successfully. :)\nNow add emit function to the queue.");
                this.addToQueue(context, "emitLocation", 2, "ONETIME", 2);
                break;
            }
            case "emitLocation": {
                Log.d(TAG, "onReceive: Called Emit Location Function\nnow checking internet connectivity");
                ConnectivityManagerService connectivityManagerService = new ConnectivityManagerService(context);
                if (connectivityManagerService.getServiceStatus()) {
                    Log.d(TAG, "onReceive: Internet connectivity is available. :)\nNow emitting location to the backend server. :)");
                    LocationService locationService = LocationService.getInstance();
                    Location currentData = locationService.getLastLocation();
                    if (null != currentData) {
                        Log.d(TAG, "onReceive: we have current location data");
                        double currentLatitude = currentData.getLatitude();
                        double currentLongitude = currentData.getLongitude();
                        LocationPojo _locationData = new LocationPojo();
                        _locationData.setLatitude(currentLatitude);
                        _locationData.setLongitude(currentLongitude);
                        Log.d(TAG, "configureFlutterEngine: " + _locationData);
                        API _apiInstance = new API(context);
                        _apiInstance.sendLocationData(_locationData);
                        Log.d(TAG, "onReceive: EMITTED LOCATION THROUGH ALARM");
                        this.addToQueue(context, "stopLocationService", 2, "ONETIME", 3);
                    }else {
                        Log.d(TAG, "onReceive: location data not available :( :(\n Emitting again after 2 seconds");
                        this.addToQueue(context, "emitLocation", 2, "ONETIME", 2);
                    }
                } else {
                    Log.d(TAG, "onReceive: Internet Connectivity Problem");
                }
                break;
            }
            case "stopLocationService": {
                LocationService locationService = LocationService.getInstance();
                locationService.stopLocationUpdates();
                Log.d(TAG, "onReceive: STOPPED location service");
            }
            default:
                Log.d(TAG, "onReceive: Received Alarm: " + intent.getAction());
        }
    }
}