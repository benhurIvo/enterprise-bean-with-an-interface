<%-- 
    Document   : admin
    Created on : Dec 3, 2016, 4:50:16 PM
    Author     : benhur
--%>

<%@page import="com.ivo.entities.Uza"%>
<%@page import="com.ivo.entities.Cart"%>
<%@page import="com.ivo.entities.Book"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin</title>
    </head>
    <body>
        
        <%@include file="incl.jsp" %>
        
        <% adm = (LibraryStatelessBeanRemote) ctx.lookup("bookshop/LibraryStatelessBean!com.ivo.ejb.LibraryStatelessBeanRemote");
        List<Book> bks = adm.available();

            request.setAttribute("bks", bks);
            Uza u = (Uza) request.getSession(false).getAttribute("uz");
        %>
        <div style="padding-left: 25%;">
            <h3><%out.println("Welcome " + u.getUname());%></h3>
            <br><form method="post" action="/viewBook">
                <input type="hidden" name="pri"/>
                <input type="submit" value="View Bought"/>
            </form><br>
            <form method="post" action="/addBook">
                <table style="border: solid"><thead>Add Book</thead>
                    <tr>
                        <td>Title</td>
                        <td><input type="text" name="tit"/></td>
                    </tr>
                    <tr>
                        <td>Price</td>
                        <td><input type="text" name="pri"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Add Book"/></td>
                    </tr></table>
            </form>
            <br>
            <table style="border: solid"><thead>Books available</thead>
                <tr><td>Book Name</td><td>Price</td></tr>
                
                
                <c:forEach var="temp" items="${requestScope.bks}">
                    <tr><td>
                            <c:out value="${temp.title}"></c:out>
                            </td>
                            <td>
                            <c:out value="${temp.price}"></c:out>
                            </td></tr>
                    </c:forEach>
                    
            </table>
        </div>
    </body>
</html>
