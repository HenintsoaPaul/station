<%-- 
    Document   : pertegainimprevue-modif
    Created on : 29 juil. 2024, 13:53:24
    Author     : bruel
--%>

<%@page import="bean.CGenUtil"%>
<%@page import="pertegain.PerteGainImprevue"%>
<%@page import="user.*"%> 
<%@page import="bean.TypeObjet" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    try{
    
    PerteGainImprevue a = new PerteGainImprevue();
    PageUpdate pi = new PageUpdate(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    

    pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("designation").setType("textarea");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idtypegainperte").setLibelle("Type Gain ou Perte");
    pi.getFormu().getChamp("idorigine").setLibelle("Origine");
    pi.getFormu().getChamp("idorigine").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setLibelle("Tiers");
    pi.getFormu().getChamp("tiers").setPageAppelComplete("pertegain.Tiers","id","tiers");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("etat").setVisible(false);
    
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet tgp = new TypeObjet();
    tgp.setNomTable("typegainperte");
    liste[0] = new Liste("idtypegainperte", tgp, "val", "id");

    pi.getFormu().changerEnChamp(liste);
    /*    
    OrdonnerPayementData opd = new OrdonnerPayementData(request.getParameter("id"),request.getParameter("ded_id"));
    if (request.getParameter("ded_id") != null && request.getParameter("ded_id").compareTo("") != 0) {
        pi.getFormu().getChamp("ded_id").setDefaut(request.getParameter("ded_id"));
        pi.getFormu().getChamp("remarque").setDefaut("Paiement facture(s) " + request.getParameter("ded_id"));

    }else{
        pi.getFormu().getChamp("ded_Id").setDefaut(opd.getIdfacture());
    }
    pi.getFormu().getChamp("montant").setDefaut(Utilitaire.formaterAr(opd.getMontant()));
    
    
    
    if(idavoir!= null){
        avoir.AvoirFC avoir = new AvoirFC();
//        avoir.setNomTable("avoirFC_montant");
        avoir.setNomTable("union_AVOIRFF_MONTANT");
        AvoirFC ls [] = (AvoirFC[]) CGenUtil.rechercher( avoir , null, null, " and id='"+idavoir+"'") ;
         //BonDeCommande[] tabBc = (BonDeCommande[]) CGenUtil.rechercher( bc , null, null, " ") ;
        if(ls.length!=0){
            pi.getFormu().getChamp("ded_Id").setDefaut(ls[0].getId());
            pi.getFormu().getChamp("montant").setDefaut(ls[0].getMontant()+"");
            pi.getFormu().getChamp("daty").setDefaut(utilitaire.Utilitaire.dateDuJour());
            pi.getFormu().getChamp("remarque").setDefaut("Paiement Avoir "+ls[0].getCode());
            
        }
        
    }*/
    pi.preparerDataFormu();
    PerteGainImprevue base = (PerteGainImprevue)pi.getBase();
%>
<div class="content-wrapper">
    <h1>Modification Ordre de payer</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="ded_op" id="ded_op" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="update">
        <input name="bute" type="hidden" id="bute" value="pertegain/pertegainimprevue-fiche.jsp">
        <input name="id" type="hidden" id="id" value="<%= base.getId()%>">
        <input name="classe" type="hidden" id="classe" value="pertegain.PerteGainImprevue">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>