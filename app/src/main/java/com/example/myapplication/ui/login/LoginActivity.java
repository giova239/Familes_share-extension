package com.example.myapplication.ui.login;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.FragmentTransaction;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;
import com.example.myapplication.ui.home.AnnouncementFragment;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class LoginActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        Button login = findViewById(R.id.loginButton);
        Button register = findViewById(R.id.registerInsteadButton);
        EditText email = findViewById(R.id.enterEmail);
        EditText password = findViewById(R.id.enterPassword);

        login.setOnClickListener(v -> {

            String e = email.getText().toString();
            String p = password.getText().toString();

            RequestQueue queue = Volley.newRequestQueue(this);
            String url = "http://10.0.2.2:3300/login";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    new Response.Listener<String>()
                    {
                        @Override
                        public void onResponse(String response) {
                            // response
                            System.out.println("Response:" + response);

                            //Open home activity
                            Intent intent = new Intent(v.getContext(), MainActivity.class);
                            startActivity(intent);

                        }
                    },
                    new Response.ErrorListener()
                    {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            // error
                            System.out.println("Error Response: " + error);
                            Toast.makeText(v.getContext(), "Error 404", Toast.LENGTH_SHORT).show();
                        }
                    }
            ) {
                @Override
                protected Map<String, String> getParams()
                {
                    Map<String, String>  params = new HashMap<String, String>();

                    params.put("email", e);
                    params.put("password", p);

                    return params;
                }
            };
            queue.add(postRequest);

        });

        register.setOnClickListener(v -> {

            //Open registration activity
            Intent intent = new Intent(this, RegistrationActivity.class);
            startActivity(intent);

        });

    }

}