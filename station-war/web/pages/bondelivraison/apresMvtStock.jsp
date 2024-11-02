


<%@page import="faturefournisseur.As_BonDeLivraison"%>
<%@page import="bean.CGenUtil"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.UtilDB"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
try{
        UserEJB u = (UserEJB)session.getAttribute("u");
        String lien = (String)session.getAttribute("lien");
        String bute = request.getParameter("bute");
        String id = request.getParameter("id");

        As_BonDeLivraison bl = new As_BonDeLivraison();
        bl.setId(id);        
        bl.genererMvtStockPersist(u.getUser().getTuppleID());
        bute = "bondelivraison/bondelivraison-fiche.jsp&id="+id;
             
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>");</script>
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