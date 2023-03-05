<%-- 
    Document   : Schedule
    Created on : Jun 5, 2021, 6:34:19 PM
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

            String insQry = "insert into tbl_schedule(route_id,bus_name,schedule_time)values('" + request.getParameter("sel_route") + "','" + request.getParameter("txt_name") + "','" + request.getParameter("txt_time") + "')";
            if (con.executeCommand(insQry)) {
                response.sendRedirect("Schedule.jsp");
            } else {
                System.out.println(insQry);
            }
        }

        if (request.getParameter("del") != null) {
            String delQry = "delete from tbl_schedule where schedule_id='" + request.getParameter("del") + "'";
            if (con.executeCommand(delQry)) {
                response.sendRedirect("Schedule.jsp");
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
                                                    <h3 class="mb-0" >Table Schedule </h3>
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
                                                    <label for="txt_name">Bus Name</label>
                                                    <input type="text" name="txt_name" class="form-control"> 
                                                </div>

                                                <div class="form-group">
                                                    <label for="txt_time">Starting Time</label>
                                                    <input required="" type="time" class="form-control" id="txt_time" name="txt_time">
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
                                                <td align="center" scope="col">Bus</td>
                                                <td align="center" scope="col">Time</td>
                                                <td align="center" scope="col">Action</td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%                                                int i = 0;
                                                String selQry = "select * from tbl_schedule s inner join tbl_route r on r.route_id=s.route_id ";
                                                ResultSet rs = con.selectCommand(selQry);
                                                while (rs.next()) {
                                                    
                                                    i++;

                                            %>
                                            <tr>    
                                                <td align="center"><%=i%></td>
                                                <td align="center"><%=rs.getString("route_name")%></td>
                                                <td align="center"><%=rs.getString("bus_name")%></td>
                                                <td align="center"><%=rs.getString("schedule_time")%> Min</td>
                                                <td align="center"> 
                                                    <a href="Schedule.jsp?del=<%=rs.getString("schedule_id")%>" class="status_btn">Delete</a>
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

