

<%@page import="utils.ConstanteEtatStation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="vente.Vente"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.UtilDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

try{
        UserEJB u = (UserEJB)session.getAttribute("u");
        String lien = (String)session.getAttribute("lien");
        String bute = request.getParameter("bute");
        String idVente = request.getParameter("idVente");
        String[] ids = request.getParameterValues("id");

        System.out.println("idVente: " + idVente);
        System.out.println("ids: " + ids);

        if (idVente != null) {
                Vente vente = new Vente();
                vente.setId(idVente);
                vente.lierLivraisons(u.getUser().getTuppleID(), ids);
        }else{
            Vente vente = new Vente();
            vente.genererAPartirLivraison(ids, u.getUser().getTuppleID(), null);
            bute = "station-ejb/src/java/vente/vente-modif.jsp&id=" +vente.getId();
        }
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
} %>
