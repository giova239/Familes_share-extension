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

import com.example.myapplication.R;
import com.example.myapplication.databinding.FragmentGroupBinding;

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

        LayoutInflater inflater = LayoutInflater.from(view.getContext());
        View layout = inflater.inflate(R.layout.announcement, null, false);

        LinearLayout linear = view.findViewById(R.id.announcementList);
        linear.addView(layout);
    }
}