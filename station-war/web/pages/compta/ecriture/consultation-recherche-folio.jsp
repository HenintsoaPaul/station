<%@page import="mg.cnaps.commun.Constante"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.CGenUtil"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.cnaps.compta.*"%>
<%@page import="affichage.PageRecherche"%>

<% 

    ComptaConsultationFolio lv = new ComptaConsultationFolio();
    lv.setNomTable("COMPTA_VIEW_FOLIO");
    String listeCrt[] = {"journal", "mois", "exercice", "compte", "folio", "typeCompte"};
    String listeInt[] = {};
    String libEntete[] ={"id", "journal", "mois", "exercice", "compte", "folio", "typeCompte"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String[] colSomme = null;

    affichage.Champ[] liste = new affichage.Champ[3];
    TypeObjet c = new TypeObjet();
    c.setNomTable("COMPTA_JOURNAL_VIEW");
    liste[0] = new Liste("journal", c, "desce", "val");
    
    String[] valeurs = {"1","3"};
    String[] affiches = {"General","Analytique"};
    liste[1] = new Liste("typeCompte" ,affiches,valeurs);

    String[] valMois = {"01","02","03","04","05","06","07","08","09","10","11","12"};
    String[] affMois = {"Janvier","Fevrier","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Decembre"};
    liste[2] = new Liste("mois" ,affMois,valMois);

   
    pr.setApres("compta/ecriture/consultation-compte-folio.jsp");
    pr.getFormu().changerEnChamp(liste);
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Consultation par Folio</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/ecriture/consultation-compte-folio.jsp" method="post" name="incident" id="incident">
            <%
                // pr.getFormu().makeHtmlNew();
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <br>
    </section>
</div>
