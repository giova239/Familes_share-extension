package com.example.myapplication.ui.notifications;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
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
import com.example.myapplication.databinding.FragmentNotificationsBinding;
import com.example.myapplication.ui.dashboard.GroupFragment;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

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
                            final int index = i;

                            elem.setOnClickListener(v -> {
                                FragmentTransaction fs = getFragmentManager().beginTransaction();
                                ChatFragment f = new ChatFragment();
                                Bundle b = new Bundle();
                                try {
                                    b.putString("chat_id", json.getJSONObject(index).getString("id_chat"));
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
}