package com.sanchitdang.bluetoothscanner.utils.predictionML;

import android.content.Context;
import android.location.Location;
import android.os.AsyncTask;
import android.os.Build;
import android.util.Log;

import androidx.annotation.RequiresApi;
import androidx.lifecycle.MutableLiveData;

import com.sanchitdang.bluetoothscanner.dumpData.PredictionData;
import com.sanchitdang.bluetoothscanner.utils.api.API;
import com.sanchitdang.bluetoothscanner.utils.api.pojos.PredictionPOJO;
import com.sanchitdang.bluetoothscanner.utils.database.AppDatabase;
import com.sanchitdang.bluetoothscanner.utils.database.models.SensorData;

import java.util.List;

public class PredictionHelper {

    private static final String TAG = "PredictionHelper";

    private static List<SensorData> sensorData;


    private static class GetSensorDataAsyncTask extends AsyncTask<Void, Void, Void> {
        private AppDatabase db;

        GetSensorDataAsyncTask(AppDatabase db) {
            this.db = db;
        }

        @RequiresApi(api = Build.VERSION_CODES.N)
        @Override
        protected Void doInBackground(Void... voids) {
            int[] array;
            sensorData = db.sensorDataDao().getSensorData();
            for (SensorData sensorDatum : sensorData) {

            }
            Log.d(TAG, "SensorData: " + sensorData.size());
            return null;
        }
    }

    public static void callPredictionAPI(Context context, PredictionPOJO _predictionData) {
        API _apiInstance = new API(context);
        _apiInstance.sendPredictionData(_predictionData);
    }

    private void getSensorDataFromDB(Context context) {
        AppDatabase appDB = AppDatabase.getInstance(context);
        new GetSensorDataAsyncTask(appDB).execute();

    }

    public static PredictionPOJO prepareLocationData(Location location) {
        PredictionPOJO _predictionData = new PredictionPOJO();
        PredictionPOJO.LocationData _locationData = new PredictionPOJO.LocationData();
        double currentLatitude = location.getLatitude();
        double currentLongitude = location.getLongitude();
        _locationData.setLatitude(currentLatitude);
        _locationData.setLongitude(currentLongitude);
        _predictionData.setLocationData(_locationData);
        return _predictionData;
    }

    public static void injectSensorData(PredictionPOJO predictionPOJO) {
        PredictionPOJO.SensorData _sensorData = new PredictionPOJO.SensorData();
        PredictionData dump = new PredictionData();
        _sensorData.setSensorData(dump.getData());
        predictionPOJO.setSensorData(_sensorData);
    }
}
