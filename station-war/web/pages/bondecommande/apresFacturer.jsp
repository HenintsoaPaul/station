<%-- 
    Document   : apresFacturer
    Created on : Aug 5, 2024, 3:28:57 PM
    Author     : dm
--%>



<%@page import="utils.ConstanteEtatStation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="faturefournisseur.As_BonDeCommande"%>
<%@page import="user.UserEJB"%>
<%@page import="user.UserEJBBean"%>
<%@page import="utilitaire.UtilDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
try{
        UserEJB u = (UserEJB)session.getAttribute("u");
        String lien = (String)session.getAttribute("lien");
        String acte = request.getParameter("acte");
        String bute = "facturefournisseur/facturefournisseur-modif.jsp";
        String type = request.getParameter("type");
        String nomtable=request.getParameter("nomtable");
        As_BonDeCommande v = new As_BonDeCommande();
        v.setId(request.getParameter("id"));
        String id = v.genererFacture(u.getUser().getTuppleID());  
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>");</script>
<%  
}catch (Exception e) {
        e.printStackTrace();
%>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
history.back();</script>
<%
        return;
} 
%>
