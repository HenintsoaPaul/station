<%@page import="change.*" %>
<%@page import="affichage.*" %>
<%
    TauxDeChange taux = new TauxDeChange();
    PageConsulte pc = new PageConsulte( taux, request, (user.UserEJB) session.getValue("u") );
    String tauxId = pc.getBase().getTuppleID();
    String lien = (String) session.getValue("lien");
    pc.setLien(lien);
    pc.setTitre("Fiche de Taux");
    pc.getChampByName("id").setLibelle("Id Taux");
    pc.getChampByName("idDevise").setLibelle("Devise");
    String pageModif = "station-ejb/src/java/change/taux/taux-modif.jsp";
    String classe = "change.TauxDeChange";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=change/taux/taux-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                                <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + tauxId%>" style="margin-right: 10px">
                                    Modifier
                                </a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
