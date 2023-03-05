<%-- 
    Document   : Route
    Created on : Jun 5, 2021, 6:34:00 PM
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

            String insQry = "insert into tbl_route(route_name,location_from,location_to,route_time)values('" + request.getParameter("txt_route") + "','" + request.getParameter("sel_location1") + "','" + request.getParameter("sel_location2") + "','" + request.getParameter("txt_time") + "')";
            if (con.executeCommand(insQry)) {
                response.sendRedirect("Route.jsp");
            } else {
                System.out.println(insQry);
            }
        }

        if (request.getParameter("del") != null) {
            String delQry = "delete from tbl_route where route_id='" + request.getParameter("del") + "'";
            if (con.executeCommand(delQry)) {
                response.sendRedirect("Route.jsp");
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
                                                    <h3 class="mb-0" >Table Route</h3>
                                                </div>
                                            </div>
                                            <form>

                                                <div class="form-group">
                                                    <label for="txt_route">Route Name</label>
                                                    <input required="" type="text" class="form-control" id="txt_route" name="txt_route">
                                                </div>
                                                <div class="form-group">
                                                    <label for="txt_time">Required Name</label>
                                                    <input required="" type="number" class="form-control" id="txt_time" name="txt_time">
                                                </div>
                                                <div class="form-group">
                                                    <br>
                                                    <h3 class="mb-0" align="center" >Starting Location</h3>
                                                    <br>
                                                    <label for="sel_district1">Select District</label>
                                                    <select required="" class="form-control" onchange="getPlace1(this.value)" name="sel_district1" id="sel_district1">
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
                                                    <label for="sel_location1">Select Place</label>
                                                    <select required="" class="form-control" name="sel_location1" id="sel_location1">
                                                        <option value="" >Select</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <br>
                                                    <h3 class="mb-0" align="center" >End Location</h3>
                                                    <br>
                                                    <label for="sel_district2">Select District</label>
                                                    <select required="" class="form-control" onchange="getPlace2(this.value)" name="sel_district2" id="sel_district2">
                                                        <option value="" >Select</option>
                                                        <%                                                            String disQry2 = "select * from tbl_district";
                                                            ResultSet rs2 = con.selectCommand(disQry2);
                                                            while (rs2.next()) {
                                                        %>
                                                        <option value="<%=rs2.getString("district_id")%>"><%=rs2.getString("district_name")%></option>
                                                        <%
                                                            }

                                                        %>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <label for="sel_location2">Select Place</label>
                                                    <select required="" class="form-control" name="sel_location2" id="sel_location2">
                                                        <option value="" >Select</option>
                                                    </select>
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
                                                <td align="center" scope="col">Time</td>
                                                <td align="center" scope="col">From</td>
                                                <td align="center" scope="col">To</td>
                                                <td align="center" scope="col">Action</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%                                                int i = 0;
                                                String selQry = "select * from tbl_route";
                                                ResultSet rs = con.selectCommand(selQry);
                                                while (rs.next()) {
                                                    String selQry1 = "select * from tbl_location where location_id='" + rs.getString("location_from") + "'";
                                                    ResultSet rsi = con.selectCommand(selQry1);
                                                    String selQry2 = "select * from tbl_location where location_id='" + rs.getString("location_to") + "'";
                                                    ResultSet rsj = con.selectCommand(selQry2);

                                                    i++;

                                            %>
                                            <tr>    
                                                <td align="center"><%=i%></td>
                                                <td align="center"><%=rs.getString("route_name")%></td>
                                                <td align="center"><%=rs.getString("route_time")%> Min</td>
                                                <td align="center"><%if (rsi.next()) {out.println(rsi.getString("location_name"));}%></td>
                                                <td align="center"><%if (rsj.next()) {out.println(rsj.getString("location_name"));}%></td>
                                                <td align="center"> 
                                                    <a href="Route.jsp?del=<%=rs.getString("route_id")%>" class="status_btn">Delete</a>
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
                                                        function getPlace1(did1)
                                                        {

                                                            $.ajax({
                                                                type: "POST",
                                                                data: {did: did1},
                                                                url: "../Assets/AjaxPages/AjaxLocation.jsp",
                                                                success: function(result) {
                                                                    $("#sel_location1").html(result);
                                                                }});
                                                        }
                                                        function getPlace2(did2)
                                                        {
                                                            var id = document.getElementById("sel_location1").value;

                                                            $.ajax({
                                                                type: "POST",
                                                                data: {did: did2, id: id},
                                                                url: "../Assets/AjaxPages/AjaxLocation2.jsp",
                                                                success: function(result) {

                                                                    $("#sel_location2").html(result);
                                                                }});
                                                        }
    </script>
    <%@include file="Footer.jsp" %>
</html>

