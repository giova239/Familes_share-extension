package com.example.myapplication.ui.home;

import android.app.Fragment;
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
import com.example.myapplication.databinding.FragmentGroupBinding;

import org.json.JSONArray;
import org.json.JSONException;

public class GroupFragment extends Fragment {

    private FragmentGroupBinding binding;
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
        loadGroupInfos(view);
    }

    private void loadGroupInfos(View view){
        TextView title = view.findViewById(R.id.title);
        title.setText(this.group_name);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/announcemetListForGroup/"+this.group_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    JSONArray json;

                    System.out.println(response);
                    try {
                        json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){

                            //Get Template
                            LayoutInflater inflater = LayoutInflater.from(view.getContext());
                            View layout = inflater.inflate(R.layout.announcement, null, false);

                            //Change Image
                            layout.findViewById(R.id.announcementIcon);//TODO: change image
                            //Change Announcement Title
                            TextView announcement_title = layout.findViewById(R.id.annoncementTitle);
                            announcement_title.setText(json.getJSONObject(i).getString("title"));
                            //Change Announcement Description
                            TextView announcement_description = layout.findViewById(R.id.annoncementDescription);
                            announcement_description.setText(json.getJSONObject(i).getString("description"));

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
            View layout = inflater.inflate(R.layout.announcement, null, false);

            //Load announcement
            LinearLayout linear = view.findViewById(R.id.announcementList);
            linear.addView(layout);

        });

        queue.add(stringRequest);
    }
}