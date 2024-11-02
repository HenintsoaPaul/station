<%@page import="affichage.PageInsert"%>
<%@page import="mg.cnaps.compta.BilanSection"%>
<%@page import="mg.cnaps.compta.Bilan"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
    String apres = "comptabilite/apresCompta.jsp";
    String lien = null;
    UserEJB u = null;
    BilanSection[] actifs = null;
    BilanSection[] passifs = null;

    try {
        Bilan bilan = new Bilan();
        PageInsert pi = new PageInsert(bilan, request);
        Bilan b = (Bilan) pi.getObjectAvecValeur();
        System.out.println("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXbobo1: " + b.getExercice());
        b.init();
        u = (user.UserEJB) session.getValue("u");
        lien = (String) session.getValue("lien");
        actifs = b.getSectionsActifs();
        passifs = b.getSectionsPassifs();
        double coursdevise = 1;


%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Etat financier</h1>
    </section>
    <section class="content">
        <h2>&nbsp;</h2>
        <div class="box box-primary">
            <table class="table table-bordered" align="center" cellpadding="10px" cellspacing="10px">
                <tr>
                    <td>SOCIETE : </td>
                    <td>Gallois</td>
                </tr>
                <tr>
                    <td>SIEGE SOCIAL : </td>
                    <td>-</td>
                </tr>
                <tr>
                    <td>NIF : </td>
                    <td>-</td>
                </tr>
                <tr>
                    <td>STAT : </td>
                    <td>-</td>
                </tr>
            </table>
            <br>
            <table class="table table-bordered">
                <tr>
                    <td colspan=3 align="center"><h2>Bilan</h2></td>
                </tr>

                </tr>
                <tr>
                <table class="table table-bordered" width="100%" border="1px solid black" style="border-collapse:collapse">
                    <tr>
                        <td colspan=6 align="center"><h3>ACTIF</h3></td>
                    </tr>
                    <tr>
                        <td align="center"><h4>ACTIF</h4></td>
                        <td align="center"><h4>Note</h4></td>
                        <td align="center"><h4>Dec - <%=b.getExercice()%> Brut</h4></td>
                        <td align="center"><h4><%=b.getExercice()%> Amort/prov</h4></td>
                        <td align="center"><h4><%=b.getExercice()%> NET</h4></td>
                        <td align="center"><h4>Dec - <%=b.getExercicePrecedent()%>  EXO-1 NET</h4></td>
                    </tr>
                    <% for (int iterator = 0; iterator < actifs.length; iterator++) {%>
                    <td><strong><%=actifs[iterator].getLibelle()%></strong></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <%
                        BilanSection[] filles = actifs[iterator].getFilles();
                    %>
                    <% for (int j = 0; j < filles.length; j++) {%>
                    <tr>
                        <td><%=filles[j].getLibelle()%></td>
                        <td></td>
                        <td align="right"><%=Utilitaire.formaterAr(filles[j].getTotalCurrent())%></td>
                        <td align="right"><%=coursdevise%></td>
                        <td align="right"><%=Utilitaire.formaterAr(filles[j].getTotalCurrent())%></td>
                        <td><%=Utilitaire.formaterAr(filles[j].getTotalPrevious())%></td>
                    </tr>
                    <% }%>

                    <tr>
                        <td><strong>TOTAL <%=actifs[iterator].getLibelle()%></strong></td>
                        <td></td>
                        <td align="right"><%=Utilitaire.formaterAr(actifs[iterator].getTotalCurrent())%></td>
                        <td align="right"><%=coursdevise%></td>
                        <td align="right"><%=Utilitaire.formaterAr(actifs[iterator].getTotalCurrent())%></td>
                        <td><%=Utilitaire.formaterAr(actifs[iterator].getTotalPrevious())%></td>
                    </tr>
                    <% }%>
                    <tr>
                        <td><stong>TOTAL ACTIF</stong></td>
                    <td align="right"><%=Utilitaire.formaterAr(bilan.getTotalActifsCurrent())%></td>
                    <td align="right"><%=coursdevise%></td>
                    <td align="right"><%=Utilitaire.formaterAr(bilan.getTotalActifsCurrent())%></td>
                    <td align="right"><%=Utilitaire.formaterAr(bilan.getTotalActifsPrevious())%></td>

                    </tr>
                </table>

                </tr>
                <tr>
                <table class="table table-bordered" border="1px solid black" style="border-collapse:collapse">
                    <tr>
                        <td colspan=4 align="center"><h3>PASSIF</h3></td>
                    </tr>
                    <tr>
                        <td align="center"><h4>CAPITAUX PROPRES ET PASSIFS</h4></td>
                        <td align="center"><h4>Note</h4></td>
                        <td align="center"><h4><%=b.getExercice()%> NET</h4></td>
                        <td align="center"><h4>Dec - <%=b.getExercicePrecedent()%> EXO-1 NET</h4></td>
                    </tr>
                    <% for (int iterator = 0; iterator < passifs.length; iterator++) {%>
                    <td><strong><%=passifs[iterator].getLibelle()%></strong></td>
                    <td></td>
                    <td></td>
                    <td></td>

                    <%
                        BilanSection[] fillesp = passifs[iterator].getFilles();
                    %>
                    <% for (int j = 0; j < fillesp.length; j++) {%>
                    <tr>
                        <td><%=fillesp[j].getLibelle()%></td>
                        <td></td>
                        <td align="right"><%=Utilitaire.formaterAr(fillesp[j].getTotalCurrent())%></td>
                        <td><%=Utilitaire.formaterAr(fillesp[j].getTotalPrevious())%></td>
                    </tr>
                    <% }%>


                    <tr>
                        <td><stong>TOTAL <%=passifs[iterator].getLibelle()%></stong></td>
                    <td></td>
                    <td align="right"><%=Utilitaire.formaterAr(passifs[iterator].getTotalCurrent())%></td>
                    <td><%=Utilitaire.formaterAr(passifs[iterator].getTotalPrevious())%></td>
                    </tr>
                    <% }%>
                    <tr>
                        <td><stong>TOTAL PASSIF</stong></td>
                    <td>-</td>
                     <td align="right"><%=Utilitaire.formaterAr(bilan.getTotalPassifsCurrent())%></td>
                     <td align="right"><%=Utilitaire.formaterAr(bilan.getTotalPassifsPrevious())%></td>
                   

                    </tr>
                </table>
                </tr>
            </table>
            <br>



            <br>

            <br>
            <br>
        </div>
    </section>
    <%
    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
    <%
            return;
        }
    %>