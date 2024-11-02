<%@page import="affichage.PageInsert"%>
<%@page import="historique.MapRoles"%>

<%    String autreparsley = "data-parsley-range='[8, 40]' required";
    MapRoles ic = new MapRoles();
    PageInsert pi = new PageInsert(ic, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    // pi.preparerDataFormu();
%>

<div class="content-wrapper">
    <h1 align="center">profil/Rôle</h1>


    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="condamnation" id="condamnation" data-parsley-validate>
        <div class="box box-primary">
            <div class="box-body">
                <table border="1" class="table table-bordered">
                    <thead>
                        <tr>
                            <th></th>
                            <th>

                                <input name="acte" type="hidden" id="nature" value="insert">
                                <input name="bute" type="hidden" id="bute" value="utilisateur/role-liste.jsp">
                                <input name="classe" type="hidden" id="classe" value="historique.MapRoles">
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Role:</td>
                            <td><input name="idrole" class="form form-control" type="text" id="idrole" ></td>
                        </tr>
                        <tr>
                            <td>Libelle:</td>
                            <td> <input name="descrole" class="form form-control" type="text" id="descrole"></td>
                        </tr>
                        <tr>
                            <td>Rang:</td>
                            <td><input name="rang" class="form form-control" type="number" id="rang"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><span class="pull-right"><input  type="reset" class="btn btn-danger" value="Annuler"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="pull-right"><input  type="submit" class="btn btn-success" value="Ajouter"></span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="box-footer">
            </div>
        </div>

    </form>
</div>

