package com.example.myapplication.ui.dashboard;

import android.app.Fragment;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.os.Handler;
import android.util.TypedValue;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentSearchGroupBinding;

import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;
import java.util.List;

public class SearchGroupFragment extends Fragment {

    private FragmentSearchGroupBinding binding;
    private String user_id;
    private SearchView sw;
    private ListView lw;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentSearchGroupBinding.inflate(inflater, container, false);

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
        loadSearchList(getView());
    }

    private void loadSearchList(View view){
        this.sw = view.findViewById(R.id.search_bar);
        this.lw = view.findViewById(R.id.GroupListView);

        List<String> list = new ArrayList<>();

        RequestQueue queue = Volley.newRequestQueue(getContext());
        String url ="http://10.0.2.2:3300/allGroups";

        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                response -> {

                    JSONArray json;

                    System.out.println(response);
                    try {
                        json = new JSONArray(response);

                        for(int i = 0; i < json.length(); i++){
                            list.add(json.getJSONObject(i).getString("name"));
                        }

                        ArrayAdapter adapter = new ArrayAdapter<String>(view.getContext(), android.R.layout.simple_list_item_1, list);

                        this.lw.setAdapter(adapter);

                        this.sw.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
                            @Override
                            public boolean onQueryTextSubmit(String query) {
                                return false;
                            }

                            @Override
                            public boolean onQueryTextChange(String newText) {

                                adapter.getFilter().filter(newText);

                                return false;
                            }
                        });

                        this.lw.setOnItemClickListener(new AdapterView.OnItemClickListener() {

                            @Override
                            public void onItemClick(AdapterView<?> parent, View view,
                                                    int position, long id) {

                                try {
                                    String groupId = json.getJSONObject(position).getString("id_group");
                                    String groupDescription = json.getJSONObject(position).getString("description");
                                    String groupName = json.getJSONObject(position).getString("name");
                                    loadJoinGroupFragment(groupId, groupDescription, groupName);
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                }

                            }

                        });

                    } catch (JSONException e) {
                        System.out.println("error JSON" + e.toString());
                    }
                }, error -> {
            list.add("error404");
        });

        queue.add(stringRequest);
    }

    private void loadJoinGroupFragment(String groupId, String groupDescription, String groupName) {
        FragmentTransaction fs = getFragmentManager().beginTransaction();
        JoinGroupFragment f = new JoinGroupFragment();
        Bundle b = new Bundle();
        b.putString("group_id", groupId);
        b.putString("group_name", groupName);
        b.putString("group_description", groupDescription);
        b.putString("user_id", this.user_id);
        f.setArguments(b);
        fs.replace(R.id.fragment_container, f);
        fs.addToBackStack("groups");
        fs.commit();
    }
}