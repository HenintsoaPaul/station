function Popup(url,nom,largeur,hauteur,options) {
var haut=(screen.height-hauteur)/2;
var Gauche=(screen.width-largeur)/2;
fencent=window.open(url,nom,"top="+haut+",left="+Gauche+",width="+largeur+",height="+hauteur+","+options);
}
function testchangeyear(yearone,yeartwo)
{
	if(yearone!=yeartwo)
	{
		return true;
	}
	else
	{
		return false;
	}
}

function testDate(datySup,datyInf){
if(datyInf>datySup){
alert('Date inf&eacute;rieur doit �tre inf�rieur');
 return false;
}else{
 alert('kozy');
 return false;
 }
}
function GereChkbox(conteneur, a_faire){
  var blnEtat=null;
  var Chckbox = document.getElementById(conteneur).getElementsByTagName('input');
        for(var i=0;i<Chckbox.length;i++)
        {
          if (Chckbox[i].type=="checkbox")
            blnEtat = (a_faire=='0') ? false : (a_faire=='1') ? true : (Chckbox[i].checked) ? false : true;
            Chckbox[i].checked=blnEtat;
        }
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- '+nm+' doit �tre de type num�rique.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' ne doit pas �tre vide.\n'; }
  } if (errors) alert('Des erreurs ont �t� rencontr�e lors de votre saisie. Veuillez v�rifier les valeurs entr�es!\n');
  //alert('Des erreurs ont �t� rencontr� lors de votre saisie :\n'+errors);
  document.MM_returnValue = (errors == '');
}

function verifie(a)
{
	if (a=="")
	{
		alert("Remplissez bien les champs");
		return false;
	}
	else
	{
		return true;
	}
}

function verifieMotDePasse(a,b)
{
	if (a==b)
	{
		return(true);
	}
	else
	{
		alert("Verifiez votre saisie : votre mot de passe est different de la confirmation mot de passe");
		return(false);
	}
}
function verifieEntier(a)
{
	if (a <=0)
	{
		alert("Valeurs de champs non valide");
		return(false);
	}
	else
	{
		return(true);
	}
}
function SetCookie (name, value) {
	var argv=SetCookie.arguments;
	var argc=SetCookie.arguments.length;
	var expires=(argc > 2) ? argv[2] : null;
	var path=(argc > 3) ? argv[3] : null;
	var domain=(argc > 4) ? argv[4] : null;
	var secure=(argc > 5) ? argv[5] : false;
	document.cookie=name+"="+escape(value)+
		((expires==null) ? "" : ("; expires="+expires.toGMTString()))+
		((path==null) ? "" : ("; path="+path))+
		((domain==null) ? "" : ("; domain="+domain))+
		((secure==true) ? "; secure" : "");
}
function getCookieVal(offset) {
	var endstr=document.cookie.indexOf (";", offset);
	if (endstr==-1)	endstr=document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}
