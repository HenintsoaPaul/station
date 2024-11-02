<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.OrigineCompte"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    OrigineCompte t =new OrigineCompte();
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    
    pi.getFormu().getChamp("id").setAutre("readonly");
    pi.getFormu().getChamp("val").setLibelle("Nom");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    
    String classe = "mg.cnaps.compta.OrigineCompte";
    String butApresPost = "compta/configuration/origine-liste.jsp";
    String nomTable = "compta_origine";
    String lien = (String) session.getValue("lien");
    String id = (String) request.getParameter("id");
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
    pi.setTitre("Modification Origine");
%>
<div class="content-wrapper">
    <div class="col-md-3"></div>
    <div class="col-md-6">
        <div class="box-fiche">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href=<%= lien + "?but=compta/configuration/origine-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pi.getTitre()%></h1>
                </div>
                <form action="<%= lien %>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien"
                            value="id-<%out.print(request.getParameter("id"));%>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
                    </form>
            </div>
        </div>
    </div>
    
</div>