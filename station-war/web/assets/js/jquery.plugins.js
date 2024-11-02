var elClient="ctl00_CPHCorps_";
var etat=true;
var separateurMetier=":";
var separateurElementListe="|";
var separateurValeurListe="$";
var msgWait="";
$(document).ready(function(){

    //$("#Nom").addClass('test');
    //if(getNomClasse()!="")
    {
    $(":input[tabindex='1']").focus();

    //voir cas button
    $(":input[type!=submit]").keydown(function(e){
        //move(e,$(this));
        //var liste=new Array("1");
        //var t=sommeIntervalle(1,1);
        //alert(t);
    });

    $(":input[type!=submit][type!=button]").blur(function(e){
        //alert("blur e");
        //var ee=ajaxe("controler","{hoho:sasa}" );
        //alert(ee);
        //if(etat==true)controleSansNavig(e,$(this),0);
    });


    $(":input").focus(function() {

        $(this).select();

     });
   }

});


function prepareValues()
{
    var values = "{\"nothing\":null";

    $.each($(':input').serializeArray(), function(i, field) {

        var val = "\""+ field.value+"\"";
        if(val==null)
            val="null";
        values+=",\""+field.name.replace(elClient,"") +"\":" + val;
    });
    values+="}";
    return values;
}
function sendValue()
{
    var val = prepareValues();
    if(msgWait!="")
        openDivWait("divPleaseWait", "divPleaseWait", "", "", "650", "200",msgWait);
    $.ajax({
              type: "POST",
              //url: urls,
              url: window.location.href.split('?')[0] + "/save",
              //data: "{fd: '"+fd+"',codemaildossier: '"+cm+"'}",
              data: "{json: '" +val+"' }",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              error: function(msg){
                //e.prenventDefault();
                if(msgWait!="")
                    closeDiv("divPleaseWait", "");
                return false;
              }              ,
              success: function(msg) {
                if(msgWait!="")
                    closeDiv("divPleaseWait", "");
                eval(msg.d);
                return true;
              },
              timeout:5000,
              async: false
            });
}

function somme(listeTabIndex)
{
    return sommeBorne(listeTabIndex,0);
}
function sommeBorne(listeTabIndex,limite)
{
    var i=0;
    var somme=0;
    for(i=0;i<listeTabIndex.length-limite;i++)
    {
        var champ=$(":input[tabindex='"+Math.abs(listeTabIndex[i])+"']");
        var val=parseFloat(champ.val());
        if(parseInt(listeTabIndex[i])<0)
            somme=somme-val;
        else
            somme=somme+val;
    }
    return somme;
}

function sommeIntervalle(min,max)
{
    var liste=new Array();
    var i=0;
    for(i=min;i<=max;i++)
    {
        liste.push(i);
    }
    return somme(liste);
}
function move(evt,k){

        var e = evt ? evt : window.event;
        var keycode = e.which ? e.which : e.keyCode;

        if (keycode==40 || keycode==13)
        {
            if(keycode==13 || (keycode==40 &&  k.attr("type")!="select-one"))
            {
                //if(isNaN(parseFloat(k.attr("value")))==false)
                //{
                    //$(k).val(eval(k.attr("value")));
                //}
                controle(e,k,1);
            }
        }
        if (keycode==38)
        {
                if(k.attr("type")!="select-one"){
                    controle(e,k, -1);
                }
        }

    }
