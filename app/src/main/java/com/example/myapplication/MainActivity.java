package com.example.myapplication;

import android.os.Bundle;
import android.widget.TextView;

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
import com.google.android.material.bottomnavigation.BottomNavigationView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity {

    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        BottomNavigationView navView = findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        AppBarConfiguration appBarConfiguration = new AppBarConfiguration.Builder(
                R.id.navigation_home, R.id.navigation_dashboard, R.id.navigation_notifications)
                .build();
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment_activity_main);
        NavigationUI.setupActionBarWithNavController(this, navController, appBarConfiguration);
        NavigationUI.setupWithNavController(binding.navView, navController);

        loadUserProfile();
    }

    private void loadUserProfile(){

        final TextView usernameFill = findViewById(R.id.UsernameFill);
        final TextView emailFill = findViewById(R.id.EmailFill);
        final TextView nameFill = findViewById(R.id.NameFill);
        final TextView surnameFill = findViewById(R.id.SurnameFill);
        final TextView birthDateFill = findViewById(R.id.BirthDateFill);

        RequestQueue queue = Volley.newRequestQueue(this);
        String url ="http://10.0.2.2:3300/users/4";

        // Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        // Display the first 500 characters of the response string.
                        JSONArray json;

                        System.out.println(response);
                        try {
                            json = new JSONArray(response);

                            usernameFill.setText(json.getJSONObject(0).getString("username"));
                            emailFill.setText(json.getJSONObject(0).getString("email"));
                            nameFill.setText(json.getJSONObject(0).getString("name"));
                            surnameFill.setText(json.getJSONObject(0).getString("surname"));
                            birthDateFill.setText(json.getJSONObject(0).getString("birth_date"));

                        } catch (JSONException e) {
                            System.out.println("error JSON" + e.toString());
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                usernameFill.setText("That didn't work!");
            }
        });

        // Add the request to the RequestQueue.
        queue.add(stringRequest);

    }

}