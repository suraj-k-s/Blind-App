package com.suraj.blindapp;

import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.LinearLayoutManager;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.speech.tts.TextToSpeech;
import android.view.View;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class HomePage extends AppCompatActivity {

    CardView cv1, cv2;
    int i = 0;
    private GpsTracker gpsTracker;
    String latitude, longitude;
    TextToSpeech textToSpeech;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_page);


        cv1 = findViewById(R.id.cv1);
        cv2 = findViewById(R.id.cv2);


        textToSpeech = new TextToSpeech(getApplicationContext(), new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int i) {

                if (i == TextToSpeech.SUCCESS) {
                    int lang = textToSpeech.setLanguage(Locale.ENGLISH);
                }

            }
        });


        cv1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//
//                gpsTracker = new GpsTracker(HomePage.this);
//                if (gpsTracker.canGetLocation()) {
//                    latitude = String.valueOf(gpsTracker.getLatitude());
//                    longitude = String.valueOf(gpsTracker.getLongitude());
//
//                } else {
//                    gpsTracker.showSettingsAlert();
//                }
//
//                getData gd = new getData();
//                gd.execute(latitude, longitude);

                int speech = textToSpeech.speak("Kottappadi", TextToSpeech.QUEUE_FLUSH, null);


            }
        });


        cv2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                i++;


                final Handler handler = new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        if (i == 1) {
                            int speech = textToSpeech.speak("You Clicked Find My Bus To Confirm Double Click", TextToSpeech.QUEUE_FLUSH, null);
                            Toast.makeText(HomePage.this, "Find Bus", Toast.LENGTH_LONG).show();
                        } else if (i == 2) {
                            //int speech = textToSpeech.speak("After Beep Sound Input Your Destination", TextToSpeech.QUEUE_FLUSH, null);
                            Toast.makeText(HomePage.this, "Find Bus Confirmed", Toast.LENGTH_LONG).show();
                            Intent i=new Intent(HomePage.this,MainActivity.class);
                            startActivity(i);
                        }
                        i = 0;
                    }
                }, 500);

            }
        });


    }

    public class getData extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("getData");
            wb.addProperty("latitude", strings[0]);
            wb.addProperty("longitude", strings[1]);
            wb.callWebService();
            return wb.getResponse();

        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);

            if (!s.equals("[]")) {
                JSONArray j = null;
                try {


                    j = new JSONArray(s);
                    JSONObject jo = j.getJSONObject(0);
                    String location = jo.getString("location");
                    int speech = textToSpeech.speak(location, TextToSpeech.QUEUE_FLUSH, null);
                    Toast.makeText(HomePage.this, location, Toast.LENGTH_SHORT).show();


                } catch (JSONException e) {
                    e.printStackTrace();
                }


            } else {
                Toast.makeText(HomePage.this, "faild", Toast.LENGTH_SHORT).show();

            }
        }
    }
}