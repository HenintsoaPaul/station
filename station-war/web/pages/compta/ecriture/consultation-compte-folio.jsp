<%@page import="mg.cnaps.commun.Constante"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.CGenUtil"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.cnaps.compta.*"%>
<%@page import="affichage.PageRecherche"%>

<% 
try {
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

    pr.getFormu().changerEnChamp(liste);
    pr.creerObjetPage(libEntete, colSomme);
    ComptaConsultationFolio comptaConsultationFolio = (ComptaConsultationFolio)pr.getCritere();
    ComptaSousEcriture[] ecritures= comptaConsultationFolio.getEcritures();
   
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
        <br />
        <div class="row">
            <div class="col-md-12" >
                <div class="box box-solid">
                    <div class="box-header">
                        <h3 class="box-title" align="center">LISTE</h3>
                    </div>
                    <div class="box-body">
                        <div id="table-container" class="compta-export">
                            <div class="d-flex align-items-center col-12">
                                <div class="table-container">
                                    <table id="export" class="table table-hoverable table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="background-color:#103a8e;color: white;" >Date</th>
                                                <th style="background-color:#103a8e;color: white;"> Journal/Folio</th>
                                                <th style="background-color:#103a8e;color: white;">Compte</th>
                                                <th style="background-color:#103a8e;color: white;">Libelle de l'operation</th>
                                                <th style="background-color:#103a8e;color: white;">Montant Debit</th>
                                                <th style="background-color:#103a8e;color: white;">Montant Credit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                                                                    <%
                                            for (int i = 0; i < ecritures.length; i++) {
                                            %>
                                            <tr>
                                                <td>
                                                    <%= Utilitaire.formatterDaty(ecritures[i].getDaty())%>
                                                </td>
                                                <td>
                                                    <%= ecritures[i].getJournal()%>/<%= ecritures[i].getFolio()%>
                                                </td>
                                                <td>
                                                    <%= ecritures[i].getCompte()%>
                                                </td>
                                                <td>
                                                    <%= ecritures[i].getRemarque()%>
                                                </td>

                                                <td> 
                                                    <%if (ecritures[i].getDebit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(ecritures[i].getDebit()));
                                                        }%>
                                                </td>
                                                <td>
                                                    <%if (ecritures[i].getCredit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(ecritures[i].getCredit())
                                                            );
                                                        }%>
                                                </td>
                                            </tr>
                                            <% } %>
                                            <tr class="table-apj-footer">
                                                <td colspan="3"></td>
                                                <td><b>Total</b></td>
                                                <td><%= Utilitaire.formaterAr(comptaConsultationFolio.getSommeCredit())%></td>
                                                <td><%= Utilitaire.formaterAr(comptaConsultationFolio.getSommeDebit())%></td>
                                            </tr>
                                            <tr class="table-apj-footer">
                                                <td colspan="3"></td>
                                                <td><b>Cummul</b></td>
                                                <td><%= Utilitaire.formaterAr(comptaConsultationFolio.getCumulCredit())%></td>
                                                <td><%= Utilitaire.formaterAr(comptaConsultationFolio.getCumulDebit())%></td>
                                            </tr> 
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    
                    </div>
            </div>
    </section>
</div>
<% } catch (Exception ex) {
    ex.printStackTrace();
} 
%>
