<%@page import="utilisateurstation.UtilisateurStation"%>
<%@page import="utilisateur.Utilisateur"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UtilisateurStation a = new UtilisateurStation();
    PageConsulte pc = pc = new PageConsulte(a, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.getChampByName("pwduser").setVisible(false);
    pc.getChampByName("Refuser").setLibelle("R&eacute;f&eacute;rence");
    pc.getChampByName("Loginuser").setLibelle("Login");
    pc.getChampByName("Nomuser").setLibelle("Nom et pr&eacute;nom");
    pc.getChampByName("Teluser").setLibelle("Tel");
    pc.getChampByName("Adruser").setLibelle("D&eacute;partement");
    pc.getChampByName("Idrole").setLibelle("Ro&#770;le");
    pc.setTitre("Utilisateur fiche");

    // MapUtilisateur orp = (MapUtilisateur) pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=utilisateur/utilisateur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/utilisateur-modif.jsp&refuser=" + request.getParameter("refuser")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=utilisateur/apresUtilisateur.jsp&acte=desactiver&idUser=" + request.getParameter("refuser")%>" style="margin-right: 10px">D&eacute;sactiv&eacute;</a>
                        </div>
                        <br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

