<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        String classe = "mg.cnaps.compta.ComptaCompte";
        String nomtable = "compta_compte";
        ComptaCompte compte = new ComptaCompte();
        UserEJB u = (user.UserEJB) session.getValue("u");
        String user = u.getUser().getLoginuser();
//        if(user.compareToIgnoreCase("lala") != 0 & user.compareToIgnoreCase("zoely") != 0 ){
//            out.println("<script language=\"JavaScript\">alert('Vous ne pouvez pas feire cette action.');</script>");
//            out.println("<script language=\"JavaScript\">history.back();</script>");
//        }
        PageUpdate pi = new PageUpdate(compte, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        affichage.Champ[] liste = new affichage.Champ[2];

        TypeObjet journal = new TypeObjet();
        journal.setNomTable("COMPTA_JOURNAL_VIEW");
        liste[0] = new Liste("idjournal", journal, "desce", "id");
        
        TypeObjet typecompte = new TypeObjet();
        typecompte.setNomTable("COMPTA_TYPE_COMPTE");
        liste[1] = new Liste("typeCompte",typecompte,"val","id");

        pi.setTitre("Modification conte");
        pi.getFormu().getChamp("compte").setLibelle("Compte");
        pi.getFormu().getChamp("libelle").setLibelle("Libelle");

//        pi.getFormu().getChamp("id").setVisible(false);

        pi.getFormu().changerEnChamp(liste);
        // pi.getFormu().getChamp("classe").setVisible(false);
        pi.getFormu().getChamp("idjournal").setLibelle("Journal");
        pi.getFormu().getChamp("analytique_obli").setVisible(false);
        pi.getFormu().getChamp("typecompte").setLibelle("Type de compte");
        
        pi.preparerDataFormu();
        // pi.getFormu().makeHtmlInsertTabIndex();

        String lien = (String) session.getValue("lien");
        String id = (String)request.getParameter("id");

%>

<div class="content-wrapper">
    <div class="col-md-3"></div>
    <div class="col-md-6">
        <div class="box-fiche">
            <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href=<%= lien + "?but=compta/compte/compte-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pi.getTitre()%></h1>
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
                        <input name="acte" type="hidden" id="acte" value="update"/>
                        <input name="bute" type="hidden" id="bute" value="compta/compte/compte-fiche.jsp"/>
                        <input name="rajoutLien" type="hidden" id="rajoutLien"
                            value="id-<%out.print(request.getParameter("id"));%>"/>
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomtable %>">
                    </form>
            </div>
        </div>
    </div>
    
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>