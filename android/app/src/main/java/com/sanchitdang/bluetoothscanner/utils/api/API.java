package com.sanchitdang.bluetoothscanner.utils.api;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import com.sanchitdang.bluetoothscanner.utils.api.interfaces.*;
import com.sanchitdang.bluetoothscanner.utils.api.pojos.*;

import java.util.function.Consumer;

import io.flutter.plugin.common.MethodChannel;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

import static android.content.Context.MODE_PRIVATE;

public class API {
    private Context myContext;
    private static final String TAG = "API";
    private String bearerToken = null;

    public API(Context context) {
        if (null != context) {
            myContext = context;
            SharedPreferences sharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);
            String token = sharedPreferences.getString("flutter.accessToken", null);
            if (token != null && (!token.equals("INVALID"))) {
                bearerToken = "bearer " + token;
            } else bearerToken = "INVALID";

        }
    }

    public String giveMeMyToken(Context context) {
        if (null != bearerToken)
            return bearerToken;
        SharedPreferences sharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);
        return "bearer " + sharedPreferences.getString("flutter.accessToken", null);
    }

    public void accessTokenLogin(MethodChannel.Result result) {
        AccessTokenLogin _accessTokenLogin = RetrofitUtil.getApiClient().create(AccessTokenLogin.class);
        Call<AccessToken> accessTokenCall = _accessTokenLogin.accessTokenLogin(bearerToken);
        accessTokenCall.enqueue(new Callback<AccessToken>() {
            @Override
            public void onResponse(Call<AccessToken> accessTokenCall, Response<AccessToken> response) {
                if (response.code() == 200) {
                    assert response.body() != null;
                    result.success(response.body().getData().getUserDetails().getFirstName());
                } else {
                    try {
                        result.error(String.valueOf(response.code()), response.message(), response.code());
                    } catch (NullPointerException e) {
                        result.error("NULL.POINTER.EXCEPTION", "Null pointer exception", "null pointer exception");
                    }
                }
            }

            @Override
            public void onFailure(Call<AccessToken> accessTokenCall, Throwable t) {
                Log.e(TAG, "onResponse: Error " + t.getMessage());
            }
        });
    }


    public void sendLocationData(LocationPojo location) {
        if (!bearerToken.equals("INVALID")) {
            Weather _weather = RetrofitUtil.getApiClient().create(Weather.class);
            Log.d(TAG, "api accessToken: " + bearerToken);
            Log.d(TAG, "locationData: " + location);
            Call<LocationPojo> _weatherCall = _weather.weatherAPI(bearerToken, location);
            _weatherCall.enqueue(new Callback<LocationPojo>() {
                @Override
                public void onResponse(Call<LocationPojo> call, Response<LocationPojo> response) {
                    if (response.code() == 200) {
                        Log.d(TAG, "onResponse: Successfully emitted location data. :) ");
                    } else if (response.code() == 401) {
                        SharedPreferences sharedPreferences = myContext.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE);
                        SharedPreferences.Editor spEditor = sharedPreferences.edit();
                        spEditor.putString("flutter.accessToken", "INVALID");
                        spEditor.apply();

                    } else {
                        Log.d(TAG, "onResponse: " + response.code());
                    }
                }

                @Override
                public void onFailure(Call<LocationPojo> call, Throwable t) {
                    Log.d(TAG, "onFailure: error from backend");
                }
            });
        }
    }

}
