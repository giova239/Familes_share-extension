package com.example.myapplication.ui.home;

import static com.example.myapplication.ui.dashboard.CreateAnnouncementFragment.verifyStoragePermissions;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.Retrofit.TransferImageService;
import com.example.myapplication.databinding.FragmentHomeBinding;
import com.example.myapplication.ui.dashboard.CreateGroupFragment;

import org.json.JSONArray;
import org.json.JSONException;

import java.io.File;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class HomeFragment extends Fragment {

    private FragmentHomeBinding binding;
    private String user_id;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentHomeBinding.inflate(inflater, container, false);
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
        this.user_id = getArguments().getString("user_id");
        loadUserProfile(getView());
        loadProfileImage(getView());
    }

    private void loadUserProfile(View view){

        final TextView emailFill = view.findViewById(R.id.EmailFill);
        final TextView nameFill = view.findViewById(R.id.NameFill);
        final TextView surnameFill = view.findViewById(R.id.SurnameFill);
        final TextView birthDateFill = view.findViewById(R.id.BirthDateFill);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/users/"+this.user_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    JSONArray json;

                    System.out.println(response);
                    try {
                        json = new JSONArray(response);
                        emailFill.setText(json.getJSONObject(0).getString("email"));
                        nameFill.setText(json.getJSONObject(0).getString("name"));
                        surnameFill.setText(json.getJSONObject(0).getString("surname"));
                        birthDateFill.setText(json.getJSONObject(0).getString("birth_date"));

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }
                }, error -> {
                    emailFill.setText("error 404");
                    nameFill.setText("error 404");
                    surnameFill.setText("error 404");
                    birthDateFill.setText("error 404");
                });

        queue.add(stringRequest);

        Button yourAnnouncementsButton = view.findViewById(R.id.yourAnnouncementsButton);
        yourAnnouncementsButton.setOnClickListener(v -> {
            FragmentTransaction fs = getFragmentManager().beginTransaction();
            YourAnnouncementsFragment f = new YourAnnouncementsFragment();
            Bundle b = new Bundle();
            b.putString("user_id", this.user_id);
            f.setArguments(b);
            fs.replace(R.id.fragment_container, f);
            fs.addToBackStack("profile");
            fs.commit();
        });

    }

    private void loadProfileImage(View view){

        view.findViewById(R.id.profileImage).setOnClickListener(v -> {
            verifyStoragePermissions(getActivity());
            Intent pickPhoto = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
            pickPhoto.setType("image/*");
            startActivityForResult(pickPhoto , 1);
        });

    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == -1 && requestCode == 1){

            //retrieve profile image and upload it to Server
            Uri image_uri = data.getData();
            if(image_uri != null){
                File file = new File(getPath(image_uri));

                TransferImageService service = ServiceGenerator.createService(TransferImageService.class);
                RequestBody requestFile = RequestBody.create(MediaType.parse(getContext().getContentResolver().getType(image_uri)), file);
                MultipartBody.Part body = MultipartBody.Part.createFormData("image", file.getName(), requestFile);
                RequestBody id_user = RequestBody.create(okhttp3.MultipartBody.FORM, this.user_id);

                Call<ResponseBody> call = service.uploadProfileImage(id_user, body);
                call.enqueue(new Callback<ResponseBody>() {
                    @Override
                    public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                        //show it as profileImage
                        ImageView img = getView().findViewById(R.id.profileImageView);
                        img.setImageURI(image_uri);
                        Toast.makeText(getContext(), "Profile Image Uploaded", Toast.LENGTH_SHORT).show();
                    }

                    @Override
                    public void onFailure(Call<ResponseBody> call, Throwable t) {
                        Toast.makeText(getContext(), "Error while uploading the profile Image", Toast.LENGTH_SHORT).show();
                    }
                });
            }

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


}