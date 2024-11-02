function calculer(id){
	var calcul = document.getElementById(id).value;
	var debutcalcul = calcul.substring(0,1);
	var operation = calcul.substring(1, calcul.length);
	if(debutcalcul === '=')
		document.getElementById(id).value = effectuerOperation(operation, 0).toFixed(2);	
}
function effectuerOperation(operation, niveau){
	var operateurs = ['+', '-', '*', '/'];
	var sousoperation = operation.split(operateurs[niveau]);
	if(isNaN(operation)){
		resultat = effectuerOperation(sousoperation[0], niveau+1);
		for(var i = 1 ; i < sousoperation.length ; i++){
			if(niveau === 0)
				resultat += effectuerOperation(sousoperation[i], niveau+1);
			if(niveau === 1)
				resultat -= effectuerOperation(sousoperation[i], niveau+1);
			if(niveau === 2)
				resultat *= effectuerOperation(sousoperation[i], niveau+1);
			if(niveau === 3)
				resultat /= effectuerOperation(sousoperation[i], niveau+1);
		}
		return resultat;
	} else
		return parseFloat(operation);
}