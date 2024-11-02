function int(s, titre)
{
    return isInt(s, titre);
}
function maj(s, titre)
{
    return s.toUpperCase();
}

function isIntWithSeparator(s, titre)
{
    var ret = "";

    if( typeof(s)=='undefined' || s=="") return "";

    s = supprimerEspace(s);

    var neg = false;

    if(s.substring(0,1)=='(' &&  s.substring( s.length-1,s.length  )==')')
    {
        s = replaceAll(s,'(','');
        s = replaceAll(s,')','');
        neg = true;
    }

    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) throw titre + "Nombre non valide";
    }

    if(neg == true) ret = "("+ formatNombre(parseInt(s,10),0," ") +")";
    else ret = formatNombre(parseInt(s,10),0," ");

    return ret;
}

function isInt(s, titre)
{
    var ret = "";

    if( typeof(s)=='undefined' || s=="") return "";

    s = supprimerEspace(s);

    if(s.substring(0,1)=='+' || s.substring(0,1)=='-')
    {
        s=s.substring(1,s.length);
    }


    var neg = false;

    if(s.substring(0,1)=='(' &&  s.substring( s.length-1,s.length  )==')')
    {
        s = replaceAll(s,'(','');
        s = replaceAll(s,')','');
        neg = true;
    }


    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (((c < "0") || (c > "9")))
        {
          throw "Nombre non valide";
        }
    }
    ret = parseInt(s,10);
    return ret;
}

function isPositive(s, titre)
{
    if( typeof(s)=='undefined' || s == null || s == "") return "";

    var neg = false;

    if(s.substring(0,1)=='(' &&  s.substring( s.length-1,s.length  )==')'){ neg = true; }

    if(neg == true){ s = ""; }

    return s;
}

function isNatural(s, titre)
{
    if( typeof(s)=='undefined' || s == null || s == "") return "";

    var neg = false;

    if(s.substring(0,1)=='(' &&  s.substring( s.length-1,s.length  )==')'){ neg = true; }

    if(neg == true){ throw titre + "Nombre doit etre positif"; }

    return s;
}

function isNombre(sText, titre)
{
    if(  sText==null || sText=="")return "";
    var neg=false;
    if(sText.substring(0,1)=='(' &&  sText.substring( sText.length-1,sText.length  )==')'){
        sText=replaceAll(sText,'(','');
        sText=replaceAll(sText,')','');
        neg=true;
    }
    sText=sText.replace(",",".");
    sText=supprimerEspace(sText);
    //sText=sText.replaceAll("\ \g", "");
    var deuxpartie=sText.split(".");
    if(sText.indexOf(".")!=-1 ){
        if(deuxpartie.length>2)
            throw titre + "Nombre non valide";
        isInt(deuxpartie[0], titre);
        isInt(deuxpartie[1], titre);
    }else{
        isInt(sText, titre);
    }
    var valeur = parseFloat(sText);
    var ret=formatNombre(valeur,2," ");
    if(neg==true){
        ret="("+ret+")";

    }
    return ret;
}

function isDouble(sText, titre)
{

  var sign=isNombre(sText, titre).substring(0,1);
  if(sign=="-")
    return isNombre(sText, titre).substring(1,isNombre(sText, titre).length);
  else
  return isNombre(sText, titre);
}

function supprimerEspace(text)
{

    text=text.replace(" ","");
    text=text.toString();
    t=text.indexOf(" ");
    if(t==-1)
		return text;
    while(t!=-1){
       text=supprimerEspace(text);
    }
    return text;
}

