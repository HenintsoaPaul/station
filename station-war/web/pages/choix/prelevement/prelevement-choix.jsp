<%--
    Document   : client
    Created on : 4 avr. 2024, 15:15:17
    Author     : Angela
--%>


<%@page import="prelevement.PrelevementLibViseePopup"%>
<%@page import="prelevement.PrelevementLib"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%>


<% try{
    String champReturn = request.getParameter("champReturn");
    PrelevementLibViseePopup choix = new PrelevementLibViseePopup();
    choix.setNomTable("prelevementlib_visee_pop");
    String listeCrt[] = {"id","compteurInit","compteur","datyInit","daty","nomUser","idPompeLib"};
    String listeInt[] = {"daty","datyInit"};
    String libEntete[] = {"id","compteurInit","compteur","datyInit","daty","nomUser","idPompeLib"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.setTitre("Page choix Prelevement");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/prelevement/prelevement-choix.jsp" );
    pr.setChampReturn(champReturn);


    pr.getFormu().getChamp("compteurInit").setLibelle("Compteur Initial");
    pr.getFormu().getChamp("compteur").setLibelle("Compteur");
    pr.getFormu().getChamp("nomUser").setLibelle("Pompiste");
    pr.getFormu().getChamp("idPompeLib").setLibelle("Pompe");
    pr.getFormu().getChamp("daty1").setLibelle("Date Finale min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date Finale Max");
    pr.getFormu().getChamp("datyInit1").setLibelle("Date Initiale Min");
    pr.getFormu().getChamp("datyInit2").setLibelle("Date Initiale Max");



    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"Id", "Compteur inital","Compteur final","Date initiale","Date finales","Pompiste","Pompe"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre()%></title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='./../../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1><%= pr.getTitre()%></h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <form action="./../apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <%
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='./../../elements/js.jsp'/>
    </body>
</html>


 <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



















