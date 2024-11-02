<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="historique.MapUtilisateur"%>

<%@page import="java.util.*"%>

<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<%@ page import="vente.*" %>
<%@ page import="prevision.Prevision" %>
<%@ page import="prevision.MereFictif" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
        String nomtable = null;
        String action = null;
        String[] tId;
    %>
    <%
        try {
            nomtable = request.getParameter("nomtable");
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");
            action = request.getParameter("action");
            String classe = request.getParameter("classe");

            String idmere = request.getParameter("idmere");
            String classefille = request.getParameter("classefille");
            String colonneMere = request.getParameter("colonneMere");
            String nombreDeLigne = request.getParameter("nombreLigne");
            String classeMere = request.getParameter("classeMere");
            String  table = request.getParameter("table");
            ClassMAPTable mere = null;
            Prevision fille = null;
            
            int nbLine = Utilitaire.stringToInt(nombreDeLigne);
            tId = request.getParameterValues("id");
        if (acte != null && acte.compareToIgnoreCase("insertFille") == 0) {
                mere = (ClassMAPTable) (Class.forName(classeMere).newInstance());
                fille = (Prevision) (Class.forName(classefille).newInstance());
                PageInsertMultiple p = new PageInsertMultiple(mere, fille, request, nbLine, tId);

                FactureCF cmere = (FactureCF) (Class.forName(classe).newInstance());
                cmere.setId(idmere);
                cmere.setNomTable(table);
                Prevision[] cfille = (Prevision[])p.getObjectFilleAvecValeur();
                List<Prevision> list = new ArrayList<>(Arrays.asList(cfille));
                list.remove(list.size() - 1);
                Prevision[] newFille= list.toArray(new Prevision[0]);
                cmere.updatePlanPaiement(u.getUser().getTuppleID(),newFille,null);  
        %>
                
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute+"&id="+idmere%>");</script>
    <%
    }}catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
        history.back();</script>
        <%
                return;
            }
        %>
</html>