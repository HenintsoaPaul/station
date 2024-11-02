<%-- 
    Document   : apresLiaisonMvtCaisse
    Created on : 29 août 2024, 11:58:17
    Author     : Estcepoire
--%>


<%@page import="caisse.MvtCaisse"%>
<%@page import="user.UserEJB"%>
<%
    try {
        UserEJB u = (UserEJB) session.getAttribute("u");
        String lien = (String) request.getParameter("lien");
        String idMvtCaisse = (String) request.getParameter("idMvtCaisse");
        String[] id = (String[]) request.getParameterValues("id");
        MvtCaisse mvtCaisse = new MvtCaisse();
        mvtCaisse.setId(idMvtCaisse);
        mvtCaisse.attacherPrevision(id, u.getUser().getTuppleID(), null);
        %>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=caisse/mvt/mvtCaisse-fiche.jsp&id=<%=idMvtCaisse%>");</script>

        <%
    } catch (Exception e) {
        e.printStackTrace();
%>
<script type="text/javascript">alert("<%=e.getMessage()%>");
        history.back();</script>
<%
    }
%>