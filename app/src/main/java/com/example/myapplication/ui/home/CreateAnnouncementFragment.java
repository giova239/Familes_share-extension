package com.example.myapplication.ui.home;

import android.app.DownloadManager;
import android.app.Fragment;
import android.content.ContentResolver;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
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
import com.android.volley.toolbox.BaseHttpStack;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentCreateAnnouncementBinding;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

public class CreateAnnouncementFragment extends Fragment {

    private FragmentCreateAnnouncementBinding binding;
    private List<Bitmap> images = new LinkedList<>();

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
                JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, url, j,
                        response -> {
                            Toast.makeText(v.getContext(), "Announcement Created", Toast.LENGTH_SHORT);
                            try {
                                String id_announcement = response.getString("id_announcement");
                                uploadImages(id_announcement);
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                        },
                        error -> {
                            Toast.makeText(v.getContext(), "Error on announcement creation", Toast.LENGTH_SHORT);
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

            try {

                //retrive Image
                ImageView img = new ImageView(getContext());
                Uri image_uri = data.getData();
                LinearLayout.LayoutParams p = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                p.setMargins(20,20,20,20);
                img.setLayoutParams(p);

                //convert image to bitmap and save it in this.images
                Bitmap image_bitmap = MediaStore.Images.Media.getBitmap(getContext().getContentResolver(), image_uri);
                this.images.add(image_bitmap);

                //add image to photoList
                img.setImageBitmap(image_bitmap);
                LinearLayout photoList = getView().findViewById(R.id.photoList);
                photoList.addView(img);

            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

    private void uploadImages(String id_announcement){

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/uploadimage/"+id_announcement;
        for (Bitmap b : this.images){

        }

    }

}