package com.example.myapplication.Retrofit;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Url;

public interface TransferImageService {

    @Multipart
    @POST("uploadImage")
    Call<ResponseBody> uploadImage(
            @Part("id_announcement") RequestBody id_announcement,
            @Part MultipartBody.Part file
    );

    @Multipart
    @POST("uploadProfileImage")
    Call<ResponseBody> uploadProfileImage(
            @Part("id_user") RequestBody id_user,
            @Part MultipartBody.Part file
    );

    @GET
    Call<ResponseBody> downloadImage(@Url String fileUrl);
}