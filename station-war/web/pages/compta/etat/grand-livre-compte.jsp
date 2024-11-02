<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire" %>
<%@page import="java.sql.Date" %>
<%@page import="mg.cnaps.compta.*" %>
<%@page import="affichage.PageInsert" %>
<%
    ComptaEtatGrandLivreGenerator grandLivre = null;
    try{
    String lang = String.valueOf(session.getAttribute("lang"));
    String[] mots = {"Grand livre du compte", "au", "Compte", "Libelle du compte", "Journal", "Date", "Libelle", "Lettrage", "Mouvement", "Debit", "Credit", "Solde", "exporter"};
    String[] ret = Utilitaire.transformerLangue(mots, lang);

    ComptaEtatGrandLivreGenerator gl = new ComptaEtatGrandLivreGenerator();
    gl.setNomTable("v_compta_etat_balance");
    PageInsert pi=new PageInsert(gl,request);
    grandLivre = (ComptaEtatGrandLivreGenerator)pi.getObjectAvecValeur();
    grandLivre.fillComptesWithMouvementAndReport(null);
    System.out.println("taille compte==="+grandLivre.getCompteArray().length);
%>

<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <jsp:include page='../../elements/css.jsp'/>
    <div class="content-wrapper">
            <div class="row">
                <div class="row col-md-12">
                    <div class="box box-solid">
                        <div class="content">
                            <div id="table-container">
                                <div class="d-flex align-items-center col-12">
                                    <div class="box-header with-border">
                                        <h3 class="title " id="titre-export">
                                            Grand livre du compte du <%=grandLivre.getCompteDebut()%> au <%=grandLivre.getCompteFin()%>
                                        </h3>
                                    </div>

                                    <div class="row">

                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group me-3">
                                                        <label>Format</label>
                                                        <select name="ext" id="ext" class="form-control">
                                                            <option value="xls">Excel</option>
                                                            <option value="pdf">PDF</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    </br>
                                                    <div class="form-group">
                                                        <input type="button" class="btn btn-info" value="Exporter" onclick="exporter()"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-body table-responsive no-padding">
                                    <table id="export" border="1" class="table table-hover table-bordered">
                                        <tbody>
                                    <%  //String v = "<table><thead><tr><td>Grand livre du compte " + grandLivre.getCompteDebut() + " au " + grandLivre.getCompteFin() + "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></thead><tbody>";
                                        for (Map.Entry<String,ComptaCompte> listeComptes : grandLivre.getComptes().entrySet()) {
                                            ComptaCompte cc = listeComptes.getValue();
                                    %>
                                    <%
                                        if (cc != null && cc != null) {
                                    %>



                                            <tr class="head">
                                                <th colspan="11">COMPTE : <%= cc.getCompte()%> </th>
                                            </tr>
                                            <tr>
                                                <th>Compte</th>
                                                <th>Id Mvt</th>
                                                <th>Date</th>
                                                <th>Jrn/Folio</th>
                                                <th>Contrep.</th>
                                                <th>Libelle oper.</th>
                                                <th>Debit</th>
                                                <th>Credit</th>
                                                <th>Lettre</th>
                                                    <%
                                                        if (grandLivre.getTypeCompte().compareToIgnoreCase("1") == 0)/* compte general*/ {
                                                    %>
                                                <th>Compte analytique</th>
                                                    <%
                                                    } else {
                                                    %>
                                                <th>Compte g&eacute;n&eacute;rale</th>
                                                    <%
                                                        }
                                                    %>
                                            <!---    <th>Etat</th> ----!>
                                            </tr>
                                            <tr>
                                                <td colspan="5"></td>
                                                <td>Ancien cumul...</td>
                                                <td>
                                                    <%if (cc.getReportDebit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(cc.getReportDebit()));
                                                        }
                                                    %>
                                                </td>
                                                <td>
                                                    <% if (cc.getReportCredit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(cc.getReportCredit()));
                                                        }
                                                    %>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <%
                                                List<ComptaSousEcriture> mouvements = cc.getMouvements();
                                                System.out.println("size="+mouvements.size());
                                                if (mouvements != null && mouvements.size() > 0) {
                                                    String color = "black";
                                                    for (ComptaSousEcriture comptaEcriture : mouvements) {
                                                        if (comptaEcriture != null) {
                                                            if (comptaEcriture.getEtat() == 1) {
                                                                color = "red";
                                                            } else if (comptaEcriture.getEtat() == 11) {
                                                                color = "black";
                                                            }
                                            %>
                                            <tr>
                                                <td>
                                                    <%= cc.getCompte()%>
                                                </td>
                                                <td>
                                                    <a href="<%=(String) session.getAttribute("lien")%>/../../../module.jsp?but=compta/ecriture/ecriture-fiche.jsp&id=<%=comptaEcriture.getIdMere()%>" target="_blank"><%=comptaEcriture.getIdMere()%></a>
                                                </td>
                                                <td>
                                                    <%= Utilitaire.formatterDaty(comptaEcriture.getDaty())%>
                                                </td>
                                                <td>
                                                    <%= comptaEcriture.getJournal()%>/<%= comptaEcriture.getFolio()%>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <%= comptaEcriture.getRemarque()%>
                                                </td>
                                                <td style="text-align: right">
                                                    <%if (comptaEcriture.getDebit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(comptaEcriture.getDebit()));
                                                        }%>
                                                </td>
                                                <td style="text-align: right"> 
                                                    <%if (comptaEcriture.getCredit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(comptaEcriture.getCredit()));
                                                        }%>
                                                </td>                                        
                                                <td> 
                                                    <%= comptaEcriture.getLettrage()%>
                                                </td>
                                                <td><%= comptaEcriture.getReference_engagement()%></td>
                                            <!----    <td> 
                                                    <%if (comptaEcriture.getEtat() == 1) {
                                                            out.print("NON VISE");
                                                        } else if (comptaEcriture.getEtat() == 11) {
                                                            out.print("VISE");
                                                        }%>
                                                </td> ----!>
                                            </tr>                                    
                                            <%
                                                }
                                            %>
                                            <% }
                                                }
                                            %>

                                            <tr>
                                                <td colspan="5"></td><td><b>TOTAL</b></td>
                                                <td style="text-align: right">
                                                    <b><%= Utilitaire.formaterAr(cc.getTotalDebit())%></b>
                                                </td>
                                                <td style="text-align: right">
                                                    <b><%= Utilitaire.formaterAr(cc.getTotalCredit())%></b>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>

                                            <tr>
                                                <td colspan="5"></td>
                                                <td><b>CUMUL</b></td>
                                                <td style="text-align: right">
                                                    <b><%= Utilitaire.formaterAr(cc.getReportDebit())%></b>
                                                </td>
                                                <td style="text-align: right">
                                                    <b><%= Utilitaire.formaterAr(cc.getReportCredit())%></b>
                                                </td><td></td><td></td>
                                            </tr>

                                            <tr class="table-apj-footer">
                                                <td colspan="5"></td>
                                                <td><b>SOLDE</b></td>
                                                <td style="text-align: right">
                                                    <b > <%if (cc.getSoldeDebit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(cc.getSoldeDebit()));
                                                        }%></b>
                                                </td>
                                                <td  style="text-align: right">
                                                    <b><%if (cc.getSoldeCredit() == 0) {
                                                            out.print("");
                                                        } else {
                                                            out.print(Utilitaire.formaterAr(cc.getSoldeCredit()));
                                                        }%></b>
                                                </td>
                                                <td colspan="3"></td>
                                            </tr>



                                    <% } %>
                                    <% }%>

                                    <tr>
                                        <th colspan="5"></th>
                                        <th>Total</th>
                                        <th style="text-align: right"> <%= grandLivre.getTotalCredit()%></th>
                                        <th style="text-align: right"> <%= grandLivre.getTotalDebit()%></th>
                                        <th colspan="3"></th>
                                    </tr>
                                        <tr>
                                            <td colspan="11"></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                </div>
                                <input id="date1" type="hidden" value="<%= grandLivre.getDateDebut()%>" />
                                <input id="date2" type="hidden" value="<%= grandLivre.getDateFin()%>" />
                                <input id="plage1" type="hidden" value="<%= grandLivre.getCompteDebut()%>" />
                                <input id="plage2" type="hidden" value="<%= grandLivre.getCompteFin()%>" />
                                <input id="exercice" type="hidden" value="<%= grandLivre.getExercice()%>" />
                                <input id="typecompte" type="hidden" value="<%= grandLivre.getTypeCompte()%>" />
                                <input id="etat" type="hidden" value="<%= grandLivre.getEtat()%>" />


                            <div class="box box-primary box-solid">
                                <div id="export-body" class="box-body" style="display: block;">
                                    <form id="form-export" action="../../../download" method="post">
                                        <input type="hidden" name="ext"  value="xls"  checked="checked">
                                        <input type="hidden" name="donnee" value="0" checked="checked">
                                        <input type="hidden" name="specific_xls" value="true"/>
                                        <input id="excel-input"  type="hidden" name="table">
                                    </form>
                                        
                                    <form id="form-export-pdf" action="../../../balanceExport?action=exportGrandLivrePDF&date1=<%=grandLivre.getMoisDebut()%>&date2=<%=grandLivre.getMoisFin()%>&plage1=<%=grandLivre.getCompteDebut()%>&plage2=<%=grandLivre.getCompteDebut()%>&typecompte=<%=grandLivre.getTypeCompte()%>&exercice=<%=grandLivre.getExercice()%>&etat=<%=grandLivre.getEtat()%>" method="post">
                                        <input id="excel-input-pdf"  type="hidden" name="table" value="">
                                        <input type="hidden" name="ext"  value="pdf"  checked="checked">
                                        <input type="hidden" name="donnee" value="0" checked="checked">
                                        <input type="hidden" value="Exporter" class="btn btn-default">
                                    </form>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                                
        <%} catch (Exception e) {
            e.printStackTrace();
}%>

    <script>
        $(".btn-export").click(function() {
            $(".export-block").toggleClass("inactive");
        });
        
        function exporter(){
            let exp = $('#ext').val();
            if(exp === 'xls'){
                document.location.replace("../../../balanceExport?action=exportGrandLivrePDF&date1=<%=grandLivre.getMoisDebut()%>&date2=<%=grandLivre.getMoisFin()%>&plage1=<%=grandLivre.getCompteDebut()%>&plage2=<%=grandLivre.getCompteFin()%>&typecompte=<%=grandLivre.getTypeCompte()%>&exercice=<%=grandLivre.getExercice()%>&etat=<%=grandLivre.getEtat()%>&type=xls")
            }
            if(exp === 'pdf'){
                document.location.replace("../../../balanceExport?action=exportGrandLivrePDF&date1=<%=grandLivre.getMoisDebut()%>&date2=<%=grandLivre.getMoisFin()%>&plage1=<%=grandLivre.getCompteDebut()%>&plage2=<%=grandLivre.getCompteFin()%>&typecompte=<%=grandLivre.getTypeCompte()%>&exercice=<%=grandLivre.getExercice()%>&etat=<%=grandLivre.getEtat()%>");
            }
        }
        
        function chargerExportPDF()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();

            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            document.location.replace('../../../ExportServlet?titre=' + titre + "&htmlcontent=" + excel);
        }
        function chargerExport()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();
            

            var excelInput = document.getElementById("excel-input");
            excelInput.value = excel;
            console.log("valeur de l'excel" + excelInput.value);
        }
        function changerExportExcel()
        {
            var titre = "<h1>" + $('#titre-export').html() + "</h1>";
            var excel = titre + $('#table-container').html();
            

            var excelInput = document.getElementById("donnee");
            excelInput.value = excel;
            //console.log("valeur de l'excel" + excelInput.value);
        }



        function exporterCsv()
        {
            chargerExport(); 
            var form = $("#form-export");
            form.submit();
        }

        function ecranEcritureComptable(id) {
            url = 'compta/etat/ecritureComptable-etat.jsp?id=' + id;
            window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
        }
    </script>  