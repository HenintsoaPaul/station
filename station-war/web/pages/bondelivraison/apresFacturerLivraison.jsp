

<%@page import="utils.ConstanteEtatStation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="faturefournisseur.FactureFournisseur"%>
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
        String idFactureFournisseur = request.getParameter("idFactureFournisseur");
        String[] ids = request.getParameterValues("id");

        System.out.println("idFactureFournisseur: " + idFactureFournisseur);
        System.out.println("ids: " + ids);

        if (idFactureFournisseur != null) {
                FactureFournisseur fact = new FactureFournisseur();
                fact.setId(idFactureFournisseur);
                fact.lierLivraisons(u.getUser().getTuppleID(), ids);
        }else{
            FactureFournisseur fact = new FactureFournisseur();
            fact.genererAPartirLivraison(ids, u.getUser().getTuppleID(), null);
            bute = "facturefournisseur/facturefournisseur-modif.jsp&id="+fact.getId();
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