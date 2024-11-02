<%--
    Document   : resultat-prevision
    Created on : 20 ao�t 2024, 16:06:28
    Author     : Estcepoire
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="prevision.Prevision"%>
<%@page import="prevision.AdminPrevision"%>
<%
    Prevision minimum=null;
    try {
        String[] intervalles = {};
        String[] criteres = {};
        String[] libEntete = {"daty","soldeInitial", "debit", "credit", "soldeFinale"};
        String[] libEnteteAffiche = {"Date","Solde initial", "station-ejb/src/java/depense", "recette", "Solde final"};
        PageRecherche pr = new PageRecherche(new Prevision(), request, criteres, intervalles, 3, libEntete, libEntete.length);
        String moisDefaut=Utilitaire.getMois(Utilitaire.dateDuJour());

        String anneeDefaut=Utilitaire.getAnnee(Utilitaire.dateDuJour());
        String[] debutFinDefaut=Utilitaire.getBorneDatyMoisAnnee(moisDefaut, anneeDefaut);
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        String[] colSomme = null;
        String lien = (String) session.getValue("lien");
        String grouper="semaine";
        if(request.getParameter("grouper")!=null) grouper = request.getParameter("grouper");
        String defaultDatyFiltre = request.getParameter("datyFiltre") != null ? request.getParameter("datyFiltre"):Utilitaire.dateDuJour();
        String defaultDatyDebut = request.getParameter("datyDebut") != null ? request.getParameter("datyDebut"):debutFinDefaut[0];
        String defaultDatyFin = request.getParameter("datyFin") != null ? request.getParameter("datyFin"):debutFinDefaut[1];

%>

<style>
    .strong{
        font-size: 15px;
        padding-top: 4px;
    }
</style>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Resultat previsionnel</h1>
    </section>
    <form action="<%=lien%>?but=prevision/resultat-prevision.jsp" method="post">
        <div class='box box-primary box-solid'>
            <div class='box-header' style='background-color: rgb(32, 83, 150); border-top: 3px solid #205396;'>
                <h3 class='box-title' color='#edb031'><span color='#edb031'>Recherche avanc&eacute;e</span></h3>
                <div class='box-tools pull-right'><button data-original-title='Collapse' class='btn btn-box-tool' data-widget='collapse' data-toggle='tooltip' title=''><i class='fa fa-plus'></i></button> </div>
            </div>
            <div class='box-insert'>
                <div class='box-body'>
                    <div class="form-group">
                        <div class="col-md-4">
                            <label>Date du jour</label>
                            <input class="form-control" id="datyFiltre" onmouseover="datepicker('datyFiltre')" type="textbox" name="datyFiltre" placeholder="dateFiltre" value="<%= defaultDatyFiltre %>" >
                        </div>
                        <div class="col-md-4">
                            <label>Date debut</label>
                            <input class="form-control" id="datyDebut" onmouseover="datepicker('datyDebut')" type="textbox" name="datyDebut" placeholder="datyDebut" value="<%= defaultDatyDebut %>">
                        </div>
                        <div class="col-md-4">
                            <label>Date fin</label>
                            <input class="form-control" id="datyFin" onmouseover="datepicker('datyFin')" type="textbox" name="datyFin" placeholder="dateFin" value="<%=defaultDatyFin %>">
                        </div>
                        <div class="col-md-4">
                            <label>Grouper</label>
                            <select class="form-control" name="grouper">
                                <option value="">Jour</option>
                                <option value="semaine" <%if(grouper.compareToIgnoreCase("semaine")==0)out.print("selected");%>>Semaine</option>
                                <option value="mois" <%if(grouper.compareToIgnoreCase("mois")==0)out.print("selected");%>>Mois</option>
                            </select>
                        </div>
                        <br>
                        <br>
                        <br>
                        <div class='col-xs-12'>
                            <button type="submit" class='btn btn-success pull-right' style='margin-right: 25px;'>Valider</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            <%
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String datyFiltre = request.getParameter("datyFiltre");
                        String datyDebut = request.getParameter("datyDebut");
                        String datyFin = request.getParameter("datyFin");

                        if (datyFiltre.isEmpty() == false || datyDebut.isEmpty() == false || datyFin.isEmpty() == false) {
                            AdminPrevision ap = new AdminPrevision();
                            ap.getPrevision(datyFiltre, datyDebut, datyFin,grouper);
                            minimum=ap.getMinimum();
                            pr.creerObjetPage(libEntete,colSomme);
                            pr.getTableau().setData(ap.getListePrev());
                            pr.getTableau().transformerDataString();
                            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                            out.println(pr.getTableau().getHtml());
                        }
                    }
                    if(minimum!=null) { %>
                    <div id="toremove">
                        <table>

                            <tr id="minimum-values">
                                <%
                                    for( int i = 0; i < libEntete.length - 2; i++ ){
                                        out.println("<td></td>");
                                }
                                %>
                                <td style="padding: 10px">
                                    <strong class="strong">
                                        Date minimum : <%= utilitaire.Utilitaire.format(minimum.getDaty()) %>
                                    </strong>
                                </td>
                                <td style="text-align: right; padding: 10px">
                                    <strong class="strong">
                                        Solde minimum : <%= utilitaire.Utilitaire.formaterAr(minimum.getSoldeFinale()) %>
                                    </strong>
                                </td>
                            </tr>
                        </table>
                    </div>

                <%    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
    </form>

</div>
    <script>
        let tableContainer = $("tbody");
        let min = $("#minimum-values").clone();
        min.attr('id', 'min');
        tableContainer.append( min );
        $("#toremove").remove();

    </script>
