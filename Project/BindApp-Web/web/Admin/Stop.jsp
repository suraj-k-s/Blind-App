<%-- 
    Document   : Stop
    Created on : Jun 5, 2021, 6:34:08 PM
    Author     : HP
--%>

<%@page import="java.sql.ResultSet"%>
<jsp:useBean class="DB.ConnectionClass" id="con"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Location</title>
        <%@include file="Header.jsp" %>
    </head>

    <%

        if (request.getParameter("btn_save") != null) {

            String insQry = "insert into tbl_stop(route_id,location_id,stop_time,stop_number)values('" + request.getParameter("sel_route") + "','" + request.getParameter("sel_location") + "','" + request.getParameter("txt_time") + "','" + request.getParameter("txt_stop") + "')";
            if (con.executeCommand(insQry)) {
                response.sendRedirect("Stop.jsp");
            } else {
                System.out.println(insQry);
            }
        }

        if (request.getParameter("del") != null) {
            String delQry = "delete from tbl_stop where stop_id='" + request.getParameter("del") + "'";
            if (con.executeCommand(delQry)) {
                response.sendRedirect("Stop.jsp");
            }
        }


    %>
    <body>


        <section class="main_content dashboard_part">

            <!--/ menu  -->
            <div class="main_content_iner ">
                <div class="container-fluid p-0">
                    <div class="row justify-content-center">
                        <div class="col-12">
                            <div class="QA_section">
                                <!--Form-->
                                <div class="white_box_tittle list_header">
                                    <div class="col-lg-12">
                                        <div class="white_box mb_30">
                                            <div class="box_header ">
                                                <div class="main-title">
                                                    <h3 class="mb-0" >Table Stop</h3>
                                                </div>
                                            </div>
                                            <form>

                                                <div class="form-group">
                                                    <label for="sel_route">Select Route</label>
                                                    <select required="" class="form-control" name="sel_route" id="sel_route">
                                                        <option value="" >Select</option>
                                                        <%                                                            String disQry = "select * from tbl_route";
                                                            ResultSet rsz = con.selectCommand(disQry);
                                                            while (rsz.next()) {
                                                        %>
                                                        <option value="<%=rsz.getString("route_id")%>"><%=rsz.getString("route_name")%></option>
                                                        <%
                                                            }

                                                        %>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="sel_district">Select District</label>
                                                    <select required="" class="form-control" onchange="getPlace(this.value)" name="sel_district" id="sel_district">
                                                        <option value="" >Select</option>
                                                        <%                                                            String disQry1 = "select * from tbl_district";
                                                            ResultSet rs1 = con.selectCommand(disQry1);
                                                            while (rs1.next()) {
                                                        %>
                                                        <option value="<%=rs1.getString("district_id")%>"><%=rs1.getString("district_name")%></option>
                                                        <%
                                                            }

                                                        %>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="sel_location">Select Place</label>
                                                    <select required="" class="form-control" name="sel_location" id="sel_location">
                                                        <option value="" >Select</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txt_stop">Stop Number</label>
                                                    <input required="" type="number" class="form-control" id="txt_stop" name="txt_stop">
                                                </div>
                                                <div class="form-group">
                                                    <label for="txt_time">Required Time From Previous Stop</label>
                                                    <input required="" type="number" class="form-control" id="txt_time" name="txt_time">
                                                </div>
                                                <div class="form-group" align="center">
                                                    <input type="submit" class="btn-dark" name="btn_save" style="width:100px; border-radius: 10px 5px " value="Save">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                                <div class="QA_table mb_30">
                                    <!-- table-responsive -->
                                    <table class="table lms_table_active">
                                        <thead>
                                            <tr style="background-color: #74CBF9">
                                                <td align="center" scope="col">Sl.No</td>
                                                <td align="center" scope="col">Route</td>
                                                <td align="center" scope="col">Stop No</td>
                                                <td align="center" scope="col">Stop</td>
                                                <td align="center" scope="col">Time</td>
                                                <td align="center" scope="col">Action</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%                                                int i = 0;
                                                String selQry = "select * from tbl_stop s inner join tbl_route r on r.route_id=s.route_id inner join tbl_location l on l.location_id=s.location_id";
                                                ResultSet rs = con.selectCommand(selQry);
                                                while (rs.next()) {

                                                    i++;

                                            %>
                                            <tr>    
                                                <td align="center"><%=i%></td>
                                                <td align="center"><%=rs.getString("route_name")%></td>
                                                <td align="center"><%=rs.getString("stop_number")%></td>
                                                <td align="center"><%=rs.getString("Location_name")%></td>
                                                <td align="center"><%=rs.getString("stop_time")%> Min</td>
                                                <td align="center"> 
                                                    <a href="Stop.jsp?del=<%=rs.getString("stop_id")%>" class="status_btn">Delete</a>
                                                </td> 
                                            </tr>
                                            <%                      }


                                            %>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>
    </body>

    <script src="../Assets/JQuery/jQuery.js"></script>
    <script>
                                                        function getPlace(did)
                                                        {

                                                            $.ajax({
                                                                type: "POST",
                                                                data: {did: did},
                                                                url: "../Assets/AjaxPages/AjaxLocation.jsp",
                                                                success: function(result) {
                                                                    $("#sel_location").html(result);
                                                                }});
                                                        }
    </script>
    <%@include file="Footer.jsp" %>
</html>

