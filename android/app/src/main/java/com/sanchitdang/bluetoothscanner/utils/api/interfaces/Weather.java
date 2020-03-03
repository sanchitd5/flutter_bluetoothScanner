package com.sanchitdang.bluetoothscanner.utils.api.interfaces;

import com.sanchitdang.bluetoothscanner.utils.api.pojos.LocationPojo;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;

public interface Weather {

    @POST("user/weather")
    @Headers({"Content-Type: application/json"})
    Call<LocationPojo> weatherAPI(@Header("authorization") String accessToken, @Body LocationPojo body);
}
