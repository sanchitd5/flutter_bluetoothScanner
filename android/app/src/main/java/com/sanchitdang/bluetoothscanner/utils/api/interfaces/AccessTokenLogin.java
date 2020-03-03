package com.sanchitdang.bluetoothscanner.utils.api.interfaces;

import com.sanchitdang.bluetoothscanner.utils.api.pojos.AccessToken;

import retrofit2.Call;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;

public interface AccessTokenLogin
{
    @POST("user/accessTokenLogin")
    @Headers({"Content-Type: application/json"})
    Call<AccessToken> accessTokenLogin(@Header("authorization") String accessToken);
}
