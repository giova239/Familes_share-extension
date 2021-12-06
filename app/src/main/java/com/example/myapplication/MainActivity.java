package com.example.myapplication;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.databinding.ActivityMainBinding;
import com.example.myapplication.ui.home.HomeFragment;
import com.example.myapplication.ui.dashboard.DashboardFragment;
import com.example.myapplication.ui.notifications.NotificationsFragment;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity {

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        BottomNavigationView navView = findViewById(R.id.nav_view);

        //load HOME fragment first
        getFragmentManager().beginTransaction().replace(R.id.fragment_container, new HomeFragment()).commit();

        //NavBar change listener
        navView.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem item) {

                switch (item.getItemId()){
                    case R.id.navigation_home:
                        //change to PROFILE fragment
                        getFragmentManager().beginTransaction().replace(R.id.fragment_container, new HomeFragment()).commit();
                        break;
                    case R.id.navigation_dashboard:
                        //change to GROUPS fragment
                        getFragmentManager().beginTransaction().replace(R.id.fragment_container, new DashboardFragment()).commit();
                        break;
                    case R.id.navigation_notifications:
                        //change to CHATS fragment
                        getFragmentManager().beginTransaction().replace(R.id.fragment_container, new NotificationsFragment()).commit();
                        break;
                }

                return false;
            }
        });
    }
}