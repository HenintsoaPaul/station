


<%@page import="vente.As_BondeLivraisonClient"%>
<%@page import="bean.CGenUtil"%>
<%@page import="user.UserEJB"%>
<%@page import="utilitaire.UtilDB"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
Connection connection = null;
try{
        UserEJB u = (UserEJB)session.getAttribute("u");
        String lien = (String)session.getAttribute("lien");
        String bute = request.getParameter("bute");
        String id = request.getParameter("id");

        As_BondeLivraisonClient bl = new As_BondeLivraisonClient();
				bl.setId(id);
//        bl = (As_BondeLivraisonClient)bl.getById(id,bl.getNomTable(),null);
        
						bl.genererMvtStockPersist(u.getUser().getTuppleID());
            bute = "bondelivraison-client/bondelivraison-client-fiche.jsp&id="+id;
        
             
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