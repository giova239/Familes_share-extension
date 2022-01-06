package com.example.myapplication.ui.dashboard;

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

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.Retrofit.TransferImageService;
import com.example.myapplication.databinding.FragmentGroupBinding;

import org.json.JSONArray;
import org.json.JSONException;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class GroupFragment extends Fragment {

    private FragmentGroupBinding binding;
    private String user_id;
    private String group_id;
    private String group_name;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.group_id = getArguments().getString("group_id");
        this.group_name = getArguments().getString("group_name");
        super.onCreate(savedInstanceState);
    }

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentGroupBinding.inflate(inflater, container, false);
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
        loadGroupInfos(view);
    }

    private void loadGroupInfos(View view){
        TextView title = view.findViewById(R.id.announcementTitle);
        title.setText(this.group_name);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/announcementListForGroup/"+this.group_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    JSONArray json;

                    System.out.println("ANNOUNCEMENTS: " + response);
                    try {
                        json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){
                            final int index = i;

                            //Get Template
                            LayoutInflater inflater = LayoutInflater.from(view.getContext());
                            View layout = inflater.inflate(R.layout.announcementitem, null, false);

                            //Change Image
                            ImageView img = layout.findViewById(R.id.announcementIcon);
                            downloadImage(json.getJSONObject(index).getString("id_announcement"),img);
                            //Change Announcement Title
                            TextView announcement_title = layout.findViewById(R.id.annoncementTitle);
                            announcement_title.setText(json.getJSONObject(i).getString("title"));
                            //Set OnClickListener for announcement item
                            layout.setOnClickListener(v -> {
                                FragmentTransaction fs = getFragmentManager().beginTransaction();
                                AnnouncementFragment f = new AnnouncementFragment();
                                Bundle b = new Bundle();
                                try {
                                    b.putString("announcement_id", json.getJSONObject(index).getString("id_announcement"));
                                    b.putString("announcement_name", json.getJSONObject(index).getString("title"));
                                    b.putString("announcement_description", json.getJSONObject(index).getString("description"));
                                    b.putString("announcement_type", json.getJSONObject(index).getString("type"));
                                    b.putString("announcement_creator", json.getJSONObject(index).getString("name")+" "+json.getJSONObject(index).getString("surname"));
                                    b.putString("user_id", this.user_id);
                                } catch (JSONException e) {
                                    System.out.println("error JSON" + e.toString());
                                }
                                f.setArguments(b);
                                fs.replace(R.id.fragment_container, f);
                                fs.addToBackStack("announcements");
                                fs.commit();
                            });

                            //Load announcement
                            LinearLayout linear = view.findViewById(R.id.announcementList);
                            linear.addView(layout);

                        }

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }
                }, error -> {

            //Get Template
            LayoutInflater inflater = LayoutInflater.from(view.getContext());
            View layout = inflater.inflate(R.layout.announcementitem, null, false);

            //Load announcement
            LinearLayout linear = view.findViewById(R.id.announcementList);
            linear.addView(layout);

        });

        queue.add(stringRequest);

        view.findViewById(R.id.createAnnouncementButton).setOnClickListener(v -> {
            FragmentTransaction fs = getFragmentManager().beginTransaction();
            CreateAnnouncementFragment f = new CreateAnnouncementFragment();
            Bundle b = new Bundle();
            b.putString("id_group", this.group_id);
            b.putString("user_id", this.user_id);
            f.setArguments(b);
            fs.replace(R.id.fragment_container, f);
            fs.addToBackStack("announcements");
            fs.commit();
        });
    }

    private void downloadImage(String id_announcement, ImageView img){

        TransferImageService service = ServiceGenerator.createService(TransferImageService.class);

        Call<ResponseBody> call = service.downloadImage("http://10.0.2.2:3300/getImage/"+id_announcement);

        call.enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                if (response.isSuccessful()) {
                    System.out.println("server contacted and has iamge");

                    String pathWereFileWasStored = writeResponseBodyToDisk(response.body());

                    if(pathWereFileWasStored != null){
                        System.out.println("IMAGE DOWNLOADED at:" + pathWereFileWasStored);
                        Uri u = Uri.fromFile(new File(pathWereFileWasStored));
                        if(u != null) {
                            img.setImageURI(u);
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