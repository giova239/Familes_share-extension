package com.example.myapplication.ui.home;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentAnnouncementBinding;

public class AnnouncementFragment extends Fragment {

    private FragmentAnnouncementBinding binding;
    private String announcement_id;
    private String announcement_name;
    private String announcement_description;
    private String announcement_category;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        this.announcement_id = getArguments().getString("announcement_id");
        this.announcement_name = getArguments().getString("announcement_name");
        this.announcement_description = getArguments().getString("announcement_description");
        this.announcement_category = getArguments().getString("announcement_category");
        super.onCreate(savedInstanceState);
    }

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {

        binding = FragmentAnnouncementBinding.inflate(inflater, container, false);
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
        loadAnnouncementInfos(view);
    }

    private void loadAnnouncementInfos(View view){
        TextView title = view.findViewById(R.id.announcementTitle);
        title.setText(this.announcement_name);
        TextView desc = view.findViewById(R.id.annoncementDescription);
        desc.setText(this.announcement_description);
    }
}