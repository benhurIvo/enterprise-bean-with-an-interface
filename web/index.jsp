<%-- 
    Document   : index
    Created on : Dec 2, 2016, 3:01:29 PM
    Author     : benhur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Benh's shop</title>
    </head>
    <body>
        <% request.getSession(false).removeAttribute("uz");
        request.getSession(false).removeAttribute("crt");
        %>
        <div style="text-align: center"
             <h3>Welcome to Benh's shop</h3>
        </div>
        <form method="post" action="/shop">
            <div style="padding: 25%;padding-top: 10%;">
                <table style="border: solid">
                    <thead>Login</thead>
                    <tr>
                        <td>Username</td>
                        <td><input type="text" name="un" id='un'/></td>
                    </tr>   
                    <tr>
                        <td>password</td>
                        <td><input type="password" name="pw" id='pw'/></td>
                    </tr>  
                    <tr>
                        <td><input type="reset" value="Reset"/></td>
                        <td><input type="submit" value="Submit"/></td>
                    </tr>  
                </table>
            </div>
        </form>
    </body>
</html>
