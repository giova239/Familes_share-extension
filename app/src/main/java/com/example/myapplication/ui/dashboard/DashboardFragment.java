package com.example.myapplication.ui.dashboard;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.IdRes;
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
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentDashboardBinding;
import com.example.myapplication.ui.home.GroupFragment;
import com.example.myapplication.ui.home.HomeFragment;

import org.json.JSONArray;
import org.json.JSONException;
import org.w3c.dom.Text;

public class DashboardFragment extends Fragment {

    private FragmentDashboardBinding binding;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentDashboardBinding.inflate(inflater, container, false);

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
        loadGroupsOfUsers(getView());
    }

    private void loadGroupsOfUsers(View view){

        final LinearLayout insertHere = view.findViewById(R.id.linearLayout);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/usergroups/1";

        // Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {
                    // Display the first 500 characters of the response string.
                    JSONArray json;

                    System.out.println(response);
                    try {
                        json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){
                            TextView err = getNewTextView(view, json.getJSONObject(i).getString("id_group"), json.getJSONObject(i).getString("name"));
                            insertHere.addView(err);
                        }

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }
                }, error -> {

                    TextView err = getNewTextView(view, null, "Error 404");
                    insertHere.addView(err);
                });

        // Add the request to the RequestQueue.
        queue.add(stringRequest);

    }

    private TextView getNewTextView(View view, String group_id, String group_name){
        TextView tmp = new TextView(view.getContext());
        tmp.setText(group_name);
        tmp.setPadding(0, 30, 0, 30);
        tmp.setTextSize(TypedValue.COMPLEX_UNIT_DIP, 25);
        tmp.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        tmp.setGravity(Gravity.CENTER);
        tmp.setLayoutParams(new ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
        ));
        tmp.setOnClickListener(v -> {
            System.out.println("clicked " + group_name);
            FragmentTransaction fs = getFragmentManager().beginTransaction();
            GroupFragment f = new GroupFragment();
            Bundle b = new Bundle();
            b.putString("group_id", group_id);
            b.putString("group_name", group_name);
            f.setArguments(b);
            fs.replace(R.id.fragment_container, f);
            fs.addToBackStack("groups");
            fs.commit();
        });
        return tmp;
    }

}