<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="bean.CGenUtil" %>
<%@page import="bean.TypeObjet" %>
<%
    String lang = String.valueOf(session.getAttribute("lang"));
    String[] mots = {"Generer etats", "Exercice", "Type de compte", "Type etat", "Mois debut", "Mois fin", "Du compte", "Au compte", "Afficher"};
    String[] ret = Utilitaire.transformerLangue(mots, lang);

    TypeObjet typeCompte, lsTypeCompte[];
    typeCompte = new TypeObjet();
    typeCompte.setNomTable("compta_type_compte");
    lsTypeCompte = (TypeObjet[]) CGenUtil.rechercher(typeCompte, null, null, "");
%>
<script>

    function ecranBalanceCompteGeneral() {
        var date1, date2, plage1, plage2, exercice, typecompte, url, typeetat;
        date1 = $('#mois1').val();
        date2 = $('#mois2').val();
        plage1 = $('#plage1').val();
        plage2 = $('#plage2').val();
        exercice = $('#exercice').val();
        typecompte = $('#typecompte').val();
        typeetat = $('#typeetat').val();
        etat = $('#etat').val();
        if (date1 != '' && date2 != '') {
            if (typeetat == '1') {
                url = 'compta/etat/balance-compta-general.jsp?moisDebut=' + date1 + '&moisFin=' + date2 + '&debutCompte=' + plage1 + '&finCompte=' + plage2 + '&exercice=' + exercice + '&typeCompte=' + typecompte + '&etat=' + etat;
                window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
            }
            if (typeetat == '2') {
                if (plage1 != '' && plage2 != '') {
                    url = 'compta/etat/grand-livre-compte.jsp?moisDebut=' + date1 + '&moisFin=' + date2 + '&compteDebut=' + plage1 + '&compteFin=' + plage2 + '&exercice=' + exercice + '&typeCompte=' + typecompte + '&etat=' + etat;
                    window.open(url, "", "titulaireresizable=no,scrollbars=yes,location=no,width=1009,height=532,top=0,left=0");
                } else {
                    alert('Champ compte manquant.');
                }
            }
        } else {
            alert('Champ date manquant.');
        }
    }

    function focusOut(idinput) {
        var value = $("#" + idinput).val();
        if (value.trim() == "") {
            return;
        } else {
            var temp = value.split(":");
            $("#" + idinput).val(temp[0].trim());
        }
    }

    function findLibelleCompte(idinput) {
        $(document).on('keydown', '#' + idinput, function (e) {
            var keyCode = e.keyCode || e.which;

            if (keyCode == 9 || keyCode == 13) {
                var prest = $('#' + idinput).val();
                if (prest != null && prest.trim() != "") {
                    var temp = prest.split(":");
                    $('#' + idinput).val(temp[0].trim());
                }

            } else {
                var compte = "";
                var data = <%= session.getAttribute("comptaComptes")%>;
                $('#' + idinput).autocomplete({
                    source: function (request, response) {
                        var matches = $.map(data, function (acItem) {
                            if (acItem.toUpperCase().indexOf(request.term.toUpperCase()) === 0) {
                                return acItem;
                            }
                        });
                        response(matches);
                    },
                    minLength: 0,
                    select: function (e, ui) {
                        var selectedObj = ui.item;
                        var prest = selectedObj.value;
                        var temp = prest.split(":");
                        compte = temp[0].trim();
                        $("#" + idinput).val(compte);

                    }
                });
            }
        });
    }
</script>
<div class="content-wrapper">
    <div class="row">
        <div class="row col-md-12">
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h1 class="box-title"><%=ret[0]%>
                    </h1>
                </div>
                <div class="box-body">
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="Exercice"><%=ret[1]%>
                        </label>
                        <input type="text" id="exercice" name="exercice" class="form-control"
                            value="<%= Utilitaire.getAnneeEnCours()%>">
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="typecompte"><%=ret[2]%>
                        </label>
                        <select name="typecompte" id="typecompte" class="form-control">
                            <option value="1">G&eacute;n&eacute;ral</option>
                            <option value="2">Analytique</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="typeetat"><%=ret[3]%>
                        </label>
                        <select name="typeetat" id="typeetat" class="form-control">
                            <option value="1">Balance</option>
                            <option value="2">Grand Livre</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="etat">Etat</label>
                        <select name="etat" id="etat" class="form-control">
                            <option value="0">Tous</option>
                            <option value="11">Visee</option>
                            <option value="1">Non Visee</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="mois1"><%=ret[4]%>
                        </label>
                        <select name="mois1" id="mois1" class="form-control">
                            <option value="1">Janvier</option>
                            <option value="2">Fevrier</option>
                            <option value="3">Mars</option>
                            <option value="4">Avril</option>
                            <option value="5">Mai</option>
                            <option value="6">Juin</option>
                            <option value="7">Juillet</option>
                            <option value="8">Aout</option>
                            <option value="9">Septembre</option>
                            <option value="10">Octobre</option>
                            <option value="11">Novembre</option>
                            <option value="12">Decembre</option>
                        </select>

                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="mois2"><%=ret[5]%>
                        </label>
                        <select name="mois2" id="mois2" class="form-control">
                            <option value="1">Janvier</option>
                            <option value="2">Fevrier</option>
                            <option value="3">Mars</option>
                            <option value="4">Avril</option>
                            <option value="5">Mai</option>
                            <option value="6">Juin</option>
                            <option value="7">Juillet</option>
                            <option value="8">Aout</option>
                            <option value="9">Septembre</option>
                            <option value="10">Octobre</option>
                            <option value="11">Novembre</option>
                            <option value="12">Decembre</option>
                        </select>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="plage1"><%=ret[6]%>
                        </label>
                        <input id="plage1" name="plage1" onkeypress="findLibelleCompte('plage1')"
                            onfocusout="focusOut('plage1')" class="form-control" type="text"/>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12 p-1">
                        <label for="plage2"><%=ret[7]%>
                        </label>
                        <input id="plage2" name="plage2" onkeypress="findLibelleCompte('plage2')"
                            onfocusout="focusOut('plage2')" class="form-control" type="text"/>
                    </div>
                    <div class="form-group p-1 col-lg-12 col-md-12 col-sm-12 d-flex justify-content-end align-items-center filter-option " >
                        <a class="btn btn-apj-secondary pull-right" type="submit"
                        onclick="ecranBalanceCompteGeneral()" style="background-color:#fff; color:rgba(28,38,61,255); box-shadow: rgba(136, 165, 191, 0.48) 6px 2px 16px 0px, rgba(255, 255, 255, 0.8) -6px -2px 16px 0px;"><%=ret[8]%>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>