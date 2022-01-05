package com.example.myapplication.ui.home;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentHomeBinding;

import org.json.JSONArray;
import org.json.JSONException;

public class HomeFragment extends Fragment {

    private FragmentHomeBinding binding;
    private String user_id;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentHomeBinding.inflate(inflater, container, false);
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
        loadUserProfile(getView());
    }

    private void loadUserProfile(View view){

        final TextView emailFill = view.findViewById(R.id.EmailFill);
        final TextView nameFill = view.findViewById(R.id.NameFill);
        final TextView surnameFill = view.findViewById(R.id.SurnameFill);
        final TextView birthDateFill = view.findViewById(R.id.BirthDateFill);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/users/"+this.user_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    JSONArray json;

                    System.out.println(response);
                    try {
                        json = new JSONArray(response);
                        emailFill.setText(json.getJSONObject(0).getString("email"));
                        nameFill.setText(json.getJSONObject(0).getString("name"));
                        surnameFill.setText(json.getJSONObject(0).getString("surname"));
                        birthDateFill.setText(json.getJSONObject(0).getString("birth_date"));

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }
                }, error -> {
                    emailFill.setText("error 404");
                    nameFill.setText("error 404");
                    surnameFill.setText("error 404");
                    birthDateFill.setText("error 404");
                });

        queue.add(stringRequest);

    }
}