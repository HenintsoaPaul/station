<%-- 
    Document   : pertegainimprevue-saisie
    Created on : 29 juil. 2024, 13:52:43
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
    String autreparsley = "data-parsley-range='[8, 40]' required";
    
    
    PerteGainImprevue pertegainimprevue = new PerteGainImprevue();
    PageInsert pi = new PageInsert(pertegainimprevue, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    String idorigine = request.getParameter("idorigine");

    pi.getFormu().getChamp("designation").setLibelle("Designation");
    pi.getFormu().getChamp("designation").setType("textarea");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    
    pi.getFormu().getChamp("idorigine").setLibelle("Origine");
    pi.getFormu().getChamp("idorigine").setAutre("readonly");
    pi.getFormu().getChamp("tiers").setLibelle("Tiers");
    pi.getFormu().getChamp("tiers").setPageAppelComplete("pertegain.Tiers","id","tiers");
    pi.getFormu().getChamp("idorigine").setDefaut(idorigine);
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
    pi.getFormu().getChamp("etat").setVisible(false);
    
    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet tgp = new TypeObjet();
    tgp.setNomTable("typegainperte");
    liste[0] = new Liste("idtypegainperte", tgp, "val", "id");

    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idtypegainperte").setLibelle("Type Gain ou Perte");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie Perte ou Gain imprevue</h1>
    <!--  -->
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="perte_gain" id="perte_gain" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="pertegain/pertegainimprevue-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="pertegain.PerteGainImprevue">
    </form>
</div>
<%}catch(Exception e){
    e.printStackTrace();
%>
<script language="JavaScript"> alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
history.back();</script>
<%
        return;
    }
%>