function formatNombre(valeur,decimal,separateur)
{
    var deci=Math.round( Math.pow(10,decimal)*(Math.abs(valeur)-Math.floor(Math.abs(valeur)))) ;
	var val=Math.floor(Math.abs(valeur));
	if ((decimal==0)||(deci==Math.pow(10,decimal))) {val=Math.floor(Math.abs(valeur)); deci=0;}
	var val_format=val+"";
	var nb=val_format.length;
	for (var i=1;i<10;i++) {
		if (val>=Math.pow(10,(3*i))) {
			val_format=val_format.substring(0,nb-(3*i))+separateur+val_format.substring(nb-(3*i));
		}
	}
	if (decimal>0) {
		var decim="";
		for (var j=0;j<(decimal-deci.toString().length);j++) {decim+="0";}
		deci=decim+deci.toString();
		val_format=val_format+"."+deci;
	}
	if (parseFloat(valeur)<0) {val_format="-"+val_format;}
	return val_format;
}
function replaceAll(text,old,nouv)
{
    while(text.indexOf(old)>-1)
        text = text.replace(old,nouv);
    return text;

}
function date(sText, titre)
{
	//try
	//{
	//alert("title"+titre);
    if(sText=="")return "";
    var sep =new Array();
    sep.push(".");sep.push("/");sep.push(":");
    sText=replaceAll(sText,sep[0],sep[1]);
    sText=replaceAll(sText,sep[2],sep[1]);
    var listeSplit=sText.split(sep[1]);
    var nombreSep=listeSplit.length-1;
    if(nombreSep>2) throw "Format date non valide";
    var taille=sText.length;
    var retour="";
    if(taille==1)
    {
        isInt(sText, titre);
        retour="01/01/200"+sText;
    }
    if(taille==2)
    {
        var chiffre="";
        var i=0;
        for(i=0;i<sep.length;i++)
        {
            var indice=sText.indexOf(sep[i]);
            if(indice!=-1)
            {
                chiffre=sText.substring(indice,sText.length);
                break;
            }
        }
        if(chiffre=="")retour="01/01/20"+sText;
        else retour="01/01/200"+chiffre;

    }
    if(taille==3)
    {
        var chiffre="";
        var indice=sText.indexOf(sep[1]);
        if(indice!=-1)
        {
            chiffre=sText.substring(indice+1,sText.length);
        }
        if(chiffre=="")retour="0"+sText.substring(0,1)+"/0"+sText.substring(1,2)+"/200"+sText.substring(2,3);
        else retour="01/01/20"+chiffre;

    }
    if(nombreSep==0)
    {
        if(taille==4)
        {
            var chiffre="";
            var i=0;
            var deuxpremier=sText.substring(0,2);
            var annee=sText.substring(2,4);
            var mois="0"+sText.substring(1,2);
            var jour="0"+sText.substring(0,1);
            if(mois=="00")
            {
                annee="0"+sText.substring(3,4);
                mois=sText.substring(1,3);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==5)
        {
            var chiffre="";
            var i=0;
            var deuxpremier=sText.substring(0,2);
            var avantAnnee=sText.substring(2,3);
            var annee=sText.substring(3,5);
            var jour="0"+sText.substring(0,1);
            var mois=sText.substring(1,3);
            if(mois>12)
            {
                mois="0"+sText.substring(2,3);
                jour=sText.substring(0,2);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==6)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(4,6);
            var jour=sText.substring(0,2);
            var mois=sText.substring(2,4);
            if(mois>12)
            {
                annee=sText.substring(2,6);
                mois="0"+sText.substring(1,2);
                jour="0"+sText.substring(0,1);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==7)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(3,7);
            var jour=sText.substring(0,1);
            var mois=sText.substring(1,3);
            if(mois>12)
            {
                mois="0"+sText.substring(2,3);
                jour=sText.substring(0,2);
            }
            if(jour>31) throw "Format date non valide";
            retour="31"+"/"+mois+"/"+annee;

        }
        if(taille==8)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(4,8);
            var jour=sText.substring(0,2);
            var mois=sText.substring(2,4);
            if(mois>12||jour>31)
            {
                throw "Format date non valide2";
            }
            retour=jour+"/"+mois+"/"+annee;

        }
        if(taille>10)
          throw "Format date non valide1";
    }
    if(nombreSep==1)
    {
        var annee=completerAnnee(listeSplit[1]);
        var mois=completerAvantCaractere(listeSplit[0],"0",2);
        var jour="01";
        if(mois>12)
        {
            annee=new Date().getFullYear();
            mois=completerAvantCaractere(listeSplit[1],"0",2);
            jour=completerAvantCaractere(listeSplit[0],"0",2);
        }
        retour=jour+"/"+mois+"/"+annee;
    }
    if(nombreSep==2)
    {
        var annee=completerAnnee(listeSplit[2]);
        var mois=completerAvantCaractere(listeSplit[1],"0",2);
        var jour=completerAvantCaractere(listeSplit[0],"0",2);
        if(mois>12||jour>31)
        {
            throw "Format date non valide:jour ou mois";
        }
        if(annee=="")
        {
            throw "Format date non valide:annee";
            retour="";
        }
        retour=jour+"/"+mois+"/"+annee;
    }
   testDateValide(retour, titre);
	//}
	/*catch(er){
			throw "Format date non valide2";
		}
	//alert("niditra "+sText+"  vam "+retour);
    */
    return retour;
}
function completerAnnee(annee,nchamp)
{
    if(annee.length==2 && annee>69)
    {
        annee="19"+annee;
    }
    else
    {
      if (annee.length<=3)
      {
        if(annee.length==3)
            annee="2"+annee;
        if(annee.length==2)
            annee="20"+annee;
        if(annee.length==1)
            annee="200"+annee;
      }
      else
      {
        //alert("aaaaaaaaaaa");
        annee=annee.substring(0,4);
      }

    }

      return annee;
}

