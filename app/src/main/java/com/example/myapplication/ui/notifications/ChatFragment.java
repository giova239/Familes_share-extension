package com.example.myapplication.ui.notifications;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.widget.NestedScrollView;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.Retrofit.TransferImageService;
import com.example.myapplication.databinding.FragmentChatBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class ChatFragment extends Fragment {

    private FragmentChatBinding binding;
    private String user_id;
    private String chat_id;
    private String chat_name;
    private String other_id;


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.user_id = getArguments().getString("user_id");
        this.chat_id = getArguments().getString("chat_id");
        this.chat_name = getArguments().getString("chat_name");
        this.other_id = getArguments().getString("other_id");
        super.onCreate(savedInstanceState);
    }


    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentChatBinding.inflate(inflater, container, false);

        return binding.getRoot();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        binding = null;
    }

    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        loadMessages(view);
        loadSendMessageButton(view);
    }

    private void loadMessages(View view){

        LinearLayout message_list = view.findViewById(R.id.message_list);
        LinearLayout profile_bar = view.findViewById(R.id.profile_bar);
        LayoutInflater inflater = LayoutInflater.from(view.getContext());

        //add user profile bar
        ConstraintLayout profile = (ConstraintLayout) inflater.inflate(R.layout.chat_image, null, false);
        ((TextView) profile.findViewById(R.id.chat_name)).setText(this.chat_name);
        setProfileImage(profile.findViewById(R.id.chat_image), this.other_id);
        profile_bar.addView(profile);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/getAllMessages/"+this.chat_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    try {

                        JSONArray json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){

                            //add messages
                            ConstraintLayout message;

                            if(this.user_id.equals(json.getJSONObject(i).getString("sender"))){
                                message = (ConstraintLayout) inflater.inflate(R.layout.sender_message, null, false);
                            }else{
                                message = (ConstraintLayout) inflater.inflate(R.layout.receiver_message, null, false);
                            }

                            System.out.println(json);

                            ((TextView) message.findViewById(R.id.chat_message)).setText(json.getJSONObject(i).getString("text"));
                            message_list.addView(message);

                        }

                        NestedScrollView s = view.findViewById(R.id.chat);
                        s.post(new Runnable() {
                            @Override
                            public void run() {
                                s.fullScroll(ScrollView.FOCUS_DOWN);
                            }
                        });

                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                }, error -> {

            Toast.makeText(view.getContext(), "Couldn't load chats", Toast.LENGTH_SHORT).show();

        });

        queue.add(stringRequest);
    }

    private void loadSendMessageButton(View view) {
        Button b = view.findViewById(R.id.sendMessage);
        b.setOnClickListener(v -> {

            //Retrive Message
            EditText enterMessage = view.findViewById(R.id.enterMessage);
            String msg = enterMessage.getText().toString();

            //Send Message
            RequestQueue queue = Volley.newRequestQueue(v.getContext());
            String url = "http://10.0.2.2:3300/sendMessage";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    response -> {

                        //create CHAT CORRECT
                        Toast.makeText(v.getContext(), "Message Sent", Toast.LENGTH_SHORT).show();

                        //show message
                        LinearLayout message_list = view.findViewById(R.id.message_list);
                        LayoutInflater inflater = LayoutInflater.from(v.getContext());
                        ConstraintLayout newMessage = (ConstraintLayout) inflater.inflate(R.layout.sender_message, null, false);
                        ((TextView) newMessage.findViewById(R.id.chat_message)).setText(msg);
                        message_list.addView(newMessage);
                        enterMessage.setText("");

                        //scroll down
                        NestedScrollView s = view.findViewById(R.id.chat);
                        s.post(new Runnable() {
                            @Override
                            public void run() {
                                s.fullScroll(ScrollView.FOCUS_DOWN);
                            }
                        });

                    },
                    error -> {
                        //create CHAT FAILED
                        Toast.makeText(v.getContext(), "Couldn't Send the message", Toast.LENGTH_SHORT).show();
                    }
            ) {
                @Override
                public byte[] getBody() throws AuthFailureError {

                    Map<String, String> params = new HashMap<String, String>();

                    params.put("chat", chat_id);
                    params.put("sender", user_id);
                    params.put("text", msg);

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