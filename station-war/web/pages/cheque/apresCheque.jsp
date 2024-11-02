<%-- 
    Document   : apresCheque
    Created on : 26 mars 2024, 14:36:53
    Author     : 26134
--%>

<%@page import="utils.ConstanteEtatStation"%>
<%@page import="bean.CGenUtil"%>
<%@page import="cheque.Cheque"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
try{
        UserEJB u = (UserEJB)session.getAttribute("u");;
        String lien = (String)session.getAttribute("lien");
        String acte = request.getParameter("acte");
        String bute = request.getParameter("bute");
        String type = request.getParameter("type");
        String nomtable=request.getParameter("nomtable");
        String id = request.getParameter("id");
    if (acte.compareToIgnoreCase("toucherCheque") == 0) {
        Cheque[] chq=(Cheque[])CGenUtil.rechercher(new Cheque(), null, null, " and id='"+id+"' ");
        if (chq.length==0) {
                throw new Exception("cheque introuvable");
        }
        chq[0].setEtat(ConstanteEtatStation.getEtatTouche());
        u.updateObject(chq[0]);
%>
        <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute%>&id=<%=id%>");</script>
<%  
    }
}catch (Exception e) {
        e.printStackTrace();
%>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
history.back();</script>
<%
        return;
}
%>