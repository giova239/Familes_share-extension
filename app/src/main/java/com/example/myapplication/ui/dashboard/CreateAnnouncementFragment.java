package com.example.myapplication.ui.dashboard;

import android.Manifest;
import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.Switch;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.databinding.FragmentCreateAnnouncementBinding;
import com.example.myapplication.Retrofit.TransferImageService;

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
    private String user_id;
    private static final int REQUEST_EXTERNAL_STORAGE = 1;
    private static String[] PERMISSIONS_STORAGE = {
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE};
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
        this.user_id = getArguments().getString("user_id");
        loadCreateAnnouncement(view);
    }

    private void loadCreateAnnouncement(View view){

        //ADD PHOTO BUTTON
        view.findViewById(R.id.addPhotoButton).setOnClickListener(v -> {
            verifyStoragePermissions(getActivity());
            Intent pickPhoto = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
            pickPhoto.setType("image/*");
            startActivityForResult(pickPhoto , 1);
        });

        //PUBLISH ANNOUNCEMENT BUTTON
        view.findViewById(R.id.createAnnouncementButton).setOnClickListener(v -> {

            ProgressBar pbar = getView().findViewById(R.id.progressBar);
            pbar.setVisibility(View.VISIBLE);

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
                String url ="http://10.0.2.2:3300/createAnnouncement/"+this.user_id;
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

            pbar.setVisibility(View.VISIBLE);

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

        int pictureNumber = 0;
        for (Uri u : this.images){

            pictureNumber++;

            final int n = pictureNumber;

            File file = new File(getPath(u));

            TransferImageService service = ServiceGenerator.createService(TransferImageService.class);
            RequestBody requestFile = RequestBody.create(MediaType.parse(getContext().getContentResolver().getType(u)), file);
            MultipartBody.Part body = MultipartBody.Part.createFormData("image", file.getName(), requestFile);
            RequestBody announcement_id = RequestBody.create(okhttp3.MultipartBody.FORM, id_announcement+"_"+pictureNumber);

            Call<ResponseBody> call = service.uploadImage(announcement_id, body);
            call.enqueue(new Callback<ResponseBody>() {
                @Override
                public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                    System.out.println("IMAGE #" + n + " UPLOADED");
                }

                @Override
                public void onFailure(Call<ResponseBody> call, Throwable t) {
                    System.out.println("ERROR UPLOADING THE IMAGE #" + n);
                    t.printStackTrace();
                }
            });

        }
    }

    private String getPath(Uri uri)
    {
        String[] projection = { MediaStore.Images.Media.DATA };
        Cursor cursor = getContext().getContentResolver().query(uri, projection, null, null, null);
        if (cursor == null) return null;
        int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
        cursor.moveToFirst();
        String s= cursor.getString(column_index);
        cursor.close();
        return s;
    }

    public static void verifyStoragePermissions(Activity activity) {
        // Check if we have write permission
        int permission = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);

        if (permission != PackageManager.PERMISSION_GRANTED) {
            // We don't have permission so prompt the user
            ActivityCompat.requestPermissions(
                    activity,
                    PERMISSIONS_STORAGE,
                    REQUEST_EXTERNAL_STORAGE
            );
        }
    }

}