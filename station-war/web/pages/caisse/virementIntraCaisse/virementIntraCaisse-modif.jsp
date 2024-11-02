<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@page import="caisse.VirementIntraCaisse"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    VirementIntraCaisse t =new VirementIntraCaisse();
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("idCaisseDepart").setPageAppel("choix/caisse/etatcaisse-choix.jsp");
    pi.getFormu().getChamp("idCaisseArrive").setPageAppel("choix/caisse/etatcaisse-choix.jsp");
    pi.getFormu().getChamp("idCaisseDepart").setLibelle("Caisse depart");
    pi.getFormu().getChamp("idCaisseArrive").setLibelle("Caisse arrive");
    pi.getFormu().getChamp("id").setAutre("readonly");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification virement intra caisse</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pi.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br> 
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="caisse/virementIntraCaisse/virementIntraCaisse-fiche.jsp">
                        <input name="classe" type="hidden" id="classe" value="caisse.VirementIntraCaisse">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="virementIntraCaisse">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>