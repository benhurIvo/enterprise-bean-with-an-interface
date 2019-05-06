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
        <% adm = (LibraryStatelessBeanRemote) ctx.lookup("bookshop/LibraryStatelessBean!com.ivo.ejb.LibraryStatelessBeanRemote");
            List<Book> bks = adm.available();

            request.setAttribute("bks", bks);
            Uza u = (Uza) request.getSession(false).getAttribute("uz");
        %>
        <h3 style="text-align: center"><%out.println("Welcome " + u.getUname());%></h3>
        <form method="post" action="/addCart">
            <table style="border: solid;"><thead><h5>Books available</h5></thead>
                <tr><td>Book Name</td><td>Price</td></tr>
                <c:forEach var="temp" items="${requestScope.bks}" varStatus="cnt" begin="0">
                    <tr><td>
                            <c:out value="${temp.title}"></c:out>
                            </td>
                            <td>
                            <c:out value="${temp.price}"></c:out>
                            </td>
                            <td><input type="checkbox" name="c${cnt.count}" value="${temp.bid}"/></td>
                    </tr>
                </c:forEach>
                <input type="hidden" name="arSize" value="${fn:length(requestScope.bks)}" />
                <tr>
                    <td></td>
                    <td><input type="submit" value="Add to Cart"/></td>                     
                    <td></td>
                </tr>
            </table>
        </form>
        <form method="post" action="/viewCart"><input type="hidden" name="ct" value="view"/>
            <input type="submit" value="view Cart"/></form>
    </body>
</html>
