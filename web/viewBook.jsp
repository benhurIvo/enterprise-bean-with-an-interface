<%-- 
    Document   : viewBook
    Created on : Dec 4, 2016, 3:33:17 AM
    Author     : benhur
--%>

<%@page import="com.ivo.entities.Cart"%>
<%@page import="com.ivo.entities.Uza"%>
<%@page import="com.ivo.entities.Book"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>user</title>
    </head>
    <body>
        <%@include file="incl.jsp" %>
        <% adm = (LibraryStatelessBeanRemote) ctx.lookup("bookshop/LibraryStatelessBean!com.ivo.ejb.LibraryStatelessBeanRemote");
            List<Cart> ct = adm.bought();
            List<Book> bks = new ArrayList<>();
            for (Cart c : ct) {
                Book b = adm.getBook(c.getBid());
                bks.add(b);
            }

            request.setAttribute("bks", bks);
            Uza u = (Uza) request.getSession(false).getAttribute("uz");
        %>
        <h3><%out.println("Welcome " + u.getUname());%></h3>
        <br>
        <div style="padding-left: 25%;">
            <table style="border: solid"><thead>Books Bought</thead>
                <tr><td>Name</td><td>Price</td></tr>
                <c:forEach var="temp" items="${requestScope.bks}">
                    <tr><td>
                            <c:out value="${temp.title}"></c:out>
                            </td>
                            <td>
                            <c:out value="${temp.price}"></c:out>
                            </td></tr>
                    </c:forEach>
            </table>
            <form method="post" action="/shop"><input type="hidden" name="ct" value="view"/>
                <input type="submit" value="Back"/></form>
        </div>
    </body>
</html>