function getNomClasse()
{
    var nom=document.getElementById("nomClasse");
    if(nom==null || nom=="") return "";
    return nom.value;
}
function navigation(e,champ, pas){
tindex = parseInt(champ.attr("tabindex")) + pas;
    //test existence element
    if($(":input[tabindex='" + tindex + "']").length > 0){
        var i = $(":input[tabindex='" + tindex + "']");
        if(i.attr('disabled')==false){
            i.focus();
        }else{
            navigation(e,i, pas);
        }
    }
    e.preventDefault();

}
function testValideJS(champ)
{
    var classe = champ.attr("class");
    var ret="sasa";
    if(classe.length>0)
    {
        if(champ.attr("value").indexOf("=")!=-1)
        {
            var reste=champ.attr("value").substring(1,champ.attr("value").length);
            $(champ).val(eval(reste));
            //val = eval(val);
        }
        var val = champ.attr("value");
        var tabcss = getControl(classe,"validate");
        if(tabcss!=null) // if existence controle JS
        {
            for(i=0;i<tabcss.length;i++)
            {
                var nomfonction=tabcss[i];
                ret= eval(nomfonction+"('"+val+"')");
                $(champ).val(ret);
                //if(ret!=true)return ret;
            }
        }
    }
    return ret;

}
function controle(e, champ,pas)
{
    var testJs;
    var val;
    var resAjax=false;
    try
    {
        var classe = champ.attr("class");
        testJs=testValideJS(champ);
        {
            var name = champ.attr("name");
            var classeAppele=getNomClasse();
            if(classe.length>0)
            {
                var tabSomme=getControlSomme(champ.attr("class"),"somme");
                if(tabSomme!=null)
                {
                    var tabl=new Array();
                    var somm=sommeBorne(tabSomme,1);
                    var recepteur = $(":input[tabindex='" + tabSomme[tabSomme.length-1] + "']");
                    if(recepteur.length>0)
                    {
                        recepteur.val(somm);
                    }
                }
                 var tabcssmetier = getControl(champ.attr("class"),"chk");
                 if(tabcssmetier!=null)
                 {
                    val= champ.attr("value");
                    for(i=0;i<tabcssmetier.length;i++)
                    {
                        var indiceclasse = tabcssmetier[i];
                        var suiteArgument=getArgumentControleMetier(tabcssmetier[i]);
                        if(suiteArgument!=null && suiteArgument!="")
                        {
                            val=val+suiteArgument;
                        }
                        var indice=indiceclasse.indexOf("(");
                        if(indice!=-1)  indiceclasse=indiceclasse.substring(0,indice) ;
                        var param="{nomClasse: '"+classeAppele+"',champ: '" +name+"',valeur: '"+ val +"' }";
                        resAjax=ajax("controler"+indiceclasse,param, e, champ,pas );
                        if(resAjax==false)
                        {
                            e.preventDefault();
                        }
                    }
                 }
             }
         }
        if(resAjax==false)
        {
            var json = createRetour(true);
            traitementJson(json,e,champ,pas);
        }
    }
    catch(er)
    {
        jAlert(er,'Notification',function(rg){setFocusC(e,champ);});
        e.preventDefault();
    }

}
function controleSansNavig(e, champ,pas)
{
    var testJs=testValideJS(champ);
    var val = champ.attr("value");
    var resAjax=false;
    if(testJs==true)
    {
        var name = champ.attr("name");
        var classe = champ.attr("class");
        var classeAppele=getNomClasse();
        if(classe.length>0)
        {
         var tabcssmetier = getControl(champ.attr("class"),"chk");
         if(tabcssmetier!=null)
         {
            for(i=0;i<tabcssmetier.length;i++)
            {
                var indiceclasse = tabcssmetier[i];
                var param="{nomClasse: '"+classeAppele+"',champ: '" +name+"',valeur: '"+ val +"' }";
                resAjax=ajax("controler"+indiceclasse,param, e, champ,pas );
                preventDefaut(e);
            }
         }}
     }
     if(resAjax==false)
     {
        var json = createRetour(testJs);
        traitementJsonSansNavig(json,e,champ,0);
     }
}
function setFocusC(e,champ)
{
    $(champ).focus();
    preventDefaut(e);
}
function viderSelect(sel)
{
    if(sel!=null)
    {
        sel.options.length=0;
    }
}
function traitementJson(jsondata,event,champ,pas)
{
    var json =eval("("+jsondata+")") ;//retrieve result as an JavaScript object
    var success = json.Success;
    //alert(json);
    if(success==false)
    {
        jAlert(json.Message,'Notification',function(rg){setFocusC(event,champ);});
        event.preventDefault();
    }
    else
    {
        var ar = new Array();
        dict = json.FieldToModify;

        for(var i in dict)
        {
            var el=document.getElementById(i);
            if(el==null)
            {
                el=document.getElementById(elClient+i);
            }
            if(el!=null)
            {
                if(el.type=="select-one")
                {
                    var optione;
                    viderSelect(el);
                    var listeElement=dict[i].split(separateurElementListe);
                    if(listeElement!=null)
                    {
                        if(((listeElement.length==1)&&(listeElement[0].split(separateurValeurListe).length==2)&&(listeElement[0].split(separateurValeurListe)[1]=="s"))==false) viderSelect(el);
                        for(i=0;i<listeElement.length;i++)
                        {
                            var listeValeur=listeElement[i].split(separateurValeurListe);
                            if(listeValeur!=null)
                            {
                                if(((listeElement.length==1)&&(listeValeur.length==2)&&(listeValeur[1]=="s"))==true)
                                {
                                    for(g=0;g<el.length;g++)
                                    {
                                        if(el[g].value==listeValeur[0])
                                        {
                                            el.options[g].selected=true;
                                            break;
                                        }
                                    }
                                }
                                else
                                {
                                    if(listeValeur.length==1)
                                    {
                                        optione=new Option(listeValeur[0],listeValeur[0]);
                                    }
                                    if (listeValeur.length==2)
                                    {
                                        optione=new Option(listeValeur[0],listeValeur[1]);
                                    }
                                    if (listeValeur.length==3)
                                    {
                                        optione=new Option(listeValeur[0],listeValeur[1]);
                                        optione.selected=true;
                                    }
                                    el.options[i]=optione;
                                }
                            }
                        }
                    }
                }
                if(el.type=="text")
                {
                    el.value=dict[i];
                }
            }

        }
        navigation(event,champ,pas);
    }

}
function preventDefaut(e)
{
    if(e!=null)
        e.preventDefault();
}
function traitementJsonSansNavig(jsondata,event,champ,pas)
{
    var json =eval("("+jsondata+")") ;//retrieve result as an JavaScript object
    var success = json.Success;
    //alert(json);
    if(success==false)
    {
        etat=false;
        jAlert(json.Message,'Notification',function(rg){setFocusC(event,champ);});
        event.preventDefault();
    }
    else
    {
        var ar = new Array();
        ar = json.FieldToModify;
        for(var j in ar)
        {
            var dict = ar[j];
            for(var i in dict)
            {
                var el=document.getElementById(i);
                if(el==null)
                {
                    var elC=document.getElementById(elClient+i);
                    if(elC!=null) elC.Value=dict[i];
                }
                else
                {
                    el.value=dict[i];
                }
            }
        }
        preventDefaut(event);
    }
}

