package com.example.myapplication.ui.dashboard;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
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
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentCreateGroupBinding;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class CreateGroupFragment extends Fragment {

    private FragmentCreateGroupBinding binding;
    private String user_id;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentCreateGroupBinding.inflate(inflater, container, false);

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

        getView().findViewById(R.id.createNewGroupButton).setOnClickListener(v -> {

            String name = ((EditText) getView().findViewById(R.id.enterNewGroupName)).getText().toString();
            String desc = ((EditText) getView().findViewById(R.id.enterNewGroupDescription)).getText().toString();

            Toast.makeText(v.getContext(), name+desc, Toast.LENGTH_SHORT).show();

            //create group
            RequestQueue queue = Volley.newRequestQueue(v.getContext());
            String url = "http://10.0.2.2:3300/createGroup/"+this.user_id;

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    response -> {
                        //GROUP CREATION CORRECT
                        Toast.makeText(v.getContext(), "Group Created", Toast.LENGTH_SHORT).show();
                        getFragmentManager().popBackStackImmediate();
                    },
                    error -> {
                        //GROUP CREATION FAILED
                        Toast.makeText(v.getContext(), "Couldn't create the group", Toast.LENGTH_SHORT).show();
                    }
            ) {
                @Override
                public byte[] getBody() throws AuthFailureError {

                    Map<String, String> params = new HashMap<String, String>();

                    params.put("name", name);
                    params.put("description", desc);

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