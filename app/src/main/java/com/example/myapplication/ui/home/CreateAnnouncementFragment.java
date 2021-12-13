package com.example.myapplication.ui.home;

import android.app.Fragment;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.FileUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.databinding.FragmentCreateAnnouncementBinding;
import com.example.myapplication.Retrofit.UploadImageService;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.LinkedList;
import java.util.List;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Call;

public class CreateAnnouncementFragment extends Fragment {

    private FragmentCreateAnnouncementBinding binding;
    private List<Uri> images = new LinkedList<>();
    private String group_id;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentCreateAnnouncementBinding.inflate(inflater, container, false);
        View root = binding.getRoot();

        return root;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        binding = null;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        this.group_id = getArguments().getString("id_group");
        loadCreateAnnouncement(view);
    }

    private void loadCreateAnnouncement(View view){

        //ADD PHOTO BUTTON
        view.findViewById(R.id.addPhotoButton).setOnClickListener(v -> {
            Intent pickPhoto = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
            pickPhoto.setType("image/*");
            startActivityForResult(pickPhoto , 1);
        });

        //PUBLISH ANNOUNCEMENT BUTTON
        view.findViewById(R.id.createAnnouncementButton).setOnClickListener(v -> {

            //RETRIEVE USER INPUT
            EditText titleEditText = getView().findViewById(R.id.enterTitle);
            EditText descriptionEditText = getView().findViewById(R.id.enterDescription);
            Switch typeSwitch = getView().findViewById(R.id.HadOrNeededSwitch);

            String title = titleEditText.getText().toString();
            String description = descriptionEditText.getText().toString();
            Boolean type = typeSwitch.isChecked();

            //POST create announcement
            try {
                RequestQueue queue = Volley.newRequestQueue(getContext());
                String url ="http://10.0.2.2:3300/createAnnouncement/1";
                JSONObject j = new JSONObject();
                j.put("title", title);
                j.put("description", description);
                j.put("type", type);
                j.put("id_group", this.group_id);
                JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, url, j,
                        response -> {
                            Toast.makeText(getContext(), "Announcement Created", Toast.LENGTH_SHORT).show();
                            try {
                                String id_announcement = response.getString("id_announcement");
                                uploadImages(id_announcement);
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                            getFragmentManager().popBackStackImmediate();
                        },
                        error -> {
                            Toast.makeText(getContext(), "Error on announcement creation", Toast.LENGTH_SHORT).show();
                            System.out.println("ERROR"+error.toString());
                            getFragmentManager().popBackStackImmediate();
                });
                queue.add(req);

            } catch (JSONException e) {
                e.printStackTrace();
            }


        });
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == -1 && requestCode == 1){

            //retrive Image and show it on photoList
            ImageView img = new ImageView(getContext());
            Uri image_uri = data.getData();
            LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            p.setMargins(20,20,20,20);
            img.setLayoutParams(p);
            img.setImageURI(image_uri);
            LinearLayout photoList = getView().findViewById(R.id.photoList);
            photoList.addView(img);

            //save Image URI to this.images
            this.images.add(image_uri);

        }
    }

    private void uploadImages(String id_announcement){

        UploadImageService service = ServiceGenerator.createService(UploadImageService.class);

        for (Uri u : this.images){
            File file = new File(u.getPath());

            RequestBody requestFile = RequestBody.create(MediaType.parse(getContext().getContentResolver().getType(u)), file);
            MultipartBody.Part body = MultipartBody.Part.createFormData("image", file.getName(), requestFile);
            RequestBody announcement_id = RequestBody.create(okhttp3.MultipartBody.FORM, id_announcement);

            Call<ResponseBody> call = service.uploadImage(announcement_id, body);
            call.enqueue(new Callback<ResponseBody>() {
                @Override
                public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                    System.out.println("IMAGE UPLOADED");
                }

                @Override
                public void onFailure(Call<ResponseBody> call, Throwable t) {
                    System.out.println("ERROR UPLOADING THE IMAGE");
                }
            });

        }
    }

}