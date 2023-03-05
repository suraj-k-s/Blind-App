/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WS;

import DB.ConnectionClass;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author HP
 */
@WebService(serviceName = "NewWebService")
public class NewWebService {

    ConnectionClass con = new ConnectionClass();

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getDetails")
    public String getDetails(@WebParam(name = "location") String location, @WebParam(name = "latitude") String latitude, @WebParam(name = "time") String time, @WebParam(name = "longitude") String longitude) {

        String selQry = "SELECT r1.route_name as route,s.schedule_time as stime,s.bus_name as bus,l1.location_name as froml,l2.location_name as tol,s1.stop_time as st1,s2.stop_time as st2 "
                + "FROM tbl_schedule s inner join  tbl_route r1 on s.route_id=r1.route_id "
                + "inner JOIN tbl_stop s1 ON (s1.route_id = r1.route_id) "
                + "inner JOIN tbl_location l1 ON (s1.location_id = l1.location_id) "
                + "inner JOIN tbl_stop s2 ON (s2.route_id = r1.route_id) "
                + "inner JOIN tbl_location l2 ON (s2.location_id = l2.location_id) "
                + "where l1.location_latitude  = '" + latitude + "' and l1.location_longitude = '" + longitude + "' "
                + "and l2.location_name = '" + location + "' and s1.stop_number < s2.stop_number and schedule_time > '" + time + "' ;";

        System.out.println(selQry);
        System.out.println("Latitude : " + latitude);
        System.out.println("Longitude : " + longitude);
        System.out.println("Location : " + location);

        ResultSet rs = con.selectCommand(selQry);

        JSONArray j = new JSONArray();
        {
            try {
                while (rs.next()) {
                    JSONObject jo = new JSONObject();
                    {
                        try {

                            String stime = rs.getString("stime");
                            int st1 = Integer.parseInt(rs.getString("st1"));
                            int st2 = Integer.parseInt(rs.getString("st1"));

                            String a = stime.substring(0, stime.length() - 2);
                            int b = Integer.parseInt(stime.substring(3, stime.length()));

                            String ftime = String.valueOf(a+(st1+b));
                            String ttime = String.valueOf(a+((st1+st2)+b));

                            jo.put("route", rs.getString("route"));
                            jo.put("bus", rs.getString("bus"));
                            jo.put("from", rs.getString("froml"));
                            jo.put("to", rs.getString("tol"));
                            jo.put("ftime", ftime);
                            jo.put("ttime", ttime);
                            j.put(jo);
                        } catch (JSONException ex) {
                            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return j.toString();
    }
    /**
     * Web service operation
     */
    @WebMethod(operationName = "getData")
    public String getData(@WebParam(name = "latitude") String latitude, @WebParam(name = "longitude") String longitude) {

        String selQry = "SELECT * from tbl_location where location_latitude  = '" + latitude + "' and location_longitude = '" + longitude + "' ";

        System.out.println(selQry);
        System.out.println("Latitude : " + latitude);
        System.out.println("Longitude : " + longitude);

        ResultSet rs = con.selectCommand(selQry);

        JSONArray j = new JSONArray();
        {
            try {
                while (rs.next()) {
                    JSONObject jo = new JSONObject();
                    {
                        try {
                            jo.put("location", rs.getString("location_name"));
                            j.put(jo);
                        } catch (JSONException ex) {
                            Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(NewWebService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return j.toString();
    }
}
