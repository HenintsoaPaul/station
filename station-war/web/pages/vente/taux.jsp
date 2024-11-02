<script>
$(document).ready(function() {
    console.log("ato tsika");
    function updateTauxFields() {
        var idDevise = $('#idDevise').val();
        console.log("Fetching taux...");

        var nombreLigne = parseInt($("#nombreLigne").val());

        $.ajax({
            url: 'http://localhost:8087/station/DeviseServlet',
            type: 'GET',
            data: { idDevise: idDevise },
            dataType: 'json',
            success: function(data) {
                var taux = data.taux;
                console.log("Taux:", taux);
                for (let iL = 0; iL < nombreLigne; iL++) {
                    $("#tauxDeChange_" + iL).val(taux); 
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error:', textStatus, errorThrown);
            }
        });

        console.log("idDevise:", idDevise);
    }
    $('#idDevise').on('change', updateTauxFields);
});
</script>
