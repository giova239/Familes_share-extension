package com.example.myapplication.ui.login;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.example.myapplication.MainActivity;
import com.example.myapplication.R;

import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class RegistrationActivity extends AppCompatActivity {

    final private Calendar myCalendar= Calendar.getInstance();
    private EditText birthDate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registration);

        this.birthDate = findViewById(R.id.enterSignUpBirthDate);
        DatePickerDialog.OnDateSetListener date =new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int month, int day) {
                myCalendar.set(Calendar.YEAR, year);
                myCalendar.set(Calendar.MONTH,month);
                myCalendar.set(Calendar.DAY_OF_MONTH,day);
                updateLabel();
            }
        };
        this.birthDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new DatePickerDialog(RegistrationActivity.this,date,myCalendar.get(Calendar.YEAR),myCalendar.get(Calendar.MONTH),myCalendar.get(Calendar.DAY_OF_MONTH)).show();
            }
        });


        Button register = findViewById(R.id.registerButton);
        EditText name = findViewById(R.id.enterSignUpName);
        EditText surname = findViewById(R.id.enterSignUpSurname);
        EditText email = findViewById(R.id.enterSignUpEmail);
        EditText birthdate = findViewById(R.id.enterSignUpBirthDate);
        EditText password = findViewById(R.id.enterSignUpPassword);
        EditText confirmPassword = findViewById(R.id.enterSignUpConfirmPassword);

        register.setOnClickListener(v -> {

            String n = name.getText().toString();
            String s = surname.getText().toString();
            String e = email.getText().toString();
            String b = birthdate.getText().toString();
            String p = password.getText().toString();
            String c = confirmPassword.getText().toString();

            RequestQueue queue = Volley.newRequestQueue(this);
            String url = "http://10.0.2.2:3300/user/register";

            StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                    new Response.Listener<String>()
                    {
                        @Override
                        public void onResponse(String response) {
                            // response
                            System.out.println("Response:" + response);

                            //Close Registration activity
                            Toast.makeText(v.getContext(), "Registration Successful", Toast.LENGTH_SHORT).show();
                            Activity a = (Activity) v.getContext();
                            a.finish();
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
                public byte[] getBody() throws AuthFailureError {

                    Map<String, String>  params = new HashMap<String, String>();

                    params.put("name", n);
                    params.put("surname", s);
                    params.put("email", e);
                    params.put("birth_date", b);
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

    }

    private void updateLabel(){
        String myFormat="dd/MM/yyyy";
        SimpleDateFormat dateFormat=new SimpleDateFormat(myFormat, Locale.US);
        this.birthDate.setText(dateFormat.format(myCalendar.getTime()));
    }
}