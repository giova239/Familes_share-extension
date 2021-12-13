package com.example.myapplication.Retrofit;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;

public interface UploadImageService {
    @Multipart
    @POST("uploadimage")
    Call<ResponseBody> uploadImage(
            @Part("id_announcement") RequestBody id_announcement,
            @Part MultipartBody.Part file
    );
}