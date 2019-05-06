<%-- 
    Document   : incl
    Created on : Dec 3, 2016, 8:22:21 PM
    Author     : benhur
--%>

<%@page import="javax.naming.Context"%>
<%@page import="com.ivo.ejb.LibraryStatefulBeanRemote"%>
<%@page import="com.ivo.ejb.LibraryStatelessBeanRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<html>
    <body>
        <%
            Properties props;
            InitialContext ctx;
            LibraryStatelessBeanRemote adm = null;
            LibraryStatefulBeanRemote usa = null;
            Properties jndiProps = new Properties();
            jndiProps.put(Context.INITIAL_CONTEXT_FACTORY,
                    "org.jboss.naming.remote.client.InitialContextFactory");

            jndiProps.put(Context.PROVIDER_URL, "http-remoting://127.0.0.1:8080");
            jndiProps.put("jboss.naming.client.ejb.context", true);
            ctx = new InitialContext(jndiProps);
        %>
    </body>
</html>
