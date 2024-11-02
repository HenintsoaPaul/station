<%@page import="magasin.Magasin"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Magasin t = new Magasin();

    String  mapping = "magasin.Magasin",
          nomtable = "station-ejb/src/java/magasin",
          apres = "station-ejb/src/java/magasin/magasin-fiche.jsp";


    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));

    Liste[] liste = null;

    String titre = "Magasin";

    if(request.getParameter("typemagasin") != null && request.getParameter("typemagasin").compareToIgnoreCase("reservoir") == 0){
        liste = new Liste[1];
        TypeObjet point = new TypeObjet();
        point.setNomTable("point");
        liste[0] = new Liste("idPoint", point, "val", "id");
        pu.getFormu().changerEnChamp(liste);
        pu.getFormu().getChamp("idTypeMagasin").setDefaut("Reservoir");
        titre = "R&eacute;servoir";
        pu.getFormu().getChamp("idProduit").setLibelle("Produit");
        pu.getFormu().getChamp("idProduit").setAutre("readonly");
    }else{
        liste = new Liste[1];
        TypeObjet point = new TypeObjet();
        point.setNomTable("point");
        liste[0] = new Liste("idPoint", point, "val", "id");
        pu.getFormu().changerEnChamp(liste);
        pu.getFormu().getChamp("idTypeMagasin").setDefaut("Normal");
        pu.getFormu().getChamp("idProduit").setVisible(false);
    }

    pu.setTitre("Modification "+titre);
    pu.getFormu().getChamp("id").setAutre("readonly");
    pu.getFormu().getChamp("val").setLibelle("Libell&eacute;");
    pu.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
    pu.getFormu().getChamp("idPoint").setLibelle("Point");
    pu.getFormu().getChamp("idTypeMagasin").setAutre("readonly");
    pu.getFormu().getChamp("idTypeMagasin").setLibelle("Type magasin");
    String lien = (String) session.getValue("lien");
    String id=pu.getBase().getTuppleID();
    pu.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=magasin/magasin-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
                    </div>
                    <form action="<%= lien %>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pu.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br>
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
                        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
