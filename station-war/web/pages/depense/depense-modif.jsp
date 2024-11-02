<%-- 
    Document   : update-simple
    Created on : 9 mars 2023, 11:58:35
    Author     : BICI
--%>
<%@page import="depense.Depense"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Depense t =new Depense();
    PageUpdate pi = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    pi.getFormu().getChamp("idCaisse").setPageAppel("choix/caisse/caisse-choix.jsp");
    pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("idOrigine").setVisible(false);
    pi.getFormu().getChamp("idOp").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    
    pi.setLien((String) session.getValue("lien"));
    pi.preparerDataFormu();
    String idEncaissement = request.getParameter("idEncaissement");
%>
<div class="content-wrapper">
       <div class="row">
              <div class="col-md-3"></div>
              <div class="col-md-6">
                     <div class="box-fiche">
                            <div class="box">
                                   <div class="box-title with-border">
                                        <h1>Modification depense</h1>
                                   </div>
                                   <div class="box-body">
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
                                            <input name="bute" type="hidden" id="bute" value="depense/depense-fiche.jsp<%=( idEncaissement==null ? "" : ("&idEncaissement="+idEncaissement) )%>">
                                            <input name="classe" type="hidden" id="classe" value="depense.Depense">
                                            <input name="nomtable" type="hidden" id="nomtable" value="depense">
                                        </form>
                                   </div>
                            </div>
                     </div>
              </div>
       </div>
</div>