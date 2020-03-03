package com.sanchitdang.bluetoothscanner.utils.api.pojos;

import com.google.gson.annotations.SerializedName;

public class AccessToken {

    @SerializedName("statusCode")
    private Integer statusCode;

    @SerializedName("error")
    private String error;

    public Integer getStatusCode() {
        return statusCode;
    }

    public String getError() {
        return error;
    }

    public class UserDetails {

        @SerializedName("_id")
        private String id;

        @SerializedName("firstLogin")
        private Boolean firstLogin;

        @SerializedName("emailVerified")
        private Boolean emailVerified;

        private Boolean isBlocked;

        private String firstName;
        @SerializedName("lastName")
        private String lastName;
        @SerializedName("emailId")
        private String emailId;
        @SerializedName("phoneNumber")

        private String phoneNumber;
        @SerializedName("countryCode")

        private String countryCode;
        @SerializedName("codeUpdatedAt")

        private String codeUpdatedAt;

        @SerializedName("accessToken")
        private String accessToken;

        public String getId() {
            return id;
        }

        public Boolean getFirstLogin() {
            return firstLogin;
        }


        public Boolean getEmailVerified() {
            return emailVerified;
        }


        public Boolean getIsBlocked() {
            return isBlocked;
        }

        public String getFirstName() {
            return firstName;
        }


        public String getLastName() {
            return lastName;
        }

        public String getEmailId() {
            return emailId;
        }

        public String getPhoneNumber() {
            return phoneNumber;
        }


        public String getCountryCode() {
            return countryCode;
        }

        public String getCodeUpdatedAt() {
            return codeUpdatedAt;
        }


        public String getAccessToken() {
            return accessToken;
        }


    }

    public class Data {

        @SerializedName("userDetails")
        private UserDetails userDetails;

        public UserDetails getUserDetails() {
            return userDetails;
        }

    }

    @SerializedName("data")
    private Data data;

    public Data getData() {
        return data;
    }

    @SerializedName("message")
    private String message;


    public String getMessage() {
        return message;
    }

}
