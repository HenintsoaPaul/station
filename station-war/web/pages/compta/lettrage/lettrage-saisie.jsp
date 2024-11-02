<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.*"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.*"%>
<%@page import="mg.cnaps.configuration.Configuration"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil"%>

<%
try{
        UserEJB u = (UserEJB) session.getAttribute("u");
        
        ComptaSousEcriture a = new ComptaSousEcriture();
        a.setNomTable("compta_sousecriture_lib");
        
        String listeCrt[] = {"daty", "compte", "numero"};
        String listeInt[] = {"daty"};

        String libEntete[] = {"id","idJournal","compte","numero","ecriture","exercice","daty","debit","credit"};

        PageRechercheChoix pr = new PageRechercheChoix(a, request, listeCrt, listeInt, 3, libEntete, libEntete.length,true);
        pr.setPreciserChoix(true);
        System.out.println(pr.getPremier());

       // pr.getFormu().getChamp("compte").setAutre("required");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("compta/lettrage/lettrage-saisie.jsp");
        pr.setAWhere(" AND LETTRAGE is NULL");

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("numero").setLibelle("Libelle");

        
        String[] colSomme = null;

        pr.setNpp(300);
        
        pr.creerObjetPage(libEntete, colSomme);

        int nombreLigne = pr.getTableau().getData().length;
        String nomtable = "compta_lettrage";

        Configuration[] lettrageParram = null;
        lettrageParram = (Configuration[]) CGenUtil.rechercher(new Configuration(), null, null, " AND TYPECONFIG = 'lettrage'");
        char[] l = lettrageParram[0].getRemarque().toLowerCase().toCharArray();
        String lettre = Utilitaire.incrementLettre(l);
    %>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Lettrage</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/lettrage/lettrage-saisie.jsp" method="post" name="incident" id="incident">
            <%
            out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <input name="premier" type="hidden"  value="false">
        </form>
        <% if (!pr.getPremier()) {%>
        <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" id='modif-form' method="post" data-parsley-validate>
            <div class="result mt-5 table-result">
                <div class="row" >
                    <div class="col-md-3">
                        <div class="box box-primary">
                            <div class="box-body">
                                <div class="form-group">
                                    <label>Lettre</label>
                                    <input class="form-control" id="lettreInitial" name="lettre" type="text" value="<%=lettre.toUpperCase()%>" >
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6"  >
                        <div class="box box-primary">
                            <div class="box-body">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Total Debit</label>
                                        <input class="form-control montant" id="totalDebit" name="totalDebit" value="0" type="text">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Total Credit</label>
                                        <input class="form-control montant" id="totalCredit" name="totalCredit" value="0" type="text">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="box box-primary">
                            <div class="box-body">
                                <div class="form-group">
                                    <label>Ecart</label>
                                    <input class="form-control" id="ecart" name="ecart" type="text" value="0" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <%
            String libEnteteAffiche[] = {"id","Journal","Compte","Libelle","Ecriture","exercice","Date","Debit","Credit"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameBoutton("Lettrer");
                pr.getTableau().setNameActe("insertMereLierFille");
                pr.getTableau().setNameActe2("insertMereLierFille");
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
            </div>
            <input name="acte" type="hidden" id="acte" value="insertMereLierFille">
            <input name="bute" type="hidden" id="bute" value="compta/lettrage/lettrage-saisie.jsp"">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.compta.ComptaLettrage">
            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=nombreLigne%>">
            <input name="colonneMere" type="hidden" id="colonneMere" value="id"/>
            <input name="colonneFille" type="hidden" id="colonneFille" value="lettrage"/>
            <input name="classeFille" type="hidden" id="classe" value="mg.cnaps.compta.ComptaSousEcriture"/>
            <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
          
        </form>
        <% } %>
    </section>
</div>


<%}catch(Exception e){
e.printStackTrace();
}%>
