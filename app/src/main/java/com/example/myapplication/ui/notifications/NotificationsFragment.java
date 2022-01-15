package com.example.myapplication.ui.notifications;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.Retrofit.TransferImageService;
import com.example.myapplication.databinding.FragmentNotificationsBinding;
import com.example.myapplication.ui.dashboard.GroupFragment;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class NotificationsFragment extends Fragment {

    private FragmentNotificationsBinding binding;
    private String user_id;


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.user_id = getArguments().getString("user_id");
        super.onCreate(savedInstanceState);
    }


    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentNotificationsBinding.inflate(inflater, container, false);

        return binding.getRoot();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        binding = null;
    }

    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        loadChats(view);
    }

    private void loadChats(View view){

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/getUserChats/"+this.user_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    LinearLayout chat_list = view.findViewById(R.id.chat_list);
                    LayoutInflater inflater = LayoutInflater.from(view.getContext());

                    try {

                        JSONArray json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){

                            ConstraintLayout elem = (ConstraintLayout) inflater.inflate(R.layout.chat_image, null, false);
                            String s = json.getJSONObject(i).getString("name")+" "+json.getJSONObject(i).getString("surname");
                            ((TextView) elem.findViewById(R.id.chat_name)).setText(s);
                            setProfileImage(elem.findViewById(R.id.chat_image), json.getJSONObject(i).getString("id_user"));

                            final int index = i;

                            elem.setOnClickListener(v -> {
                                FragmentTransaction fs = getFragmentManager().beginTransaction();
                                ChatFragment f = new ChatFragment();
                                Bundle b = new Bundle();
                                try {
                                    b.putString("chat_id", json.getJSONObject(index).getString("id_chat"));
                                    b.putString("other_id", json.getJSONObject(index).getString("id_user"));
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }
                                b.putString("chat_name", s);
                                b.putString("user_id", this.user_id);
                                f.setArguments(b);
                                fs.replace(R.id.fragment_container, f);
                                fs.addToBackStack("chats");
                                fs.commit();
                            });

                            chat_list.addView(elem);

                        }

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                }, error -> {

                    Toast.makeText(view.getContext(), "Couldn't load chats", Toast.LENGTH_SHORT).show();

        });

        queue.add(stringRequest);
    }

    private void setProfileImage(ImageView profileImage, String usr) {
        TransferImageService service = ServiceGenerator.createService(TransferImageService.class);

        Call<ResponseBody> call = service.downloadImage("http://10.0.2.2:3300/getProfileImage/"+usr);

        call.enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                if (response.isSuccessful()) {
                    System.out.println("server contacted and has image");

                    String pathWereFileWasStored = writeResponseBodyToDisk(response.body());

                    if(pathWereFileWasStored != null){
                        System.out.println("IMAGE DOWNLOADED at:" + pathWereFileWasStored);
                        Uri u = Uri.fromFile(new File(pathWereFileWasStored));
                        if(u != null) {
                            profileImage.setImageURI(u);
                        }
                    }else{
                        System.out.println("error while downloading the image");
                    }
                } else {
                    System.out.println("server contact failed");
                }
            }

            @Override
            public void onFailure(Call<ResponseBody> call, Throwable t) {
                System.out.println("error");
            }
        });
    }

    private String writeResponseBodyToDisk(ResponseBody body) {
        try {

            String path = getContext().getExternalFilesDir(null) + File.separator + "test.jpeg";
            File imageFile = new File(path);

            InputStream inputStream = null;
            OutputStream outputStream = null;

            try {
                byte[] fileReader = new byte[4096];

                long fileSize = body.contentLength();
                long fileSizeDownloaded = 0;

                inputStream = body.byteStream();
                outputStream = new FileOutputStream(imageFile);

                while (true) {
                    int read = inputStream.read(fileReader);

                    if (read == -1) {
                        break;
                    }

                    outputStream.write(fileReader, 0, read);

                    fileSizeDownloaded += read;
                }

                outputStream.flush();

                return path;

            } catch (IOException e) {
                return null;
            } finally {
                if (inputStream != null) {
                    inputStream.close();
                }

                if (outputStream != null) {
                    outputStream.close();
                }
            }
        } catch (IOException e) {
            return null;
        }
    }
}