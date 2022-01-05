package com.example.myapplication.ui.dashboard;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentJoinGroupBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class JoinGroupFragment extends Fragment {

    private FragmentJoinGroupBinding binding;
    private String user_id;
    private String group_id;
    private String group_name;
    private String group_description;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentJoinGroupBinding.inflate(inflater, container, false);

        return binding.getRoot();
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
        this.group_id = getArguments().getString("group_id");
        this.group_name = getArguments().getString("group_name");
        this.group_description = getArguments().getString("group_description");
        loadGroupInfo(view);
    }

    private void loadGroupInfo(View view) {
        TextView name = view.findViewById(R.id.group_name);
        TextView desc = view.findViewById(R.id.group_description);
        Button join = view.findViewById(R.id.joinGroupButton);

        name.setText(this.group_name);
        desc.setText(this.group_description);

        join.setOnClickListener(v ->{
            //join group
            RequestQueue queue = Volley.newRequestQueue(v.getContext());
            String url = "http://10.0.2.2:3300/joinGroup";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    response -> {
                        //JOIN CORRECT
                        Toast.makeText(v.getContext(), "Group Joined", Toast.LENGTH_SHORT).show();
                    },
                    error -> {
                        //JOIN FAILED
                        Toast.makeText(v.getContext(), "Couldn't Join", Toast.LENGTH_SHORT).show();
                    }
            ) {
                @Override
                public byte[] getBody() throws AuthFailureError {

                    Map<String, String> params = new HashMap<String, String>();

                    params.put("user_id", user_id);
                    params.put("group_id", group_id);

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