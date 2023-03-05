<%-- 
    Document   : test
    Created on : Jun 12, 2021, 10:20:07 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        
        String stime = "10:10";
                            int st1 = 10;
                            int st2 = 15;

                            String a = stime.substring(3, stime.length() - 0);
                            
                            out.println(a);
                            
        
        %>
    </body>
</html>
