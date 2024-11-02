

<%@page import="mg.cnaps.compta.ComptaCompte"%>
<%@page import="magasin.Magasin"%>
<%@page import="caisse.Caisse"%>
<%@page import="caisse.CategorieCaisse"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@page import="caisse.TypeCaisse"%>
<%@page import="annexe.Point"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Caisse t = new Caisse();

    String  mapping = "caisse.Caisse",
          nomtable = "station-ejb/src/java/caisse",
          apres = "station-ejb/src/java/caisse/caisse-fiche.jsp",
          titre = "Modification caisse";


    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre("Modification caisse");
    pu.getFormu().getChamp("id").setAutre("readonly");
    pu.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pu.getFormu().getChamp("desce").setLibelle("Description");
   Liste[] liste = new Liste[6];
        TypeCaisse type = new TypeCaisse();
        type.setNomTable("TYPECAISSE");
        liste[0] = new Liste("idTypeCaisse",type,"val","id");
        Point point = new Point();
        point.setNomTable("point");
        liste[1] = new Liste("idPoint",point,"val","id");
        Magasin magasin = new Magasin();
        magasin.setNomTable( "station-ejb/src/java/magasin" );
        liste[2] = new Liste("idMagasin",magasin,"val","id");
        CategorieCaisse categ = new CategorieCaisse();
        categ.setNomTable("CategorieCaisse");
        liste[3] = new Liste("idCategorieCaisse",categ,"val","id");
				ComptaCompte compta = new ComptaCompte();
        compta.setNomTable("COMPTA_COMPTE_LIB");
				pu.getFormu().getChamp("compte").setDefaut("COC007913");
        liste[4] = new Liste("compte",compta,"compte","id");

				liste[5] = new Liste("idDevise",new caisse.Devise(),"val","id");
        liste[5].setDefaut("AR");
    pu.getFormu().changerEnChamp(liste);
    pu.getFormu().changerEnChamp(liste);
    pu.getFormu().getChamp("idTypeCaisse").setLibelle("Type");
    pu.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pu.getFormu().getChamp("idCategorieCaisse").setLibelle("Categorie");
    pu.getFormu().getChamp("Etat").setVisible(false);
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
                        <h1 class="box-title"><a href=<%= lien + "?but=annexe/unite/unite-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
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
