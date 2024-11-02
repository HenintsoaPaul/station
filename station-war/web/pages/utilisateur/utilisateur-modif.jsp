
<%@page import="utilisateurstation.UtilisateurStation"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@page import="utilisateur.Role"%>

<%try{
    String refuser = request.getParameter("refuser");
    String autreparsley = "data-parsley-range='[8, 40]' required";
    
    UtilisateurStation utilisateur = new UtilisateurStation();
    PageInsert pi = new PageUpdate(utilisateur, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    UserEJB u = (UserEJB) session.getAttribute("u");
    pi.getFormu().getChamp("loginuser").setLibelle("login");
    pi.getFormu().getChamp("pwduser").setLibelle("Mot de passe");
       
        //pi.getFormu().getChamp("pwduser").setValeur("");
        pi.getFormu().getChamp("idrole").setLibelle("Ro&#770;le");
        pi.getFormu().getChamp("nomuser").setLibelle("Nom et pr&eacute;nom");
        pi.getFormu().getChamp("teluser").setLibelle("Numéro de téléphone");

         pi.getFormu().getChamp("pwduser").setLibelle("Mot de passe");
        pi.getFormu().getChamp("pwduser").setValeur("");
        pi.getFormu().getChamp("pwduser").setType("password");
        
       // pi.getFormu().getChamp("idrole").setAutre("readonly");
//        pi.getFormu().getChamp("adruser").setValeur(art.getAdruser());
        pi.getFormu().getChamp("adruser").setAutre("readonly");
      
        
        affichage.Champ[] liste = new affichage.Champ[1];
        
       

        Role role = new Role();
        liste[0] = new Liste("idrole", role, "descrole", "idrole");
        
        pi.getFormu().changerEnChamp(liste);
        
     
        pi.getFormu().getChamp("idrole").setLibelle("Ro&#770;le");
    
        
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification Utilisateur</h1>
                    <form action="<%=(String) session.getValue("lien")%>?but=apresTarif.jsp" method="post" name="recettebordereau" id="recettebordereau">
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
                          <input name="idUser" type="hidden" id="idUser" value="<%=refuser%>">
                      <input name="bute" type="hidden" id="bute" value="utilisateur/utilisateur-fiche.jsp&refuser=<%=refuser%>">
                        <input name="classe" type="hidden" id="classe" value="utilisateurstation.UtilisateurStation">
                        <input name="nomtable" type="hidden" id="nomtable" value="utilisateur">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>