package com.example.myapplication.ui.dashboard;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.Retrofit.TransferImageService;
import com.example.myapplication.databinding.FragmentAnnouncementBinding;
import com.example.myapplication.ui.notifications.ChatFragment;
import com.smarteist.autoimageslider.SliderView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class AnnouncementFragment extends Fragment {

    private FragmentAnnouncementBinding binding;
    private String user_id;
    private String announcement_id;
    private String announcement_name;
    private String announcement_description;
    private String announcement_type;
    private String announcement_creator;
    private SliderView imgSlider;
    private List<Uri> images = new LinkedList<>();

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.announcement_id = getArguments().getString("announcement_id");
        this.announcement_name = getArguments().getString("announcement_name");
        this.announcement_description = getArguments().getString("announcement_description");
        this.announcement_type = getArguments().getString("announcement_type");
        this.announcement_creator = getArguments().getString("announcement_creator");
        super.onCreate(savedInstanceState);
    }

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentAnnouncementBinding.inflate(inflater, container, false);
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
        loadAnnouncementInfos(view);
        loadAnswerMessageButton(view);
    }

    private void loadAnnouncementInfos(View view){
        TextView title = view.findViewById(R.id.announcementTitle);
        title.setText(this.announcement_name);
        TextView desc = view.findViewById(R.id.annoncementDescription);
        desc.setText(this.announcement_description);
        this.imgSlider = view.findViewById(R.id.imageSlider);
        downloadAllImages(this.announcement_id);
    }

    private void loadAnswerMessageButton(View view) {
        Button b = view.findViewById(R.id.answerAnnouncementButton);
        b.setOnClickListener(v -> {

            //create conversation
            RequestQueue queue = Volley.newRequestQueue(v.getContext());
            String url = "http://10.0.2.2:3300/createChat";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    response -> {
                        //create CHAT CORRECT
                        Toast.makeText(v.getContext(), "Chat Created", Toast.LENGTH_SHORT).show();

                        try {
                            JSONObject json = new JSONObject(response);
                            FragmentTransaction fs = getFragmentManager().beginTransaction();
                            ChatFragment f = new ChatFragment();
                            Bundle bundle = new Bundle();
                            bundle.putString("chat_id", json.getString("id_chat"));
                            bundle.putString("chat_name", this.announcement_creator);
                            bundle.putString("user_id", this.user_id);
                            f.setArguments(bundle);
                            fs.replace(R.id.fragment_container, f);
                            fs.addToBackStack("announcement");
                            fs.commit();
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    },
                    error -> {
                        //create CHAT FAILED
                        Toast.makeText(v.getContext(), "Couldn't Create Chat", Toast.LENGTH_SHORT).show();
                    }
            ) {
                @Override
                public byte[] getBody() throws AuthFailureError {

                    Map<String, String> params = new HashMap<String, String>();

                    params.put("user1", user_id);
                    params.put("user2", announcement_creator);

                    return new JSONObject(params).toString().getBytes();
                }

                @Override
                public String getBodyContentType() {
                    return "application/json";
                }
            };
            queue.add(postRequest);

        });
    }

    private void downloadAllImages (String id_announcement){

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/getImageCount/"+id_announcement;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    int ammount = 0;
                    JSONArray json;

                    try {
                        json = new JSONArray(response);
                        ammount = Integer.parseInt(json.getJSONObject(0).getString("ammount"));
                        System.out.println("AMMOUNT OF IMAGES:" + ammount);

                        for (int i = 1; i <= ammount; i++){
                            downloadImage(this.announcement_id, Integer.toString(i), ammount);
                        }

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }

                }, error -> {});

        queue.add(stringRequest);

    }

    private void downloadImage(String id_announcement, String index, int ammount){

        TransferImageService service = ServiceGenerator.createService(TransferImageService.class);

        Call<ResponseBody> call = service.downloadImage("http://10.0.2.2:3300/getImageByIndex/"+id_announcement+"/"+index);

        call.enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(Call<ResponseBody> call, Response<ResponseBody> response) {
                if (response.isSuccessful()) {

                    String name = id_announcement+"_"+index;

                    System.out.println("server contacted and has image " + name);

                    String pathWereFileWasStored = writeResponseBodyToDisk(response.body(), name);

                    if(pathWereFileWasStored != null){
                        System.out.println("IMAGE DOWNLOADED at:" + pathWereFileWasStored);
                        Uri u = Uri.fromFile(new File(pathWereFileWasStored));
                        if(u != null) {

                            addImageURItoImages(u, Integer.parseInt(index), ammount);

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

    private void addImageURItoImages(Uri u, int index, int ammount){
        this.images.add(u);
        System.out.println(this.images.toString());

        if(index == ammount){
            loadImageSlider(ammount);
        }
    }

    private void loadImageSlider(int ammount){
        ImageSliderAdapter adpt = new ImageSliderAdapter(this.images);
        if (ammount == 1){
            imgSlider.setSliderAdapter(adpt,false);
        }else{
            imgSlider.setSliderAdapter(adpt);
        }
    }

    private String writeResponseBodyToDisk(ResponseBody body, String name) {
        try {

            System.out.println(body.contentType().toString());

            String path = getContext().getExternalFilesDir(null) + File.separator + name;
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