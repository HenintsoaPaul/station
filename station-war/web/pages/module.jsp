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
        if (request.getParameter("langue") != null) {
            session.setAttribute("langue", (String) request.getParameter("langue"));
        }
        langue = (String) session.getAttribute("langue");
%>
<%@include file="security-login.jsp"%>
<%    if (session.getAttribute("lien") != null) {
        lien = (String) session.getAttribute("lien");
    }
    if (request.getParameter("idmenu") != null) {
        session.setAttribute("lien", lien);
        session.setAttribute("menu", (String) request.getParameter("idmenu"));
    }
    if ((request.getParameter("but") != null) && session.getAttribute("u") != null) {
        but = request.getParameter("but");
    } else {%>
<script language="JavaScript">
    alert("Veuillez vous connecter pour acceder a ce contenu");
    document.location.replace("${pageContext.request.contextPath}/index.jsp");
</script>
<% }
%>

<!DOCTYPE html>
<html>
    <head>
        <!--<meta charset="UTF-8">-->
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-15">
        <title>ERP-Prospection</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='elements/css.jsp'/>
    </head>
    <body class="skin-yellow-light sidebar-mini">
        <!-- Site wrapper -->
        <div class="wrapper" style="max-width:none !important;">
            <!-- Header -->
            <jsp:include page='elements/header.jsp'/>
            <!-- =============================================== -->
            <!-- Menu Gauche -->
            <jsp:include page='elements/menu/module.jsp'/>
            <!-- =============================================== -->
            <!-- Content -->
            <% try {%>
            <jsp:include page='<%=but%>'/>
            <% } catch (Exception e) {%>
            <script language="JavaScript"> alert('<%=e.getMessage().toUpperCase()%>');
                history.back();</script>
                <%
                    }
                %>
            <!-- =============================================== -->
            <!-- Footer -->
            <jsp:include page='elements/footer.jsp'/>
            <!-- =============================================== -->
            <!-- Panel -->
            <jsp:include page='elements/panel.jsp'/>
            <!-- =============================================== -->
        </div>
        <!-- ./wrapper -->
        <jsp:include page='elements/js.jsp'/>
        <script>
            <%
                UserEJB user = (UserEJB) request.getSession().getAttribute("u");
            %>
            runWScommunication('<%=user.getUser().getTuppleID()%>');
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
        out.println("<script language='JavaScript'> document.location.replace('/cnaps-war/');</script>");
    }
%>