function createRetour(etat)
{
    var success=false;
    var message="";
    if(etat==true)
    {
        success=etat;
    }
    else
        message=etat;
    var ret = "{\"Success\":"+success+",\"NextFocus\":null,\"FieldToModify\":null,\"FieldEnable\":null,\"FieldDisable\":null,\"Message\":\""+message+"\",\"CodeJs\":null,\"CodeHtml\":null}";
    return ret;
}


function onsuccess(str, e, champ,pas)
{
   traitementJson(str, e, champ,pas);
}




function getControl(css,test){
   return getControlSeparateur(css,test,",");
}
function getControlSomme(css,test)
{
    var retour=new Array();
    var tab=getControl(css,test);
    if(tab==null)return null;
    for(i=0;i<tab.length;i++)
    {
        var continu=tab[i].split(":");
        //alert("taille continu = "+continu.length);
        if(continu.length==1)
        {
            retour.push(continu[0]);
        }
        else
        {
            for(j=continu[0];j<=continu[1];j++)
            {
                retour.push(j);
            }
        }
    }
    return retour;
}

function getArgumentControleMetier(tabmetier)
{
    var retour="";
    if(tabmetier==null) return retour;

    var listeIndiceAvecSep=tabmetier.substring(tabmetier.indexOf("(")+1,tabmetier.indexOf(")"));
    if(listeIndiceAvecSep==null) return retour;
    return transformerEnValeur(listeIndiceAvecSep);
}
function transformerEnValeur(chaineAvecSep)
{
    var retour="";
    var listeIndice=chaineAvecSep.split(separateurMetier);
    if(listeIndice==null ||listeIndice=="")return "";
    for(i=0;i<listeIndice.length;i++)
    {
        var f=parseInt(listeIndice[i]);
        if(isNaN(f))
        {
            retour=retour+separateurMetier+listeIndice[i];
        }
        else
        {
            var champ=$(":input[tabindex='"+listeIndice[i]+"']");
            if(champ.length>0)
            {
                retour=retour+separateurMetier+champ.val();
            }
        }
    }
    return retour;
}
function getArgumentControleMetierByIndex(tabmetier)
{
    var retour="";
    if(tabmetier==null) return retour;

    var listeIndiceAvecSep=tabmetier.substring(tabmetier.indexOf("(")+1,tabmetier.indexOf(")"));
    if(listeIndiceAvecSep==null) return retour;
    var listeIndice=listeIndiceAvecSep.split(separateurMetier);
    //alert("listeIndice = "+listeIndice.length+" et sep = "+listeIndiceAvecSep);
    for(i=0;i<listeIndice.length;i++)
    {
        //alert("listeIndice = "+listeIndice[i]);
        var champ=$(":input[tabindex='"+listeIndice[i]+"']");
        if(champ.length>0)
        {
            //alert("valeur ="+champ.val());
            retour=retour+separateurMetier+champ.val();
        }
    }
    return retour;
}

