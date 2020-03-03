package com.sanchitdang.bluetoothscanner.dumpData;

import android.util.Log;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class PredictionData {
    private static final String TAG = "PredictionData";
    private List<List<Double>> data;

    public PredictionData(){
        data= new ArrayList<>();
        for(int i=0;i<51;i++){
            List<Double> x = Arrays.asList(0.017994,106.3,-9.48,-0.9,2.68,-0.31,-0.25,0.25,-56.38,2.06,-2.56);
            data.add(x);
        }
    }

    public List<List<Double>> getData() {
        Log.d(TAG, "getData: sending prediction"+data);
        return data;
    }
}