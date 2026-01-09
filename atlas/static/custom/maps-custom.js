// Fonction style d'affichage des points dans la fiche espèce
// Voir documentation leaflet pour customiser davantage l'affichage des points: http://leafletjs.com/reference-1.3.0.html#circlemarker-option
var pointDisplayOptionsFicheEspece = (pointDisplayOptionsFicheCommuneHome = function(
  feature
) {
  return {
//    color: feature.properties.diffusion_level < 1 || feature.properties.diffusion_level != null ? "#3A9D23": "#D51444"
    color: feature.properties.diffusion_level >= 1 ? "#D51444": "#4591e9"
    
//    fillColor: feature.properties.diffusion_level < 1 ? "#3A9D23" : "#D51444",
//    color: feature.properties.diffusion_level < 1 ? "#3A9D23" : "#D51444"
  };
});

// Légende des points dans la fiche espèce
var divLegendeFicheEspece = (divLegendeFicheCommuneHome =
  '\
    <p><div>\
        <i class="circle" style="border: 3px solid #D51444; border-radius: 50%; width: 20px; height: 20px;"></i>Données dégradées\
    </div></p>\
    <p><div>\
        <i class="circle" style="border: 3px solid #4591e9; border-radius: 50%; width: 20px; height: 20px;"></i>Non dégradées\
    </div></p>\
');
