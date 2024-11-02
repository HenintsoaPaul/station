<!-- jQuery 2.1.4 -->

<!--<script src="${pageContext.request.contextPath}/assets/js/socket.io/socket.io.js"></script>-->
<script src="${pageContext.request.contextPath}/assets/js/moment.min.js"></script>


<!-- jQuery UI 1.11.4 -->
<script src="${pageContext.request.contextPath}/dist/js/jquery-ui.min.js" type="text/javascript"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script type="text/javascript">
    $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.2 JS -->
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/dataTables.bootstrap.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.tablesorter.min.js" type="text/javascript"></script>
<!-- Morris.js charts -->
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/morris/morris.min.js" type="text/javascript"></script>-->
<!-- Sparkline -->
<!--<script src="${pageContext.request.contextPath}/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>-->
<!-- jvectormap -->
<!--<script src="${pageContext.request.contextPath}/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>-->
<!-- jQuery Knob Chart -->
<!--<script src="${pageContext.request.contextPath}/plugins/knob/jquery.knob.js" type="text/javascript"></script>-->
<!-- daterangepicker -->
<!--<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js" type="text/javascript"></script>-->
<script src="${pageContext.request.contextPath}/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
<!-- datepicker -->
<script src="${pageContext.request.contextPath}/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/plugins/timepicker/bootstrap-timepicker.min.js" type="text/javascript"></script>
<!-- Bootstrap WYSIHTML5 -->
<!--<script src="${pageContext.request.contextPath}/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
<!-- Slimscroll -->
<script src="${pageContext.request.contextPath}/plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/plugins/fastclick/fastclick.min.js" type="text/javascript"></script>
<!-- ChartJS 1.0.1 -->
<script src="${pageContext.request.contextPath}/assets/js/Chart.min.js" type="text/javascript"></script>
<%--<script src="${pageContext.request.contextPath}/plugins/chartjs/Chart.min.js" type="text/javascript"></script>--%>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/dist/js/app.min.js" type="text/javascript"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!--<script src="${pageContext.request.contextPath}/dist/js/pages/dashboard.js" type="text/javascript"></script>-->
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!--<script src="${pageContext.request.contextPath}/dist/js/pages/dashboard2.js" type="text/javascript"></script>-->
<!-- AdminLTE for demo purposes -->
<!--<script src="${pageContext.request.contextPath}/dist/js/demo.js" type="text/javascript"></script>-->
<!-- Parsley -->
<script src="${pageContext.request.contextPath}/plugins/parsley/src/i18n/fr.js"></script>
<script src="${pageContext.request.contextPath}/plugins/parsley/dist/parsley.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/sparkline/jquery.sparkline.min.js"></script>
<script src="${pageContext.request.contextPath}/plugins/bootstrap-notify/bootstrap-notify.min.js"></script>

<script type="text/javascript">
    window.ParsleyValidator.setLocale('fr');
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy'
    });
