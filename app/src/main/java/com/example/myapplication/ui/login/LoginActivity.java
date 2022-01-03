package com.example.myapplication.ui.login;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;

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
            String url = "http://10.0.2.2:3300/user/login";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    response -> {
                        //LOG IN CORRECT
                        //Open home activity
                        Intent intent = new Intent(v.getContext(), MainActivity.class);
                        try {
                            JSONObject r = new JSONObject(response);
                            String user_id = r.getString("id_user");
                            intent.putExtra("user_id", user_id);
                            startActivity(intent);
                        } catch (JSONException jsonException) {
                            jsonException.printStackTrace();
                        }
                    },
                    error -> {
                        //LOG IN FAILED
                        Toast.makeText(v.getContext(), "Login Failed", Toast.LENGTH_SHORT).show();
                    }
            ) {
                @Override
                public byte[] getBody() throws AuthFailureError {

                    Map<String, String>  params = new HashMap<String, String>();

                    params.put("email", e);
                    params.put("password", p);

                    return new JSONObject(params).toString().getBytes();
                }

                @Override
                public String getBodyContentType() {
                    return "application/json";
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