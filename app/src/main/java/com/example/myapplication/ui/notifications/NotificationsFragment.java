package com.example.myapplication.ui.notifications;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentNotificationsBinding;
import com.example.myapplication.ui.home.AnnouncementFragment;
import com.example.myapplication.ui.home.CreateAnnouncementFragment;

import org.json.JSONArray;
import org.json.JSONException;

public class NotificationsFragment extends Fragment {

    private FragmentNotificationsBinding binding;
    private String subject;


    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.subject = getArguments().getString("subject");
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
        TextView title = view.findViewById(R.id.chatUser);
        title.setText(this.subject);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/chat/"+this.subject;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    JSONArray json;

                    System.out.println(response);
                    try {
                        json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){
                            final int index = i;

                            //Get Template
                            LayoutInflater inflater = LayoutInflater.from(view.getContext());
                            View layout = inflater.inflate(R.layout.notificationitem, null, false);

                            //Change Chat User
                            TextView chat_user = layout.findViewById(R.id.chatUser);
                            chat_user.setText(json.getJSONObject(i).getString("interested"));

                            //Set OnClickListener for chat item
                            layout.setOnClickListener(v -> {
                                FragmentTransaction fs = getFragmentManager().beginTransaction();
                                NotificationsFragment f = new NotificationsFragment();
                                Bundle b = new Bundle();
                                try {
                                    b.putString("chat_id", json.getJSONObject(index).getString("id_chat"));
                                    b.putString("announcement_name", json.getJSONObject(index).getString("announcement"));
                                    b.putString("subject", json.getJSONObject(index).getString("interested"));
                                } catch (JSONException e) {
                                    System.out.println("error JSON" + e.toString());
                                }
                                f.setArguments(b);
                                fs.replace(R.id.fragment_container, f);
                                fs.addToBackStack("notifications");
                                fs.commit();
                            });

                            //Load chats
                            LinearLayout linear = view.findViewById(R.id.fragment_notification);
                            linear.addView(layout);

                        }

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }
                }, error -> {

            //Get Template
            LayoutInflater inflater = LayoutInflater.from(view.getContext());
            View layout = inflater.inflate(R.layout.notificationitem, null, false);

            //Load chats
            LinearLayout linear = view.findViewById(R.id.fragment_notification);
            linear.addView(layout);

        });

        queue.add(stringRequest);
    }
}