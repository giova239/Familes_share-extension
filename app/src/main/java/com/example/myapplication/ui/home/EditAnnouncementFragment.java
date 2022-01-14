package com.example.myapplication.ui.home;

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
import com.example.myapplication.databinding.FragmentEditAnnouncementBinding;
import com.example.myapplication.ui.dashboard.ImageSliderAdapter;
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

public class EditAnnouncementFragment extends Fragment {

    private FragmentEditAnnouncementBinding binding;
    private String user_id;
    private String announcement_id;
    private String announcement_name;
    private String announcement_description;
    private String announcement_type;
    private String announcement_creator;
    private String creator_id;
    private SliderView imgSlider;
    private List<Uri> images = new LinkedList<>();

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.announcement_id = getArguments().getString("announcement_id");
        this.announcement_name = getArguments().getString("announcement_name");
        this.announcement_description = getArguments().getString("announcement_description");
        this.announcement_type = getArguments().getString("announcement_type");
        this.announcement_creator = getArguments().getString("announcement_creator");
        this.creator_id = getArguments().getString("creator_id");
        super.onCreate(savedInstanceState);
    }

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentEditAnnouncementBinding.inflate(inflater, container, false);
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
    }

    private void loadAnnouncementInfos(View view){
        TextView title = view.findViewById(R.id.announcementTitle);
        title.setText(this.announcement_name);
        TextView desc = view.findViewById(R.id.annoncementDescription);
        desc.setText(this.announcement_description);
        TextView creator = view.findViewById(R.id.CreatorDescription);
        creator.setText(this.announcement_creator);
        if(this.announcement_type.equals("true")){
            TextView hasOrNeed = view.findViewById(R.id.HasOrNeed);
            hasOrNeed.setText("NEEDS THIS");
            hasOrNeed.setTextColor(getResources().getColor(R.color.red));
        }
        this.imgSlider = view.findViewById(R.id.imageSlider);
        downloadAllImages(this.announcement_id);
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