function completerAvantCaractere(mot,car,nombre)
{
    while(mot.length<nombre)
    {
        mot=car+mot;
    }
    return mot;
}
function getMaxJour(mois,annee)
{
    if(mois==4||mois==6 ||mois==9||mois==11) return 30;
    if(mois==2&&((annee%4==0&&annee%100!=0)||annee%400==0)) return 29;
    else if(mois==2) return 28;
    return 31;
}

function testDateValide(retour, titre)
{
    var listeChiffre=retour.split("/");
    for(k=0;k<listeChiffre.length;k++)
    {
        isInt(listeChiffre[k], titre);
    }
    var annee=parseInt(listeChiffre[2],10);
    var mois=parseInt(listeChiffre[1],10);
    var jour=parseInt(listeChiffre[0],10);
    if (jour > getMaxJour(mois, annee) || jour < 0 || jour == 0 || mois == 0 || annee == 0) throw titre + "Date invalide";
}
function required(sText, titre)
{
    sText = trim(sText);
    if((sText!=null)&&(sText!=''))
        return sText;
    else
        throw titre + "Ce champ doit �tre renseign�";
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
/*
function tel(sText, titre)
{
   sText = trim(sText);
   var ret =  titre + "Format de t�l�phone non valide";

   if(!isInt(sText))
           throw  ret;

   var reg = /^\d*[0-9](|.\d*[0-9]|,\d*[0-9])?$/;
    if(!reg.test(sText))
        return true;
    else
        throw ret;
}
*/


function numOnly(txt, titre)
{
   if(txt!="" && ! /^([0-9])*$/.test(txt))
    throw titre + "Entrer uniquement des chiffres !";
   else
    return txt;
}

function alphaOnly(txt, titre)
{
   if(txt!="" && ! /^([a-zA-Z])*$/.test(txt))
    throw titre + "Entrer uniquement des lettres !";
   else
    return txt;
}
function toUpCase(txt,titre)
{
  txt=alphaOnly(txt,titre);
  var nom=txt.toUpperCase();
  return nom;
}


function codepostal(txt, titre)
{
   if(txt!="" && ! /[0-9]{5}/.test(txt))
    throw titre + "5 caract�res num�riques uniquement !";
   else
    return txt;
}

function idpays(txt, titre)
{

   if(txt!="" && ! /[a-zA-Z]{2}/.test(txt))
    throw titre + "Entrer uniquement deux lettres !";
   else
    return txt;
}

function insee(txt, titre)
{
   alphaSpace(txt, titre);
   if(txt!="" && txt.length > 32)
    throw titre + "Format invalide !\n 32 Caract�res alphanum�riques uniquement !";
   else
    return txt;
}

function activite(txt, titre)
{
   alphaSpace(txt, titre);
   if(txt!="" && txt.length > 32)
    throw titre + "Format invalide !\n 32 Caract�res alphanum�riques uniquement !";
   else
    return txt;
}

function tel(txt, titre)
{
   //if(txt!="" && ! /^0[0-9]([ |.|-]?[0-9]{2})*$/.test(txt))
   //if(txt!="" && ! /^(0[0-68][-.\s]?(\d{2}[-.\s]?){3}\d{2})$/.test(txt))
   if(txt!="" && ! /^(0|0033)([0-9 |.])*$/.test(txt))
    throw titre + "Format invalide !";
   else
    return txt;
}

function email(txt, titre)
{
   //([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+
   if(txt!="" && ! /^[a-zA-Z0-9_.-]{1,30}@{1}[a-zA-Z\d.-]{1,63}\.{1}[a-zA-Z]{2,4}$/.test(txt))
    throw titre + "Format invalide !";
   else
    return txt;
}

function url(txt, titre)
{
   txt=txt.toLowerCase();
   if(txt!= "" && txt.indexOf("http")!=0)
        txt="http://"+txt;
   if(txt!="" && ! /(https?:\/\/)?(www\.)?([a-zA-Z0-9_%]*)\b\.[a-z]{2,4}(\.[a-z]{2})?((\/[a-zA-Z0-9_%]*)+)?(\.[a-z]*)?$/.test(txt))
    throw titre + "Format invalide !";
   else
    return txt;
}

function frp(txt, titre)
{
   if(txt!="" && ! /[0-9]{15}/.test(txt))
    throw titre + "Format invalide !\n 15 caract�res num�riques uniquement !";
   else
    return txt;
}

function siret(txt, titre)
{
   if(txt!="" && ! /[0-9]{14}/.test(txt))
    throw titre + "Format invalide !\n 14 caract�res num�riques uniquement !";
   else
    return txt;
}

function naf(txt, titre)
{
   if(txt!="" && ! /^[0-9]{4}[a-zA-Z]{1}$/.test(txt))
    throw titre + "Format invalide !\n Entrer uniquement 4 chiffres suivis d�une lettre";
   else
    return txt;
}

function ncga(txt, titre)
{
   if(txt!="" && ! /[a-zA-Z0-9]{6}/.test(txt))
    throw titre + "Format invalide !\n 6 caract�res alphanum�riques uniquement !";
   else
    return txt;
}

function annee(txt, titre)
{
   if(txt!="" && ! /(19|20)\d\d/.test(txt))
    throw titre + "Format invalide !\n Entrer uniquement 4 chiffres entre 1900 et 2099 !";
   else
    return txt;
}

function btq(txt, titre)
{
    txt = txt.toString().toUpperCase();
    if(txt=="B" || txt=="T" || txt=="Q" || txt=="")
        return txt;
    else
        throw "Param�tres T�l�declaration : B ou T ou Q seulement";
}

function refeDossier(txt, titre) {
    if (txt != "" && !/[a-zA-Z0-9]{5}/.test(txt))
        throw titre + "5 caract�res alphanum�riques uniquement!";
    else
        return txt;
}

function Devise(txt, titre)
{
   if(txt!="" && ! /^([0-9])*$/.test(txt))
    throw titre + "Format invalide, veuillez saisir un nombre dans la zone devise";
   else
    return txt;
}

//utilisation des fonctions

function completerAnneeJs(sText)
{
  //alert("ato alou");
  var nomChamp=sText.name;//alert(nomChamp)
  sText=completerAnnee(sText.value,nomChamp);
  document.getElementById(nomChamp).value=sText;
  return sText;
}
function dateJs(sText)
{
  //alert("ato alou");
  var nomChamp=sText.name;
  try{
  sText=date(sText.value,nomChamp);
  document.getElementById(nomChamp).value=sText;
  return sText;
  }
  catch(er)
  {
    alert(er+":"+nomChamp);
  }
}
function isPositiveJs(sText)
{
  //alert("ato alou");
  var nomChamp=sText.name;
  try{
  sText=isInt(sText.value,nomChamp);
  document.getElementById(nomChamp).value=sText;
  return sText;
  }
  catch(er)
  {
    sText="";
    alert(er);
  }
}
function isDoubleJs(sText)
{
  var nomChamp=sText.name;
  try{
    //alert("ato alou");

    sText=isDouble(sText.value,nomChamp);
    document.getElementById(nomChamp).value=sText;
    return sText;
  }
  catch(er)
  {
    alert(er+":"+nomChamp);return "";
  }

}
function telJs(sText)
{
  var nomChamp=sText.name;
  try{
    //alert("ato alou");

    sText=tel(sText.value,nomChamp);
    document.getElementById(nomChamp).value=sText;
    return sText;
  }
  catch(er)
  {
    alert(er);
  }

}
function toUpCaseJs(sText)
{
  var nomChamp=sText.name;
  try{
    //alert("ato alou");

    sText=toUpCase(sText.value,nomChamp);
    document.getElementById(nomChamp).value=sText;
    return sText;
  }
  catch(er)
  {
    alert(er);
  }

}
function change_onglet(name)
{
      document.getElementById('onglet_'+anc_onglet).className = 'onglet_0 onglet';
      document.getElementById('onglet_'+name).className = 'onglet_1 onglet';
      document.getElementById('contenu_onglet_'+anc_onglet).style.display = 'none';
      document.getElementById('contenu_onglet_'+name).style.display = 'block';
      anc_onglet = name;
}
function getParametreEtValeur(qs) {
    qs = qs.split("+").join(" ");
    var params = {},
        tokens,
        re = /[?&]?([^=]+)=([^&]*)/g;

    while (tokens = re.exec(qs)) {
        params[decodeURIComponent(tokens[1])]
            = decodeURIComponent(tokens[2]);
    }
    return params;
}
function date(sText)
{
    if(sText=="")return "";
    var sep =new Array();
    sep.push(".");sep.push("/");sep.push(":");
    sText=replaceAll(sText,sep[0],sep[1]);
    sText=replaceAll(sText,sep[2],sep[1]);
    var listeSplit=sText.split(sep[1]);
    var nombreSep=listeSplit.length-1;
    if(nombreSep>2) throw "Format date non valide";
    var taille=sText.length;
    var retour="";
    if(taille==1)
    {
        isInt(taille);
        retour="01/01/200"+taille;
    }
    if(taille==2)
    {
        var chiffre="";
        var i=0;
        for(i=0;i<sep.length;i++)
        {
            var indice=sText.indexOf(sep[i]);
            if(indice!=-1) 
            {
                chiffre=sText.substring(indice,sText.length);
                break;            
            }
        }
        if(chiffre=="")retour="01/01/20"+sText;
        else retour="01/01/200"+chiffre;
        
    }
    if(taille==3)
    {
        var chiffre="";
        var indice=sText.indexOf(sep[1]);
        if(indice!=-1) 
        {
            chiffre=sText.substring(indice+1,sText.length);
        }
        if(chiffre=="")retour="0"+sText.substring(0,1)+"/0"+sText.substring(1,2)+"/200"+sText.substring(2,3);
        else retour="01/01/20"+chiffre;
        
    }
    if(nombreSep==0)
    {
        if(taille==4)
        {
            var chiffre="";
            var i=0;
            var deuxpremier=sText.substring(0,2);
            var annee=sText.substring(2,4);
            var mois="0"+sText.substring(1,2);
            var jour="0"+sText.substring(0,1);
            if(mois=="00")
            {
                annee="0"+sText.substring(3,4);
                mois=sText.substring(1,3);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==5)
        {
            var chiffre="";
            var i=0;
            var deuxpremier=sText.substring(0,2);
            var avantAnnee=sText.substring(2,3);
            var annee=sText.substring(3,5);
            var jour="0"+sText.substring(0,1);
            var mois=sText.substring(1,3);
            if(mois>12)
            {
                mois="0"+sText.substring(2,3);
                jour=sText.substring(0,2);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==6)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(4,6);
            var jour=sText.substring(0,2);
            var mois=sText.substring(2,4);
            if(mois>12)
            {
                annee=sText.substring(2,6);
                mois="0"+sText.substring(1,2);
                jour="0"+sText.substring(0,1);
            }
            annee=completerAnnee(annee);
            retour=jour+"/"+mois+"/"+annee;
        }
        if(taille==7)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(3,7);
            var jour=sText.substring(0,1);
            var mois=sText.substring(1,3);
            if(mois>12)
            {
                mois="0"+sText.substring(2,3);
                jour=sText.substring(0,2);
            }
            if(jour>31) throw "format de date invalide";
            retour=jour+"/"+mois+"/"+annee;

        }
        if(taille==8)
        {
            var chiffre="";
            var i=0;
            var annee=sText.substring(4,8);
            var jour=sText.substring(0,2);
            var mois=sText.substring(2,4);
            if(mois>12||jour>31)
            {
                throw "Format de date invalide";
            }
            retour=jour+"/"+mois+"/"+annee;

        }
        if(taille>8)throw "Format de date non valide";
    }
    if(nombreSep==1)
    {
        var annee=completerAnnee(listeSplit[1]);
        var mois=completerAvantCaractere(listeSplit[0],"0",2);
        var jour="01";
        if(mois>12)
        {
            annee=new Date().getFullYear();
            mois=completerAvantCaractere(listeSplit[1],"0",2);
            jour=completerAvantCaractere(listeSplit[0],"0",2);
        }
        retour=jour+"/"+mois+"/"+annee;
    }
    if(nombreSep==2)
    {
        var annee=completerAnnee(listeSplit[2]);
        var mois=completerAvantCaractere(listeSplit[1],"0",2);
        var jour=completerAvantCaractere(listeSplit[0],"0",2);
        if(mois>12||jour>31)
        {
            throw "Format de date invalide";
        }
        retour=jour+"/"+mois+"/"+annee;
    }
    testDateValide(retour);
 
    return retour;
}