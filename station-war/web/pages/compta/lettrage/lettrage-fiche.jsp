<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="mg.cnaps.compta.ComptaSousEcriture"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="mg.cnaps.compta.ComptaLettrage"%>
<%@ page import="affichage.Onglet" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
    ComptaLettrage lettrage;
    UserEJB u;
%>
<%
try{
    u = (UserEJB) session.getAttribute("u");
    lettrage = new ComptaLettrage();
    String[] libelleLettrageFiche = {"id", "lettre", "date_lettrage", "montant", "Remarque", "iduser", "etat"};
    PageConsulte pc = new PageConsulte(lettrage, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    pc.setLibAffichage(libelleLettrageFiche);
    pc.getChampByName("iduser").setVisible(false);
    pc.setTitre("Fiche Lettrage");


    String tabDefault="sousecriture-liste";
    Onglet onglet =  new Onglet(tabDefault);
    onglet.setDossier("inc");
    Map<String, String> listePage = new HashMap<String, String>();
    Map<String, String> listeNumero = new HashMap<String,String>();
    listePage.put(tabDefault,"");
    listeNumero.put("1",tabDefault);
    onglet.setListePage(listePage);
    onglet.setListeNumero(listeNumero);
    String tab = request.getParameter("tab");
    String currentTab = onglet.getCurrentPage(tab);

    String lien = (String) session.getValue("lien");
    String bute=request.getParameter("but");
    String id=pc.getBase().getTuppleID();

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=compta/lettrage/lettrage-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                               <a class="btn btn-apj-warning"
                                   href="<%=(String) session.getValue("lien") + "?but=compta/lettrage/apres.jsp&id=" + request.getParameter("id")%>&acte=delete&bute=compta/lettrage/lettrage-liste.jsp&classe=mg.cnaps.compta.ComptaLettrage"
                                    style="margin-right: 10px">D&eacute;lettrer
                                </a>                       
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <ul class="nav nav-tabs">
                <li class="<%= listePage.get("sousecriture-liste") %>">
                    <a class="" aria-current="page" href="<%= lien %>?but=<%= bute %>&id=<%= pc.getBase().getTuppleID() %>&tab=1">Liste des sous-écritures</a>
                </li>
            </ul>
            <div class="tab-content">       
                   <jsp:include page="<%= currentTab %>" >
                        <jsp:param name="lettrage" value="<%= id %>" />
                    </jsp:include>
                </div>
        </div>
    </div>
</div>


<%--    <%out.println(pc.getBasPage());%>--%>
<%
    }catch (Exception e){
        e.printStackTrace();
        throw e;
    }
%>