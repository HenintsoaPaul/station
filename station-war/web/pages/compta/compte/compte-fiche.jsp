<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="mg.cnaps.compta.*" %>

<%
    try{
        ComptaCompte compte = new ComptaCompte();
        compte.setNomTable("COMPTA_COMPTE_LIBELLE");
        String[] libelleCompteFiche = {"Id", "Compte", "Libelle", "Type Compte","Journal"};
        PageConsulte pc = new PageConsulte(compte, request, (user.UserEJB) session.getValue("u"));
        pc.setLibAffichage(libelleCompteFiche);
        pc.setTitre("Fiche Compte");
        String lien = (String) session.getValue("lien");
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">
                            <a href=<%= lien + "?but=compta/compte/compte-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a>
                            <%=pc.getTitre()%>
                        </h1>
                    </div>
                    <div class="box-body">
                        <%= pc.getHtml() %>
                        <br />
                    </div>
                     <div class="box-footer">
                            <a  href="<%=(String) session.getValue("lien") + "?but=compta/compte/compte-modif.jsp&id=" + request.getParameter("id")%>" class="btn btn-warning">Modifier</a>
                        </div>
                    <br/>
                </div>
            </div>
        </div>
    </div>

</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } %>