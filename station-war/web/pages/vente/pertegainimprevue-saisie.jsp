<%--
    Document   : pertegainimprevue-saisie
    Created on : 30 juil. 2024, 22:04:24
    Author     : drana
--%>

<%@page import="affichage.PageInsert"%>
<%@page import="pertegain.TypePerteGain"%>
<%@page import="user.UserEJB"%>
<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "pertegain.TypePerteGain",
            nomtable = "TYPEGAINPERTE",
            apres = "station-ejb/src/java/vente/pertegainimprevue-saisie.jsp",
            titre = "Enregistrement de nouveau type Perte-Gain";

    TypePerteGain  categorie = new TypePerteGain();
    PageInsert pi = new PageInsert(categorie, request, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("desce").setLibelle("Compte");
    pi.getFormu().getChamp("estdoubleecriture").setVisible(false);
    pi.getFormu().getChamp("desce").setPageAppelComplete("annexe.Produit", "id","Produit");


    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <%
    if(request.getParameter("id")!=null)
    { %>
    <div class="row"
             <div class="row col-md-12">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="row" style="color: green; font-weight: 800;" >

                    <h3><i> Enregistrement bien &eacute;ffectu&eacute;e</i> </h3>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>

    <% }
    %>
    <br>
       <div class="row"
            <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
                    <%
                        pi.getFormu().makeHtmlInsertTabIndex();
                        out.println(pi.getFormu().getHtmlInsert());
                    %>
                    <input name="acte" type="hidden" id="nature" value="insert">
                    <input name="bute" type="hidden" id="bute" value="<%=apres%>">
                    <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
                    <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
            </form>
    </div>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>
