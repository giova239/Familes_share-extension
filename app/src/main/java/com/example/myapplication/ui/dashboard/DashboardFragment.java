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

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentDashboardBinding;

import org.json.JSONArray;
import org.json.JSONException;

public class DashboardFragment extends Fragment {

    private FragmentDashboardBinding binding;
    private String user_id;

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
        this.user_id = getArguments().getString("user_id");
        loadGroupsOfUsers(getView());
        loadGroupButtons(getView());
    }

    private void loadGroupsOfUsers(View view){

        final LinearLayout insertHere = view.findViewById(R.id.GroupList);

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/usergroups/"+this.user_id;

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

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

        queue.add(stringRequest);

    }

    private void loadGroupButtons(View view){

        view.findViewById(R.id.createGroupButton).setOnClickListener(v -> {
            FragmentTransaction fs = getFragmentManager().beginTransaction();
            CreateGroupFragment f = new CreateGroupFragment();
            Bundle b = new Bundle();
            b.putString("user_id", this.user_id);
            f.setArguments(b);
            fs.replace(R.id.fragment_container, f);
            fs.addToBackStack("announcements");
            fs.commit();
        });

        view.findViewById(R.id.searchGroupButton).setOnClickListener(v -> {
            FragmentTransaction fs = getFragmentManager().beginTransaction();
            SearchGroupFragment f = new SearchGroupFragment();
            Bundle b = new Bundle();
            b.putString("user_id", this.user_id);
            f.setArguments(b);
            fs.replace(R.id.fragment_container, f);
            fs.addToBackStack("announcements");
            fs.commit();
        });

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
            FragmentTransaction fs = getFragmentManager().beginTransaction();
            GroupFragment f = new GroupFragment();
            Bundle b = new Bundle();
            b.putString("group_id", group_id);
            b.putString("group_name", group_name);
            b.putString("user_id", this.user_id);
            f.setArguments(b);
            fs.replace(R.id.fragment_container, f);
            fs.addToBackStack("groups");
            fs.commit();
        });
        return tmp;
    }

}