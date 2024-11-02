<%@page import="magasin.Magasin"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="user.UserEJB"%>
<%@ page import="bean.TypeObjet" %>
<%
    try{
    UserEJB u = (UserEJB) session.getAttribute("u");
    String listeCrt[] = {"id","val","idpointlib","idtypemagasinlib"};
    String listeInt[] = {};
    String libEntete[] = {"id","val","idpointlib","idtypemagasinlib","idproduitlib"};
    Magasin categ = new Magasin();
    categ.setNomTable("magasinlib");
    PageRechercheChoix pr = new PageRechercheChoix(categ, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setChampReturn(request.getParameter("champReturn"));
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("choix/choix-magasin.jsp");
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("Description");
    pr.getFormu().getChamp("idpointlib").setLibelle("Point");
    pr.getFormu().getChamp("idtypemagasinlib").setLibelle("Type");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme); 
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Magasin</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Choix magasin</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="cc" id="cc">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%

                    String libelles[] = {"Id","Description","Point","Type","Produit"};
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
<% }catch(Exception ex){
    ex.printStackTrace();
}%>
