<%@page import="bean.CGenUtil"%>
<%@page import="bean.UploadPj"%>
<%@ page import="web.filemanager.StringUtil" %>
<%
    try{
    String id = request.getParameter("id");
    if(request.getParameter("idDir")!=null && request.getParameter("idDir").compareTo("")!=0){
        id=request.getParameter("idDir");
    }
    String nomtable = request.getParameter("nomtable");
    UploadPj criteria = new UploadPj(nomtable);
    UploadPj[] listeUploaded = (UploadPj[]) CGenUtil.rechercher(criteria, null, null, " AND MERE = '" + id + "'");
    configuration.CynthiaConf.load();
    String lien=(String) session.getValue("lien");
    lien="pages/"+lien;
    int taille = 1;
    String path = (String) request.getServletContext().getAttribute(StringUtil.FILES_DIR);
    path=path.replace("\\","/");
    String dossier=request.getParameter("dossier");
%>
<div class="content-wrapper">
    <div class="row pt-5">
        <div class="col-md-offset-3 col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h2 class="box-title" style="margin-left: 10px;">Les fichiers d&eacute;j&agrave; attach&eacute;s</h2>
                    </div>
                    <div class="box-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="background-color:#bed1dd;">Libell&eacute;</th>
                                    <th style="background-color:#bed1dd;">Fichier</th>
                                    <th style="background-color:#bed1dd;">Voir</th>
                                    <th style="background-color:#bed1dd;">#</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%if (listeUploaded != null && listeUploaded.length > 0) {
                                        for (UploadPj element : listeUploaded) {%>
                                <tr>
                                    <td><%=utilitaire.Utilitaire.champNull(element.getLibelle())%></td>
                                    <td><%=element.getChemin()%></td>
<%--                                    <td><a href="#" class="btn btn-primary" onclick="pagePopUp('<%= path+"/"+ request.getParameter("dossier") +"/"+ element.getChemin()%>',name='_blank')">Voir</a></td>--%>
                                    <td><a href="${pageContext.request.contextPath}/FileManager?parent=<%= dossier+"/"+element.getChemin() %>" class="btn btn-primary">Voir</a></td>
<%--                                    <td><a class="btn btn-danger" href="../DeletePj?but=<%=request.getParameter("but")%>&idpj=<%=element.getId()%>&id=<%=id%>&idDir=<%=id%>&nomtable=<%=request.getParameter("nomtable")%>&bute=<%=request.getParameter("bute")+"&idCommande="+request.getParameter("idCommande")+"&idDemandeCotation="+request.getParameter("idDemandeCotation")+"&idGroupeCommande="+request.getParameter("idGroupeCommande")%>&procedure=<%=request.getParameter("procedure")%>&enfant=<%=request.getParameter("enfant")%>">supprimer</a></td>--%>
                                </tr>
                                <%}
                                } else {%>
                                <tr><td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td></tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="box">
                    <div class="box-title with-border">
                        <h4 class="box-title" style="margin-left: 10px">Uploader des fichiers pour l'identifiant : <%=id%></h4>
                        <h5 class="box-title" style="margin-left: 10px">Formats acc&eacute;pt&eacute;es : pdf, excel, jpg</h5>
                    </div>
                    <div class="box-body">                        
                        <form action="../UploadDownloadFileServlet?dossier=<%=request.getParameter("dossier")%>" method="POST" enctype="multipart/form-data">
                            <div id="uploadapj">
                                <div class="form-group">
                                    <div class="col-xs-7" style="margin-right: -15px;">
                                        <input type="text" name="libelle<%=taille%>" placeholder="Titre" class="form-control" style="height: 30px;" multiple="true">
                                    </div>
                                    <div class="col-xs-5" style="margin-left: -15px;">
                                        <div class="input-group">
                                            <input type="file" name="fichiers<%=taille%>" class="form-control" style="height: 30px;" multiple="true">
                                            <div class="input-group-addon" onclick="removeLine(this)"><i class="fa fa-remove"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <input type="hidden" name="nomtable" value="<%=request.getParameter("nomtable")%>">
                            <input type="hidden" name="procedure" value="<%=request.getParameter("procedure")%>">
                            <input type="hidden" name="bute" value="<%=request.getParameter("bute")%>">
                            <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                            <input type="hidden" name="idDir" value="<%=id%>">
                            <input type="hidden" name="lien" value="<%=lien%>">
                            <button type="button" class="btn btn-default pull-right" style="margin: 5px;" onclick="addLine()">Ajouter ligne(s)</button>
                            <button type="submit" class="btn btn-primary pull-right" style="margin: 5px;">Enregistrer</button>
                        </form>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function addLine() {
        <% taille++; %>
        var content = '<div class="form-group">'
                + '<div class="col-xs-7" style="margin-right: -15px;">'
                + '<input type="text" name="libelle<%=taille%>" class="form-control" multiple="true">'
                + '</div>'
                + '<div class="col-xs-5" style="margin-left: -15px;">'
                + '<div class="input-group">'
                + '<input type="file" name="fichiers<%=taille%>" class="form-control" multiple="true">'
                + '<div class="input-group-addon" onclick="removeLine(this)"><i class="fa fa-remove"></i></div>'
                + '</div>'
                + '</div>'
                + '</div>';
        $('#uploadapj').append(content);

    }
    function removeLine(obj) {
        $(obj).parent().parent().parent().remove();
    <% taille--;%>
    }
</script>
<%}catch(Exception ex){
        ex.printStackTrace();
        }%>