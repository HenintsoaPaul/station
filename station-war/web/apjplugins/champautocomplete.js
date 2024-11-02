function showSuggestion(idchamp, colonne, nomclasse){
    var xmlhttp;
    var idsuggestion, idliste;
    idsuggestion = 'sugg'+idchamp;
    idliste = 'liste'+idchamp;
    if (window.XMLHttpRequest)
        xmlhttp = new XMLHttpRequest();
    else
        xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
    xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState === 4 && (xmlhttp.status === 200 || xmlhttp.status === 0)){
            if (document.getElementById(idchamp).value !== '')
                document.getElementById(idsuggestion).innerHTML = xmlhttp.responseText;
            else if (xmlhttp.responseText === null || xmlhttp.responseText === '')
                document.getElementById(idsuggestion).innerHTML = '';
            else
                document.getElementById(idsuggestion).innerHTML = '';
        }
    };
    xmlhttp.open('POST', 'ajaxAutocompletion.jsp', true);
    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlhttp.send('valeur='+document.getElementById(idchamp).value+'&idchamp='+idchamp+'&idsuggestion='+idsuggestion+'&idliste='+idliste+'&colonne='+colonne+'&nomclasse='+nomclasse);
}

function selection(idchamp){
    var idsuggestion, idliste;
    idsuggestion = 'sugg'+idchamp;
    idliste = 'liste'+idchamp;
    document.getElementById(idchamp).value = document.getElementById(idliste).value;
    document.getElementById(idsuggestion).innerHTML = '';
}

function selectionEnter(event, idchamp){
    if(event.keyCode == 13)
        selection(idchamp);
        
}

function moveToList(event, listename){
    if(event.keyCode === 40)
        $('#'+listename).focus();
    
}