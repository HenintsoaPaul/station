<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@page import="javax.ejb.ConcurrentAccessTimeoutException"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.messagecommunication.Message"%>
<%@page import="historique.MapUtilisateur"%>

<%@page import="user.UserEJB"%>
<%@ page import="bean.Constante" %>
<%
    HttpSession sess = request.getSession();
    String lang = "fr";
%>  
<%
    String lien = (String) session.getValue("lien");
    try {
        UserEJB ue = (UserEJB) session.getValue("u");
        MapUtilisateur u = ue.getUser();
        String receiver = u.getTeluser();
        MapUtilisateur map = ue.getUser();
        String awhere = " and receiver='" + receiver + "' ";
        String home_page=ue.getHome_page();
        MapUtilisateur[] u2 = (MapUtilisateur[]) (CGenUtil.rechercher(new MapUtilisateur(), null, null, ""));
%>
<script>
    function verifEditerTef(et, name){
    if (et < 11){
    alert('Impossible d\'editer Tef. ' + name + ' non vis� ');
    } else{
    document.tef.submit();
    }
    }
    function verifLivraisonBC(et){
    if (et < 11){
    alert('Impossible d effectuer la livraison du bon de commande');
    } else{
    document.tef.submit();
    }
    }
    function CocherToutCheckBox(ref, name) {
    var form = ref;
    while (form.parentNode && form.nodeName.toLowerCase() != 'form') {
    form = form.parentNode;
    }

    var elements = form.getElementsByTagName('input');
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].type == 'checkbox' && elements[i].name == name) {
            elements[i].checked = ref.checked;
        }
    }
    }
    
</script>
<style type="text/css">
  
    .breadcrumb {
        padding-left: 20px;
    }
    
</style>
<header class="main-header" style="position: fixed; left: 0; right: 0;">
    <!-- Logo -->
            <a style="background-color:#ffffff; height:50px;" href="<%=lien%>?but=<%=home_page%>" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->

                    <span class="logo-mini" style="color: <%=Constante.constanteCouleur%>;font-weight: 600;">Gallois</span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg">  <img style="width: 45px;height: 45px;" src="${pageContext.request.contextPath}/assets/img/logo_sisal-rmbg.png"/> </span>
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav style="background:#ffffff;  height: 10px;" class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" style="color:<%=Constante.constanteCouleur%>" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="hidden-xs" style="color:<%=Constante.constanteCouleur%>"><%=map.getLoginuser()%></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- Menu Body -->
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-right">
                                        <a href="deconnexion.jsp" class="btn btn-default btn-flat">D&eacute;connexion</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
            
</header>
                    
            <div class="modal fade" id="modalSendMessage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="message-chat-title"></h4>
                        </div>
                        <div class="modal-body clearfix">
                            <div class="message-chat-content clearfix" id="message-chat-content">

                            </div>
                            <br/>
                            <form>
                                <textarea id="messagefrom" onkeypress="keypressedsendMessage(this, 1)" class="form-control" rows="3" placeholder="Votre message ici" ></textarea>
                                <br/><br/>
                                <input type="button" class="btn btn-primary pull-right" style="margin-left: 5px;" onclick="keypressedsendMessage(this, 2)" value="Envoyer"/>
                                <input type="reset" class="btn btn-danger pull-right" value="Annuler"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalSendMessageTo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="min-height: 200px">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <ul  > <%
                                for (MapUtilisateur utilisateur : u2) {%>
                            <li class="fa fa-envelope-o "> 
                                    <a href="module.jsp?but=notification/message-envoi.jsp&to=<%=utilisateur.getTeluser()%>"> <%=utilisateur.getNomuser()%></a> 
                          
                            </li><br/>
                            <%}
                            %>
                            </ul>
                        </div>
                        
                    </div>
                </div>
            </div>

            <%
                } catch (ConcurrentAccessTimeoutException e) {
                    out.println("<script language='JavaScript'> document.location.replace('/cnaps-war/');</script>");
                }
            %>
