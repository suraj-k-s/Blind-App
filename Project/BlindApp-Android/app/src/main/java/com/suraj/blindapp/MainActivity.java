package com.suraj.blindapp;

import android.app.ActivityManager;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.speech.RecognizerIntent;
import android.speech.tts.TextToSpeech;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.util.Timer;
import java.util.TimerTask;

public class MainActivity extends AppCompatActivity {

    private GpsTracker gpsTracker;
    RecyclerView recyclerView;
    String location, latitude, longitude, localTime;
    TextToSpeech textToSpeech;
    String route[], bus[], from[], to[], ftime[], ttime[];
    protected static final int RESULT_SPEECH = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        recyclerView = findViewById(R.id.rv);


        textToSpeech = new TextToSpeech(getApplicationContext(), new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int i) {

                if (i == TextToSpeech.SUCCESS) {
                    int lang = textToSpeech.setLanguage(Locale.ENGLISH);
                }

            }
        });


        if (Helper.isAppRunning(MainActivity.this, "com.suraj.blindapp")) {

// <-------------For Demo Purpose------------->

//            gpsTracker = new GpsTracker(MainActivity.this);
//            if (gpsTracker.canGetLocation()) {
//                latitude = String.valueOf(gpsTracker.getLatitude());
//                longitude = String.valueOf(gpsTracker.getLongitude());
//
//            } else {
//                gpsTracker.showSettingsAlert();
//            }
//
//            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("GMT+5:30"));
//            Date currentLocalTime = cal.getTime();
//            DateFormat date = new SimpleDateFormat("HH:mm");
//            date.setTimeZone(TimeZone.getTimeZone("GMT+5:30"));
//
//            localTime = date.format(currentLocalTime);
//
//            getDetails gd = new getDetails();
//
//            location = "Vazhakulam";
//
//            gd.execute(location, latitude, longitude, "09:00");

//<------------------End----------------->


            Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
            intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE, "en-US");
            try {

                startActivityForResult(intent, RESULT_SPEECH);
            } catch (ActivityNotFoundException ex) {
                Toast.makeText(MainActivity.this, "Your device doesn't support Speech to Text", Toast.LENGTH_LONG).show();
                ex.printStackTrace();
            }


        }

        try {
            if (ContextCompat.checkSelfPermission(getApplicationContext(), android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, 101);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case RESULT_SPEECH:
                if (requestCode == RESULT_SPEECH && data != null) {

                    ArrayList<String> text = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);


                    gpsTracker = new GpsTracker(MainActivity.this);
                    if (gpsTracker.canGetLocation()) {
                        latitude = String.valueOf(gpsTracker.getLatitude());
                        longitude = String.valueOf(gpsTracker.getLongitude());

                    } else {
                        gpsTracker.showSettingsAlert();
                    }

                    Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("GMT+5:30"));
                    Date currentLocalTime = cal.getTime();
                    DateFormat date = new SimpleDateFormat("HH:mm");
                    date.setTimeZone(TimeZone.getTimeZone("GMT+5:30"));

                    localTime = date.format(currentLocalTime);

                    getDetails gd = new getDetails();

                    location = text.get(0);

                    gd.execute(location, "10.0613595", "76.6150293", localTime);


//
//                    if(location.equals("Kothamangalam"))
//                    {
//                        route = getResources().getStringArray(R.array.route1);
//                        bus = getResources().getStringArray(R.array.bus1);
//                        from = getResources().getStringArray(R.array.from1);
//                        to = getResources().getStringArray(R.array.to1);
//                        ftime = getResources().getStringArray(R.array.ftime1);
//                        ttime = getResources().getStringArray(R.array.ttime1);
//
//                        MyAdapter myAdapter = new MyAdapter(MainActivity.this,route,bus,from,to,ftime,ttime);
//
//                        recyclerView.setAdapter(myAdapter);
//                        recyclerView.setLayoutManager(new LinearLayoutManager(MainActivity.this));
//                    }
//                    else if(location.equals("Aluva"))
//                    {
//                        route = getResources().getStringArray(R.array.route2);
//                        bus = getResources().getStringArray(R.array.bus2);
//                        from = getResources().getStringArray(R.array.from2);
//                        to = getResources().getStringArray(R.array.to2);
//                        ftime = getResources().getStringArray(R.array.ftime2);
//                        ttime = getResources().getStringArray(R.array.ttime2);
//
//                        MyAdapter myAdapter = new MyAdapter(MainActivity.this,route,bus,from,to,ftime,ttime);
//
//                        recyclerView.setAdapter(myAdapter);
//                        recyclerView.setLayoutManager(new LinearLayoutManager(MainActivity.this));
//                    }
//                    else if(location.equals("Perumbavoor"))
//                    {
//                        route = getResources().getStringArray(R.array.route3);
//                        bus = getResources().getStringArray(R.array.bus3);
//                        from = getResources().getStringArray(R.array.from3);
//                        to = getResources().getStringArray(R.array.to3);
//                        ftime = getResources().getStringArray(R.array.ftime3);
//                        ttime = getResources().getStringArray(R.array.ttime3);
//
//                        MyAdapter myAdapter = new MyAdapter(MainActivity.this,route,bus,from,to,ftime,ttime);
//
//                        recyclerView.setAdapter(myAdapter);
//                        recyclerView.setLayoutManager(new LinearLayoutManager(MainActivity.this));
//                    }
//                    else if(location.equals("Adimali"))
//                    {
//                        route = getResources().getStringArray(R.array.route4);
//                        bus = getResources().getStringArray(R.array.bus4);
//                        from = getResources().getStringArray(R.array.from4);
//                        to = getResources().getStringArray(R.array.to4);
//                        ftime = getResources().getStringArray(R.array.ftime4);
//                        ttime = getResources().getStringArray(R.array.ttime4);
//
//                        MyAdapter myAdapter = new MyAdapter(MainActivity.this,route,bus,from,to,ftime,ttime);
//
//                        recyclerView.setAdapter(myAdapter);
//                        recyclerView.setLayoutManager(new LinearLayoutManager(MainActivity.this));
//                    }
//                    else
//                    {
//                        int speech = textToSpeech.speak("No Data Found Try Again", TextToSpeech.QUEUE_FLUSH, null);
//                        Toast.makeText(MainActivity.this, "No Data Found", Toast.LENGTH_LONG).show();
//                        Intent i=new Intent(MainActivity.this,HomePage.class);
//                        startActivity(i);
//                    }

                }
                break;
        }
    }


    public class getDetails extends AsyncTask<String, String, String> {


        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wb = new WebServiceCaller();
            wb.setSoapObject("getDetails");
            wb.addProperty("location", strings[0]);
            wb.addProperty("latitude", strings[1]);
            wb.addProperty("longitude", strings[2]);
            wb.addProperty("time", strings[3]);
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
                    route = new String[j.length()];
                    bus = new String[j.length()];
                    from = new String[j.length()];
                    to = new String[j.length()];
                    ftime = new String[j.length()];
                    ttime = new String[j.length()];

                    for (int i = 0; i < j.length(); i++) {
                        JSONObject jo = j.getJSONObject(i);
                        route[i] = jo.getString("route");
                        bus[i] = jo.getString("bus");
                        from[i] = jo.getString("from");
                        to[i] = jo.getString("to");
                        ftime[i] = jo.getString("ftime");
                        ttime[i] = jo.getString("ttime");
                    }

                    MyAdapter myAdapter = new MyAdapter(MainActivity.this, route, bus, from, to, ftime, ttime);

                    recyclerView.setAdapter(myAdapter);
                    recyclerView.setLayoutManager(new LinearLayoutManager(MainActivity.this));


                } catch (JSONException e) {
                    e.printStackTrace();
                }

            } else {

                Toast.makeText(MainActivity.this, "Faild", Toast.LENGTH_SHORT).show();

            }
        }
    }

    public static class Helper {

        public static boolean isAppRunning(final Context context, final String packageName) {
            final ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
            final List<ActivityManager.RunningAppProcessInfo> procInfos = activityManager.getRunningAppProcesses();
            if (procInfos != null) {
                for (final ActivityManager.RunningAppProcessInfo processInfo : procInfos) {
                    if (processInfo.processName.equals(packageName)) {
                        return true;
                    }
                }
            }
            return false;
        }
    }
}