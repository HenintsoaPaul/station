<%-- 
    Document   : formulejs.jsp
    Created on : 7 avr. 2019, 19:13:25
    Author     : ionyr
--%>
<script>
    var champsEuro = ["fretUnitaire","coutDeRevient","prixAchat","ddKg","ddOf","mageFinal","fdpUnitaire","consigne","gasyNet","prixDeVentePlancher","tva","tvaClient","lta","prixDeVente","prixDeVenteQteTotal","remise"];
    var champsAr = ["fretUnitaire_a","coutDeRevient_a","prixAchat_a","ddKg_a","ddOf_a","mageFinal_a","fdpUnitaire_a","consigne_a","gasyNet_a","prixDeVentePlancher_a","tva_a","tvaClient_a","lta_a","prixDeVente_a","prixDeVenteQteTotal_a","remise_a"];
    function toNombre(a){
        if(a==""){
            return 0;
        }
        else{
            return a;
        }
    }
    
    function calculFret(poids){
        console.log("poids   "+poids);
        console.log("parseFloat(poids)   "+parseFloat(poids));
        console.log("parseFloat(poids)*4.5   "+parseFloat(poids)*4.5);
        return (parseFloat(toNombre(poids))*4.5).toFixed(2);
    }
    function calculDdkg(poids){
        if(poids>=4.5){
            return (poids*3.41).toFixed(2);
        }
        else{
            return 0;
        }
    }
    function calculDdof(poids,prixAchat){
        if(poids<=4.49){
            return (prixAchat*0.3*0.45).toFixed(2);
        }
        else{
            return 0;
        }
    }
    function calculSitva(prixAchat){
        return (prixAchat *0.2).toFixed(2);
    }
    function calculCoutrevient(poids,prixAchat,fdpUnitaire,consigne,tva,fretUnitaire,ddkg,ddof,gasyNet,lta){
        if(poids>=4.5){
            return (parseFloat(toNombre(prixAchat)) + parseFloat(toNombre(fdpUnitaire)) + parseFloat(toNombre(consigne)) + parseFloat(toNombre(tva)) + parseFloat(toNombre(fretUnitaire)) + parseFloat(toNombre(ddkg)) + parseFloat(toNombre(gasyNet)) + parseFloat(toNombre(lta))).toFixed(2);
        }
        else{
            console.log(parseFloat(toNombre(prixAchat)) + " + " + parseFloat(toNombre(fdpUnitaire)) + " + " + parseFloat(toNombre(consigne)) + " + " + parseFloat(toNombre(tva)) + " + " + parseFloat(toNombre(fretUnitaire)) + " + " + parseFloat(toNombre(ddof)) + " + " + parseFloat(toNombre(gasyNet)) + " + " + parseFloat(toNombre(lta)));
            return (parseFloat(toNombre(prixAchat)) + parseFloat(toNombre(fdpUnitaire)) + parseFloat(toNombre(consigne)) + parseFloat(toNombre(tva)) + parseFloat(toNombre(fretUnitaire)) + parseFloat(toNombre(ddof)) + parseFloat(toNombre(gasyNet)) + parseFloat(toNombre(lta))).toFixed(2);
        }
    }
    function calculMargeFinal(marge,coutrevient){
        return ((parseFloat(marge)/100)*(parseFloat(coutrevient)/(1-(parseFloat(marge)/100)))).toFixed(2);
    }
    function calculCoefficientMarge(margeFinal,coutrevient){
        console.log('margeFinal  '+margeFinal);
        console.log('coutrevient  '+coutrevient);
        return ((parseFloat(margeFinal) + parseFloat(coutrevient))/parseFloat(coutrevient)).toFixed(2);
    }
    function calculPrixVenteF(coef,coutrevient){
        return (parseFloat(coutrevient) * parseFloat(coef)).toFixed(2);
    }
    function calculPrixVentePlancher(coutrevient){
        return (parseFloat(coutrevient) * 1.43).toFixed(2);
    }
    
    function euroToAr(champEuro,champAr,cours){
        //console.log("cours        "+cours);
        $('#'+champAr).val(($('#'+champEuro).val() * cours).toFixed(2));
    }
    function changeFret(fret,poids){
        $('#'+fret).val(calculFret(poids));
    }
    function changeDdkg(ddkg,poids){
        $('#'+ddkg).val(calculDdkg(poids));
    }
    function changeDdof(ddof,poids,prixAchat){
        $('#'+ddof).val(calculDdof(poids,prixAchat));
    }
    function changeSitva(tva,prixAchat){
        $('#'+tva).val(calculSitva(prixAchat));
    }
    function changeCoutRevient(cr,poids,prixAchat,fdpUnitaire,consigne,tva,fretUnitaire,ddkg,ddof,gasyNet,lta){
        $('#'+cr).val(calculCoutrevient(poids,prixAchat,fdpUnitaire,consigne,tva,fretUnitaire,ddkg,ddof,gasyNet,lta));
        changePrixVentePlancher('prixDeVentePlancher',$('#'+cr).val())
    }
    function changeMargeFinal(margeF,marge,coutrevient){
        $('#'+margeF).val(calculMargeFinal(marge,coutrevient));
        changeCoefMarge('coefficientDeMarge',$('#margeFinal').val(),$('#coutDeRevient').val());
    }
    function changePrixVente(prixVente,coef,coutrevient){
        console.log(coef+' * '+coutrevient);
        $('#'+prixVente).val(calculPrixVenteF(coef,coutrevient));
    }
    function changeCoefMarge(coefMarge,margeFinal,coutRevient){
        $('#'+coefMarge).val(calculCoefficientMarge(margeFinal,coutRevient));
    }
    
    function changePrixVenteQtTotale(prixDeVenteQteTotal,prixDeVente,qte){
        $('#'+prixDeVenteQteTotal).val(prixDeVente*qte);
    }
    
    function changePrixVentePlancher(prp,coutrevient){
        $('#'+prp).val(calculPrixVentePlancher(coutrevient));
    }
    
    function setAr(){
        var taille = champsEuro.length;
        for(var compteur=0;compteur<taille;compteur++){
            euroToAr(champsEuro[compteur],champsAr[compteur],$('#cours').val());
        }
    }
    
    function calculerTout(){
        changeFret('fretUnitaire',$('#poids').val());
        changeDdkg('ddKg',$('#poids').val());
        changeDdof('ddOf',$('#poids').val(),$('#prixAchat').val());
        
        changeDdof('ddOf',$('#poids').val(),$('#prixAchat').val());
        changeSitva('tva',$('#prixAchat').val());
        changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
        changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
        changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
        changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
        setAr();
    }
    
    $(document).ready(function(){
        //$('#poids').val("3");
        //console.log("$('#poids').val()         "+$('#poids').val());
        calculerTout();
        setAr();
        $('#prixAchat').on("change",function(){
            changeDdof('ddOf',$('#poids').val(),$('#prixAchat').val());
            changeSitva('tva',$('#prixAchat').val());
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#fdpUnitaire').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            setAr();
        });
        $('#consigne').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#tva').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#fretUnitaire').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#ddKg').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#ddOf').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#gasyNet').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#lta').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        $('#marge').on("change",function(){
            changeCoutRevient('coutDeRevient',$('#poids').val(),$('#prixAchat').val(),$('#fdpUnitaire').val(),$('#consigne').val(),$('#tvaClient').val(),$('#fretUnitaire').val(),$('#ddKg').val(),$('#ddOf').val(),$('#gasyNet').val(),$('#lta').val());
            changeMargeFinal('margeFinal',$('#marge').val(),$('#coutDeRevient').val());
            changePrixVente('prixDeVente',$('#coefficientDeMarge').val(),$('#coutDeRevient').val());
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        
        $('#prixDeVente').on("change",function(){
            changePrixVenteQtTotale('prixDeVenteQteTotal', $('#prixDeVente').val(), $('#qte').val());
            setAr();
        });
        
        $('#cours').on("change",function(){
            setAr();
        });
    });
    
    //$('#')
</script>