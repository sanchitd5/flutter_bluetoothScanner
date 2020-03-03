package com.sanchitdang.bluetoothscanner.utils.api;


import com.sanchitdang.bluetoothscanner.utils.Constants;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitUtil {

    private static Retrofit retrofit = null;
    private static final String backendUrl = Constants.BACKEND_URL;

    public static Retrofit getApiClient() {
        if (null == retrofit) {
            retrofit = new Retrofit.Builder()
                    .baseUrl(backendUrl)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
        }
        return retrofit;
    }
}
