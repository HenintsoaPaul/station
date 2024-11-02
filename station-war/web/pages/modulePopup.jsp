<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="javax.ejb.ConcurrentAccessTimeoutException"%>
<%@page import="user.UserEJB"%>
<%@ page import="utilitaire.*" %>

<%
    try {

        String but = "index.jsp";
        String lien = "module.jsp";
        String lienContenu = "index.jsp";
        String menu = "elements/menu/";
        String langue = "";
%>
<%    
    if ((request.getParameter("but") != null) && session.getAttribute("u") != null) {
        but = request.getParameter("but");
    } else {%>
<script language="JavaScript">
    alert("Veuillez vous connecter pour acceder a ce contenu");
</script>
<% }
%>

<!DOCTYPE html>
<html>
    <head>
        <!--<meta charset="UTF-8">-->
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15">
        <title>APPLICATION NAME</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='elements/css.jsp'/>
    </head>
    
    <body>
        <!-- Site wrapper -->
        <!-- Header -->
            <% try {%>
            <div class="container-apj">
                 <jsp:include page='<%=but%>'/>
            </div>
           
            <% } catch (Exception e) {%>
            <script language="JavaScript"> alert('<%=e.getMessage().toUpperCase()%>');
                </script>
                <%
                    }
                %>
        <!-- ./wrapper -->
        <jsp:include page='elements/js.jsp'/>
        <script>
            <%
                UserEJB user = (UserEJB) request.getSession().getAttribute("u");
            %>
        </script>
        <script src="${pageContext.request.contextPath}/apjplugins/champcalcul.js" defer></script>      
        <script src="${pageContext.request.contextPath}/apjplugins/champdate.js" defer></script>      
        <script src="${pageContext.request.contextPath}/apjplugins/champautocomplete.js" defer></script>      
        <script src="${pageContext.request.contextPath}/apjplugins/addLine.js" defer></script>  
    </body>
    <script>
    </script>
</html>
<%
    } catch (ConcurrentAccessTimeoutException e) {
    }
%>