

<%@page import="avoir.AvoirFC"%>
<%@page import="vente.Vente"%>
<%@page import="vente.Vente"%>
<%@page import="utils.ConstanteEtatStation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="vente.BonDeCommande"%>
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
        String bute = "station-ejb/src/java/avoir/avoirFC-modif.jsp";
        String type = request.getParameter("type");
        String nomtable=request.getParameter("nomtable");

        AvoirFC avoirFc = Vente.genererAvoir(u.getUser().getTuppleID(), null, request.getParameter("idvente"));
        String idAvoicFC = avoirFc.getId();
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=idAvoicFC%>");</script>
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
