<%-- 
    Document   : admin
    Created on : Dec 3, 2016, 4:50:16 PM
    Author     : benhur
--%>

<%@page import="com.ivo.entities.Uza"%>
<%@page import="com.ivo.entities.Book"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>user</title>
    </head>
    <body>
        <%@include file="incl.jsp" %>
        <% Uza u = (Uza) request.getSession(false).getAttribute("uz");
        %>
        <h3 style="text-align: center"><%out.println("Welcome " + u.getUname());%></h3>
        <form method="post" action="/buy">
            <table style="border: solid;"><thead><h5>Books in Cart</h5></thead>
                <tr><td>Book Name</td><td>Price</td></tr>
                <c:forEach var="temp" items="${sessionScope.crt}" varStatus="cnt" begin="0">
                    <tr><td>
                            <c:out value="${temp.title}"></c:out>
                            </td>
                            <td>
                            <c:out value="${temp.price}"></c:out>
                            </td>
                            </tr>
                </c:forEach>
                <input type="hidden" name="arSize" value="${fn:length(sessionScope.crt)}" />
                <tr>
                    <td></td>
                    <td><input type="submit" value="Buy"/></td>                     
                    <td></td>
                </tr>
            </table>
        </form>
        <form method="post" action="/shop"><input type="hidden" name="ct" value="view"/>
            <input type="submit" value="Back"/></form>
    </body>
</html>