//    $(".timepicker").timepicker({
//        showInputs: false
//    });

    $(window).bind("load", function () {
//        getMessageDeploiement();
//        window.setInterval(getMessageDeploiement, 30000);
    });

    function getMessageDeploiement() {
        var text = 'ok';
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/MessageDeploiement',
            contentType: 'application/json',
            data: {'mes': text},
            success: function (ma) {
                if (ma != null) {
                    var data = JSON.parse(ma);
                    if (data.message != null) {
                        alert(data.message);
                    }
                    if (data.erreur != null) {
                        alert(data.erreur);
                    }
                }

            },
            error: function (e) {
                //alert("Erreur Ajax");
            }

        });
    }

    function pagePopUp(page, width, height) {
        w = 750;
        h = 600;
        t = "D&eacute;tails";

        if (width != null || width == "")
        {
            w = width;
        }
        if (height != null || height == "") {
            h = height;
        }
        window.open(page, t, "titulaireresizable=no,scrollbars=yes,location=no,width=" + w + ",height=" + h + ",top=0,left=0");
    }
    function searchKeyPress(e)
    {
        // look for window.event in case event isn't passed in
        e = e || window.event;
        if (e.keyCode == 13)
        {
            document.getElementById('btnListe').click();
            return false;
        }
        return true;
    }
    function back() {
        history.back();
    }
    function dependante(valeurFiltre,champDependant,nomTable,nomClasse,nomColoneFiltre,nomColvaleur,nomColAffiche)
    {
        console.out.println("NIDITRA TATO");
        document.getElementById(champDependant).length=0;
        var param = {'valeurFiltre':valeurFiltre,'nomTable':nomTable,'nomClasse':nomClasse,'nomColoneFiltre':nomColoneFiltre,'nomColvaleur':nomColvaleur,'nomColAffiche':nomColAffiche};
        var lesValeur=[new Option("-","",false,false)];  
        $.ajax({
            type:'GET',
            url:'/prospection/deroulante',
            contentType: 'application/json',
            data:param,
            success:function(ma){
                var data = JSON.parse(ma);   
                
                for(i in data.valeure)
                {
                    lesValeur.push(new Option(data.valeure[i].valeur, data.valeure[i].id, false, false));
                }
                addOptions(champDependant,lesValeur);
            },
            error:function(ma){
                console.log(ma);
            }
        });


    }
    function getChoix() {
        setTimeout("document.frmchx.submit()", 800);
    }
    $('#sigi').DataTable({
        "paging": false,
        "lengthChange": false,
        "searching": false,
        "ordering": true,
        "info": false,
        "autoWidth": false
    });
    $(function () {
        $(".select2").select2();
        $("#example1").DataTable();
        $('#example2').DataTable({
            "paging": true,
            "lengthChange": false,
            "searching": false,
            "ordering": true,
            "info": true,
            "autoWidth": false
        });
    });
    function CocheToutCheckbox(ref, name) {
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
    function showNotification(message, classe, url) {
        $.notify({
            message: message,
            url: url
        }, {
            type: classe
        });
    }
    function add_line() {
        var indexMultiple = document.getElementById('indexMultiple').value;
        var nbrLigne = document.getElementById('nbrLigne').value;
        var html = genererLigneFromIndex(indexMultiple);
        $('#ajout_multiple_ligne').append(html);
        document.getElementById('indexMultiple').value = parseInt(indexMultiple) + 1;
        document.getElementById('nbrLigne').value = parseInt(nbrLigne) + 1;
    }
    function removeLineByIndex(iLigne) {
        var nomId = "ligne-multiple-" + iLigne;

        var ligne = document.getElementById(nomId);
        ligne.parentNode.removeChild(ligne);
        var nbrLigne = document.getElementById('nbrLigne').value;
        //document.getElementById('nbrLigne').value = nbrLigne - 1;
    }

    function getHtmlTabeauLigne() {
        var htmlComplet = $('#tableauLigne').html();
        document.getElementById('htmlComplet').value = htmlComplet;
        $('#declarationFormulaire').submit();


    }

    function changeInput(input) {
//        alert(input.id);
//        document.getElementById(input.id).value = ;
        $('#' + input.id).attr('value', input.value);
    }
    function dependante(valeurFiltre, champDependant, nomTable, nomClasse, nomColoneFiltre, nomColvaleur, nomColAffiche)
    {
        document.getElementById(champDependant).length = 0;
        var param = {'valeurFiltre': valeurFiltre, 'nomTable': nomTable, 'nomClasse': nomClasse, 'nomColoneFiltre': nomColoneFiltre, 'nomColvaleur': nomColvaleur, 'nomColAffiche': nomColAffiche};
        var lesValeur=[new Option("-","",false,false)];  
        $.ajax({
            type: 'GET',
            url: '/prospection/deroulante',
            contentType: 'application/json',
            data: param,
            success: function (ma) {
                var data = JSON.parse(ma);

                for (i in data.valeure)
                {
                    lesValeur.push(new Option(data.valeure[i].valeur, data.valeure[i].id, false, false));
                }
                addOptions(champDependant, lesValeur);
            }
        });


    }
    function addOptions(nomListe, lesopt)
    {
        var List = document.getElementById(nomListe);
        var elOption = lesopt;

        var i, n;
        n = elOption.length;

        for (i = 0; i < n; i++)
        {
            List.options.add(elOption[i]);
        }
    }
    function dependanteChamp(valeurFiltre, champDependant, nomTable, nomClasse, nomColoneFiltre, nomColvaleur, nomColAffiche, nomOrderby, sensOrderBy)
    {
        $('#' + champDependant + " option").remove();
        var param = {'valeurFiltre': valeurFiltre, 'nomTable': nomTable, 'nomClasse': nomClasse, 'nomColoneFiltre': nomColoneFiltre, 'nomColvaleur': nomColvaleur, 'nomColAffiche': nomColAffiche, 'nomOrderby': nomOrderby, 'sensOrderBy': sensOrderBy};
        var valeur = "";
        $.ajax({
            type: 'GET',
            url: '/spat/deroulante',
            contentType: 'application/json',
            data: param,
            success: function (ma) {
                var data = JSON.parse(ma);

                for (i in data.valeure)
                {
                    valeur += data.valeure[i].valeur;
                }
                console.log(valeur);
                addChamp(champDependant, valeur);
            }
        });


    }
    function addChamp(nomListe, valeur)
    {
        document.getElementById(nomListe).value = valeur;

    }
    function dependanteChampUneValeur(valeurFiltre, champDependant, nomTable, nomClasse, nomColoneFiltre, nomColvaleur, nomColAffiche, nomOrderby, sensOrderBy)
    {
        $('#' + champDependant + " option").remove();
        var param = {'valeurFiltre': valeurFiltre, 'nomTable': nomTable, 'nomClasse': nomClasse, 'nomColoneFiltre': nomColoneFiltre, 'nomColvaleur': nomColvaleur, 'nomColAffiche': nomColAffiche, 'nomOrderby': nomOrderby, 'sensOrderBy': sensOrderBy};
        var valeur = "";
        $.ajax({
            type: 'GET',
            url: '/spat/deroulante?estListe=false',
            contentType: 'application/json',
            data: param,
            success: function (ma) {
                var data = JSON.parse(ma);

                for (i in data.valeure)
                {
                    valeur += data.valeure[i].valeur;
                }
                addChamp(champDependant, valeur);
            }
        });


    }
</script>
<script src="${pageContext.request.contextPath}/assets/js/script.js" type="text/javascript"></script>

<script src="${pageContext.request.contextPath}/assets/js/controleTj.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/apjplugins/champcalcul.js" defer></script>

<script src="${pageContext.request.contextPath}/assets/js/soundmanager2-jsmin.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/assets/js/messagews.js" type="text/javascript"></script>
<script type="text/javascript">
    if (typeof (Storage) !== "undefined") {
        // Code for localStorage/sessionStorage.
        var collapse = localStorage.getItem("menuCollapse");

    } else {
        // Sorry! No Web Storage support..
    }
    $(document).ready(function () {

        if (localStorage.getItem("menuCollapse") == "true") {
            $("body").addClass("sidebar-collapse");
        }

        $(".sidebar-toggle").click(function () {
            if (localStorage.getItem("menuCollapse") == "false" || localStorage.getItem("menuCollapse") == "") {
                localStorage.setItem("menuCollapse", "true");
            } else {
                localStorage.setItem("menuCollapse", "false");
            }
        });

        //TAB INDEX
        var tab = $("[tabindex]");
        for (var i = 0; i < tab.length; i++) {
            $(tab[i]).removeAttr("tabindex");
        }
        var nombre_form = $($("form")[1]).length;

        for (var f = 0; f < nombre_form; f++) {
            var id_index = 1;

            var new_elm = $($("form")[1])[f];

            for (var i = 0; i < new_elm.length; i++) {
                if ($(new_elm[i]).context.type === "hidden" || $(new_elm[i]).context.readOnly) {

                } else {
                    $(new_elm[i]).attr("tabindex", id_index);
                    id_index++;
                }

            }
        }

    });
		
		
		
		
		function fetchAutocomplete(request, response, affiche, valeur, colFiltre, nomTable, classe,useMocle,champRetour) {
		if (request.term.length >= 1) {
				$.ajax({
						url: "/station/autocomplete",
						method: "GET",
						contentType: "application/x-www-form-urlencoded",
						dataType: "json",
						data: {
								libelle: request.term,
								affiche: affiche,
								valeur: valeur,
								colFiltre: colFiltre,
								nomTable: nomTable,
								classe: classe,
								useMotcle:useMocle,
                                champRetour: champRetour
						},
						success: function(data) {
								response($.map(data.valeure, function(item) {
										return {
												label: item.valeur,
												value: item.id,
                                                retour: item.retour
										};
								}));
						}
				});
		}
		}


</script>
<script language="javascript">
    (function ($) {
        var title = ($('h1:first').text());
        if (title === '' || title == null)
            title = ($('h2:first').text());
        if (title === '' || title == null)
            title = 'ERP';
        document.title = title;
    }(jQuery));
</script>