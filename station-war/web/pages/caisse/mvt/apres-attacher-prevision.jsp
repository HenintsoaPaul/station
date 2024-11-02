<%-- 
    Document   : apres-attacher-prevision
    Created on : 16 ao�t 2024, 15:51:28
    Author     : Estcepoire
--%>


<%@page import="user.UserEJB"%>
<%@page import="prevision.PrevisionComplet"%>
<%
    try {
        UserEJB u = (UserEJB) session.getAttribute("u");
        String lien = (String) request.getParameter("lien");
        String id = (String) request.getParameter("idPrevision");
        PrevisionComplet prevision = new PrevisionComplet();
        System.out.println(id);
        prevision.setId(id);
        String[] ids = request.getParameterValues("id");
        prevision.attacherFacture(ids, u.getUser().getTuppleID(), null);
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=prevision/prevision-fiche.jsp&valeur=&id=<%=id%>");</script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>