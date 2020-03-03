package com.sanchitdang.bluetoothscanner.utils.api.interfaces;

import com.sanchitdang.bluetoothscanner.utils.api.pojos.PredictionPOJO;
import com.sanchitdang.bluetoothscanner.utils.api.pojos.PredictionResponsePOJO;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;

public interface Prediction {

    @POST("user/prediction")
    @Headers({"Content-Type: application/json"})
    Call<PredictionResponsePOJO> predictionAPI(@Header("authorization") String accessToken, @Body PredictionPOJO body);

}
