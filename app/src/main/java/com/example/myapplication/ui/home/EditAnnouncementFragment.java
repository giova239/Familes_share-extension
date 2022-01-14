package com.example.myapplication.ui.home;

import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.net.Uri;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.R;
import com.example.myapplication.Retrofit.ServiceGenerator;
import com.example.myapplication.Retrofit.TransferImageService;
import com.example.myapplication.databinding.FragmentEditAnnouncementBinding;
import com.example.myapplication.ui.dashboard.ImageSliderAdapter;
import com.smarteist.autoimageslider.SliderView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.LinkedList;
import java.util.List;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class EditAnnouncementFragment extends Fragment {

    private FragmentEditAnnouncementBinding binding;
    private String user_id;
    private String announcement_id;
    private String announcement_name;
    private String announcement_description;
    private String announcement_type;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.user_id = getArguments().getString("user_id");
        this.announcement_id = getArguments().getString("announcement_id");
        this.announcement_name = getArguments().getString("announcement_name");
        this.announcement_description = getArguments().getString("announcement_description");
        this.announcement_type = getArguments().getString("announcement_type");
        super.onCreate(savedInstanceState);
    }

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentEditAnnouncementBinding.inflate(inflater, container, false);
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
        loadEditingFields(view);
    }

    private void loadEditingFields(View view){
        EditText title = view.findViewById(R.id.enterTitle);
        EditText desc = view.findViewById(R.id.enterDescription);
        Switch type = view.findViewById(R.id.HadOrNeededSwitch);
        Button updateAnnouncementButton = view.findViewById(R.id.updateAnnouncementButton);

        title.setText(this.announcement_name);
        desc.setText(this.announcement_description);
        if(this.announcement_type.equals("true")){
            type.setChecked(true);
        }else{
            type.setChecked(false);
        }

        updateAnnouncementButton.setOnClickListener(v -> {
            RequestQueue queue = Volley.newRequestQueue(getContext());
            String url ="http://10.0.2.2:3300/updateAnnouncement";
            JSONObject j = new JSONObject();
            try {
                j.put("id_announcement", this.announcement_id);
                j.put("title", title.getText());
                j.put("description", desc.getText());
                j.put("type", type.isChecked());
            } catch (JSONException e) {
                e.printStackTrace();
            }
            JsonObjectRequest req = new JsonObjectRequest(Request.Method.POST, url, j,
                    response -> {
                        Toast.makeText(getContext(), "Announcement Updated", Toast.LENGTH_SHORT).show();
                        //go back and reload fragment
                        FragmentManager fm = getFragmentManager();
                        fm.popBackStackImmediate("profile", 1);
                    },
                    error -> {
                        Toast.makeText(getContext(), "Error on updating announcement", Toast.LENGTH_SHORT).show();
                    });
            queue.add(req);
        });
    }

}