function getControlSeparateur(css,test,sep){
    if(css.indexOf(test)==-1)
        return null;
    else{
        var validate = css.split(" ");
        for( i=0; i< validate.length ;i++)
        {
            var str = validate[i];
            if(str.indexOf(test)!=-1){
                var temp = str.substring(str.indexOf("[")+1,str.indexOf("]"));
                var tab = temp.split(sep);
                var ret = new Array();
                for( k=0; k< tab.length ;k++){
                    ret.push(tab[k]);
                }
                return ret;
            }
        }
    }
}

function ajax(meth,param, e, champ,pas)
{
    $.ajax({
              type: "POST",
              //url: urls,
              //url: window.location.href.split('?')[0] + "/"+meth,
              //data: "{fd: '"+fd+"',codemaildossier: '"+cm+"'}",
              url: window.location.href.split('?')[0] + "/essai",
              data: param,
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              error: function(xhr){
                var ef=eval("("+xhr.responseText+")");
                throw (ef.Message);
              }              ,
              success: function(msg) {
                alert(msg.d);
                //traitementJson( msg.d, e, champ,pas);
                return true;
              },
              timeout:5000,
              async: false
            });

}
function ajaxe(meth,param)
{
    $.ajax({
              type: "GET",
              //url: urls,
              //url: window.location.href.split('?')[0] + "/"+meth,
              //data: "{fd: '"+fd+"',codemaildossier: '"+cm+"'}",
              url: "number.jsp",
              data: param,
              dataType: "json",
              error: function(xhr){
                var ef=eval("("+xhr.responseText+")");
                alert (xhr.responseText);
              }              ,
              success: function(data) {
                alert("nety" +data);
                //traitementJson( msg.d, e, champ,pas);
                return true;
              }
              //timeout:5000,
              //async: false
            });

}