function GetCookie (name) {
	var arg=name+"=";
	var alen=arg.length;
	var clen=document.cookie.length;
	var i=0;
	while (i<clen) {
		var j=i+alen;
		if (document.cookie.substring(i, j)==arg)
			return getCookieVal (j);
		i=document.cookie.indexOf(" ",i)+1;
		if (i==0) break;}
	return null;
}
/******************************************/
/* Fonction de comparaison de deux dates */
/****************************************/

 function DonnerFocus(nom) {
    document.forms[0].elements[nom].focus();
 }
 function datecomp(datesaisie,datecompar){
    var datedebut=datesaisie.value;
    var datefin=datecompar;
    //v�rification du format -  si la date est saisie je commence le travail, ce si se termine � la fin
    if (datedebut!="") {
       if (datefin=='1'){
          //definition des variables champs pour reprendre le focus au bon endroit
          var rfocus="date1";
          }
          else {
          var rfocus="date2";
          }
       //v�fification du format de date et +
       if (!verifdate(datedebut)) {
          alert("Attention soit la date n'est pas correcte, soit elle n'est pas au format JJ/MM/AAAA");DonnerFocus(rfocus);return false;
       }
    //cr�ation d'un tableau ou je range la date d�but dans trois cases, si il y a des zero je les supprimme
    deb = new Array(3);
    if (datedebut.substring(0,1)=="0"){
       deb[1]=parseInt(datedebut.substring(1,2));
       }
    else {
       deb[1]=parseInt(datedebut.substring(0,2));
       }
    if (datedebut.substring(3,4)=="0"){
       deb[2]=parseInt(datedebut.substring(4,5));
       }
    else {
       deb[2]=parseInt(datedebut.substring(3,5));
       }
    deb[3]=parseInt(datedebut.substring(6,10));

    //si la datefin contient 1 on vient du formulaire dateresadebut donc on compare avec la date du jour
    //dans ce cas on r�cup�re un format de date javascript, on le transforme et on le range dans un tableau
    //je ne transforme pas la variable datfin que je r�utilise plus loin
    if (datefin=='1') {
       datef=new Date();
       fin = new Array(3);
       fin[1]=datef.getDate();
       fin[2]=datef.getMonth()+1;
       fin[3]=datef.getYear();
       var message="La date d�but doit �tre inf�rieure � la date de fin";
    }
    //dans l'autre cas, on arrive du formulaire par dateresafin et datecompar=dateresadebut
    //on r�cup�re la dateresadebut et on la range aussi dans un tableau mais comme la dated�but
    else {
       fin = new Array(3);
       if (datefin.substring(0,1)=="0"){
          fin[1]=parseInt(datefin.substring(1,2));
       }
       else {
          fin[1]=parseInt(datefin.substring(0,2));
       }
       if (datefin.substring(3,4)=="0"){
          fin[2]=parseInt(datefin.substring(4,5));
       }
       else {
          fin[2]=parseInt(datefin.substring(3,5));
          }
       fin[3]=parseInt(datefin.substring(6,10));
       var message="La date d�but doit �tre inf�rieure � la date de fin";
    }

    //comparaison des dates

       if (deb[3]<fin[3]) {
          alert(message);DonnerFocus(rfocus);return false;
          }
       else {
          if ((deb[3]== fin[3]) && (deb[2]<fin[2])){
             alert(message);DonnerFocus(rfocus);return false;
          }
          else {
             if ((deb[3]== fin[3]) && (deb[2]==fin[2]) && (deb[1]<fin[1])){
             alert(message);DonnerFocus(rfocus);return false;
             }
          }
       }
       //si la date de r�servation d�passe un an on demande une confirmation
       if (datefin!='1'){
          if ((deb[3]-fin[3])>1){
             if (confirm("attention, vous avez r�serv� pour plus d'un an, confirmer ?")) {
             return true;
             }
             else {
                return false;
             }
          }
       }
    return true;
    }
 }

  // Cette fonction v�rifie le format JJ/MM/AAAA saisi et la validit� de la date.
  // Le s�parateur est d�fini dans la variable separateur

  function verifdate(d) {
   var dateaverifier=d
   // rangement de la date dans des variables
   if (dateaverifier.substring(0,1)=="0"){
          var j=parseInt(dateaverifier.substring(1,2));
       }
       else {
          var j=parseInt(dateaverifier.substring(0,2));
       }
       if (dateaverifier.substring(3,4)=="0"){
          var m=parseInt(dateaverifier.substring(4,5));
       }
       else {
          var m=parseInt(dateaverifier.substring(3,5));
          }
       var a=parseInt(dateaverifier.substring(6,10));
    //si la longueur est diff�rent de 10 , probl�me
      if (dateaverifier.length != 10) {
          return false;
    }
    //les carat�res / ne sont pas aux endroits attendus
    else {
       if((dateaverifier.charAt(2) != '/') && (dateaverifier.charAt(5) != '/')) {
          return false;
       }
    }
    //l'ann�e n'est pa un chiffre
    if (isNaN(a)) {
       return false;
     }
    //le mois n'est pas un chiffre ou n'est pas compris entre 0 et12
      if ((isNaN(m))||(m<1)||(m>12)) {
       return false;
     }
    //test si il s'agit d'une ann�e bissextile pour accepter le 29/02
    if (((a % 4)==0 && (a % 100)!=0) || (a % 400)==0){
          if ((isNaN(j)) || ((m!=2) && ((j<1)||(j>31))) || ((m==2) && ((j<1)||(j>29)))) {
             return false;
         }
    }
     else {
          if ((isNaN(j)) || ((m!=2) && ((j<1)||(j>31))) || ((m==2) && ((j<1)||(j>28)))){
          return false;
       }
    }
    return true;
 }

 //cette fonction test si caract�res num�riques r�cup�r�e sur toutjavascript.com
 function IsNumberString(NumStr)
 {var regEx=/^[0-9]+$/;
 var ret=false;
 if (regEx.test(NumStr)) ret=true;
 return ret;
 }

  function datecomp1(datesaisie,datecompar,message){
    var datedebut=datesaisie.value;
    var datefin=datecompar;
    //v�rification du format -  si la date est saisie je commence le travail, ce si se termine � la fin
    if (datedebut!="") {
       if (datefin=='1'){
          //definition des variables champs pour reprendre le focus au bon endroit
          var rfocus="date";
          }
          else {
          var rfocus="dateAccident";
          }
       //v�fification du format de date et +
       if (!verifdate(datedebut)) {
          alert("Attention soit la date n'est pas correcte, soit elle n'est pas au format JJ/MM/AAAA");DonnerFocus(rfocus);return false;
       }
    //cr�ation d'un tableau ou je range la date d�but dans trois cases, si il y a des zero je les supprimme
    deb = new Array(3);
    if (datedebut.substring(0,1)=="0"){
       deb[1]=parseInt(datedebut.substring(1,2));
       }
    else {
       deb[1]=parseInt(datedebut.substring(0,2));
       }
    if (datedebut.substring(3,4)=="0"){
       deb[2]=parseInt(datedebut.substring(4,5));
       }
    else {
       deb[2]=parseInt(datedebut.substring(3,5));
       }
    deb[3]=parseInt(datedebut.substring(6,10));

    //si la datefin contient 1 on vient du formulaire dateresadebut donc on compare avec la date du jour
    //dans ce cas on r�cup�re un format de date javascript, on le transforme et on le range dans un tableau
    //je ne transforme pas la variable datfin que je r�utilise plus loin
    if (datefin=='1') {
       datef=new Date();
       fin = new Array(3);
       fin[1]=datef.getDate();
       fin[2]=datef.getMonth()+1;
       fin[3]=datef.getYear();
       //var message="La date d�but doit �tre inf�rieure � la date de fin";
    }
    //dans l'autre cas, on arrive du formulaire par dateresafin et datecompar=dateresadebut
    //on r�cup�re la dateresadebut et on la range aussi dans un tableau mais comme la dated�but
    else {
       fin = new Array(3);
       if (datefin.substring(0,1)=="0"){
          fin[1]=parseInt(datefin.substring(1,2));
       }
       else {
          fin[1]=parseInt(datefin.substring(0,2));
       }
       if (datefin.substring(3,4)=="0"){
          fin[2]=parseInt(datefin.substring(4,5));
       }
       else {
          fin[2]=parseInt(datefin.substring(3,5));
          }
       fin[3]=parseInt(datefin.substring(6,10));
       //var message="La date d�but doit �tre inf�rieure � la date de fin";
    }

    //comparaison des dates

       if (deb[3]>fin[3]) {
          alert(message);DonnerFocus(rfocus);return false;
          }
       else {
          if ((deb[3]== fin[3]) && (deb[2]>fin[2])){
             alert(message);DonnerFocus(rfocus);return false;
          }
          else {
             if ((deb[3]== fin[3]) && (deb[2]==fin[2]) && (deb[1]>fin[1])){
             alert(message);DonnerFocus(rfocus);return false;
             }
          }
       }
       //si la date de r�servation d�passe un an on demande une confirmation
       return true;
    }
 }
function pagePopUp(page,name=""){
     console.log("La page: ",page,width=1009,height=532);
     window.open(page,name,"titulaireresizable=no,scrollbars=yes,location=no,width="+width+",height="+height+",top=0,left=0");
}
// function pagePopUp(page,width,height){
//      window.open(page,"","titulaireresizable=no,scrollbars=yes,location=no,width="+width+",height="+height+",top=0,left=0");
// }