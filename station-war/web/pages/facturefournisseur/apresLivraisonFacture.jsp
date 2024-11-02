<%-- 
    Document   : apresLivraisonFacture
    Created on : 5 août 2024, 10:50:05
    Author     : Mirado
--%>

<%@page import="utils.ConstanteEtatStation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="faturefournisseur.*"%>
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
        String type = request.getParameter("type");
        String nomtable=request.getParameter("nomtable");

        FactureFournisseur v = new FactureFournisseur();
        v.setId(request.getParameter("id"));
        String id = v.genererLivraison(u.getUser().getTuppleID(),null);  
        String bute = "bondelivraison/bondelivraison-modif.jsp&id="+id;
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>");</script>
<%  
}catch (Exception e) {
        e.printStackTrace();
%>

    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<%
        
}
%>
