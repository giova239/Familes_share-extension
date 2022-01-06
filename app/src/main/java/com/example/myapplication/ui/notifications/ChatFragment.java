package com.example.myapplication.ui.notifications;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentChatBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class ChatFragment extends Fragment {

    private FragmentChatBinding binding;
    private String user_id;
    private String chat_id;
    private String chat_name;


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.user_id = getArguments().getString("user_id");
        this.chat_id = getArguments().getString("chat_id");
        this.chat_name = getArguments().getString("chat_name");
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
        LayoutInflater inflater = LayoutInflater.from(view.getContext());

        //add user profile bar
        ConstraintLayout profile = (ConstraintLayout) inflater.inflate(R.layout.chat_image, null, false);
        ((TextView) profile.findViewById(R.id.chat_name)).setText(this.chat_name);
        message_list.addView(profile);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/getAllMessages/;"+this.chat_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    try {

                        JSONArray json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){

                            //add messages
                            ConstraintLayout message;

                            if(this.user_id == json.getJSONObject(i).getString("sender")){
                                message = (ConstraintLayout) inflater.inflate(R.layout.sender_message, null, false);
                            }else{
                                message = (ConstraintLayout) inflater.inflate(R.layout.receiver_message, null, false);
                            }

                            ((TextView) message.findViewById(R.id.chat_message)).setText(json.getJSONObject(i).getString("message"));
                            message_list.addView(message);

                        }

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
            EditText enterMessage = v.findViewById(R.id.enterMessage);
            String msg = enterMessage.getText().toString();

            //Send Message
            RequestQueue queue = Volley.newRequestQueue(v.getContext());
            String url = "http://10.0.2.2:3300/sendMessage";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    response -> {
                        //create CHAT CORRECT
                        Toast.makeText(v.getContext(), "Message Sent", Toast.LENGTH_SHORT).show();

                        //show message
                        LinearLayout message_list = v.findViewById(R.id.message_list);
                        LayoutInflater inflater = LayoutInflater.from(v.getContext());
                        ConstraintLayout newMessage = (ConstraintLayout) inflater.inflate(R.layout.sender_message, null, false);
                        ((TextView) newMessage.findViewById(R.id.chat_message)).setText(msg);
                        message_list.addView(newMessage);

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
                    params.put("message", msg);

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

}