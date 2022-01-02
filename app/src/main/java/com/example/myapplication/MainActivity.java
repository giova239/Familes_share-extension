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
    private String user_id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.user_id = getIntent().getStringExtra("user_id");

        BottomNavigationView navView = findViewById(R.id.nav_view);

        //load DASHBOARD fragment first
        HomeFragment f = new HomeFragment();
        Bundle b = new Bundle();
        b.putString("user_id", this.user_id);
        f.setArguments(b);
        getFragmentManager().beginTransaction().replace(R.id.fragment_container, f).commit();

        //NavBar change listener
        navView.setOnItemSelectedListener(item -> {

            switch (item.getItemId()){
                case R.id.navigation_home:
                    //change to PROFILE fragment
                    HomeFragment f1 = new HomeFragment();
                    Bundle b1 = new Bundle();
                    b1.putString("user_id", this.user_id);
                    f1.setArguments(b1);
                    getFragmentManager().beginTransaction().replace(R.id.fragment_container, f1).commit();
                    break;
                case R.id.navigation_dashboard:
                    //change to GROUPS fragment
                    DashboardFragment f2 = new DashboardFragment();
                    Bundle b2 = new Bundle();
                    b2.putString("user_id", this.user_id);
                    f2.setArguments(b2);
                    getFragmentManager().beginTransaction().replace(R.id.fragment_container, f2).commit();
                    break;
                case R.id.navigation_notifications:
                    //change to CHATS fragment
                    NotificationsFragment f3 = new NotificationsFragment();
                    Bundle b3 = new Bundle();
                    b3.putString("user_id", this.user_id);
                    f3.setArguments(b3);
                    getFragmentManager().beginTransaction().replace(R.id.fragment_container, f3).commit();
                    break;
            }

            return true;
        });
    }
}