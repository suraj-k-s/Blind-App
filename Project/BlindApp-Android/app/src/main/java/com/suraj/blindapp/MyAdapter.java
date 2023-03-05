package com.suraj.blindapp;

import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.provider.AlarmClock;
import android.speech.tts.TextToSpeech;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.Locale;

public class MyAdapter extends RecyclerView.Adapter<MyAdapter.MyViewHolder> {

    String z[],y[],x[],w[],v[],u[];
    Context context;
    int i = 0;
    TextToSpeech textToSpeech;

    public MyAdapter(Context ct,String a[],String b[],String c[],String d[],String e[],String f[]){

        context=ct;
        z=a;
        y=b;
        x=c;
        w=d;
        v=e;
        u=f;

    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        LayoutInflater inflater= LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.design,parent,false);
        return new MyViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {


        holder.route.setText(z[position]);
        holder.bus.setText(y[position]);
        holder.from.setText(x[position]);
        holder.to.setText(w[position]);
        holder.ftime.setText(v[position]);
        holder.ttime.setText(u[position]);

        textToSpeech = new TextToSpeech(context, new TextToSpeech.OnInitListener() {
            @Override
            public void onInit(int i) {

                if (i == TextToSpeech.SUCCESS) {
                    int lang = textToSpeech.setLanguage(Locale.ENGLISH);
                }

            }
        });

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                i++;


                final Handler handler = new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                       if(i==1)
                       {
                           int speech = textToSpeech.speak("Bus is"+y[position]+"And Time is"+v[position]+"To Confirm Double Click Set Alaram", TextToSpeech.QUEUE_FLUSH, null);
                           Toast.makeText(context,y[position],Toast.LENGTH_LONG).show();
                       }else if(i==2)
                       {
                           String time = v[position];

                           String a = time.substring(0, time.length() - 3);
                           String b = time.substring(3, time.length() - 0);


                           int speech = textToSpeech.speak("Confirmed", TextToSpeech.QUEUE_FLUSH, null);
                           Toast.makeText(context,"Confirmed",Toast.LENGTH_LONG).show();

                           Intent intent = new Intent(AlarmClock.ACTION_SET_ALARM);
                           intent.putExtra(AlarmClock.EXTRA_HOUR,a);
                           intent.putExtra(AlarmClock.EXTRA_MINUTES,b);
                           context.startActivity(intent);


                       }
                       i=0;
                    }
                }, 500);
            }
        });

    }

    @Override
    public int getItemCount() {
        return z.length;
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {

        TextView route,bus,from,to,ftime,ttime;


        public MyViewHolder(@NonNull View itemView) {
            super(itemView);
            route =itemView.findViewById(R.id.route);
            bus =itemView.findViewById(R.id.bus);
            from =itemView.findViewById(R.id.from);
            to =itemView.findViewById(R.id.to);
            ftime =itemView.findViewById(R.id.ftime);
            ttime =itemView.findViewById(R.id.ttime);
        }
    }
}
