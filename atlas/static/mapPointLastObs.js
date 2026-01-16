var zoomHomeButton = true;

var map = generateMap(zoomHomeButton);

if (configuration.MAP.ENABLE_SLIDER) {
    generateSliderOnMap();
}
var legend = L.control({position: "bottomright"});

// Layer display on window ready

/*GLOBAL VARIABLE*/

// Current observation Layer: leaflet layer type
var currentLayer;
var nbObsMailleLayer;
var lastObsMailleLayer;

// Current observation geoJson:  type object
var myGeoJson;

var compteurLegend = 0; // counter to not put the legend each time

// global variable to see if the slider has been touch
var sliderTouch = false;

// variable globale: observations récupérer en AJAX
var observationsMaille;
var observationsPoint;
$.ajax({
    url:
        configuration.URL_APPLICATION + "/api/observationsMailleAndPoint/" + cd_ref,
    dataType: "json",
}).done(function (observations) {
    $("#loaderSpinner").hide();
    observationsMaille = observations.maille;
    observationsPoint = observations.point;

    // mailleBoolean: dipslay maille mode because a lot of obs
    var mailleBoolean = false;
    //if (observations.point.features.length > 500) {
    if (observations.point.features.length > 0) {
            loadMailleLastObsLayerFicheEspece(observationsMaille, yearMin, yearMax, sliderTouch);
            loadMailleLayerFicheEspece(observationsMaille, yearMin, yearMax, sliderTouch);
        mailleBoolean = true;
    } else {
        // affichage des points sans filtrer par annes pour gagner en perf
        displayMarkerLayerFicheEspece(observationsPoint, yearMin, yearMax, sliderTouch);
    };

    // on a chargé les deux couches de maille (nb_obs et last_obs) et maintenant on en affiche une selon l'onglet actif.
    if (document.getElementById('datemapTab').classList.contains('active')) {
        displayMailleLastObsLayerFicheEspece();
    } else {
        displayMailleLayerFicheEspece();
    };

    if (mailleBoolean) {
        // zoom event
        eventOnZoom(observationsMaille, observationsPoint);

        if (configuration.MAP.ENABLE_SLIDER) {
            // Slider event
            mySlider.on("change", function () {
                sliderTouch = true;
                years = mySlider.getValue();
                yearMin = years[0];
                yearMax = years[1];

                $("#yearMin").html(yearMin + "&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#yearMax").html("&nbsp;&nbsp;&nbsp;&nbsp;" + yearMax);
            });

            mySlider.on("slideStop", function () {
                sliderTouch = true;

                removeAllLayerFromMap();
                
                if (map.getZoom() >= configuration.ZOOM_LEVEL_POINT) {
                    // on filtre en local
                    displayMarkerLayerFicheEspece(
                        observationsPoint,
                        yearMin,
                        yearMax,
                        sliderTouch
                    );
                } else {
                    // on recharge que les mailles en AJAX - filtrée par années
                    $.ajax({
                        url:
                            configuration.URL_APPLICATION +
                            "/api/observationsMaille/" +
                            cd_ref,
                        dataType: "json",
                        type: "get",
                        data: {
                            year_min: yearMin,
                            year_max: yearMax
                        },
                        beforeSend: function () {
                            $("#loaderSpinner").show();
                        }
                    }).done(function (observations) {
                        $("#loaderSpinner").hide();
                        observationsMaille = observations;

                        // desactivation de l'event precedent
                        map.off("zoomend", function () {
                        });
                        // reactivation de l'event du zoom avec les nouvelle valeurs
                        eventOnZoom(observationsMaille, observationsPoint);

                        loadMailleLastObsLayerFicheEspece(observationsMaille, yearMin, yearMax, sliderTouch);
                        loadMailleLayerFicheEspece(observationsMaille, yearMin, yearMax, sliderTouch);
                        if (document.getElementById('datemapTab').classList.contains('active')) {
                            displayMailleLastObsLayerFicheEspece();
                        } else {
                            displayMailleLayerFicheEspece();
                        };
                        
                        lastyear = 0;
                        observationsMaille.features.forEach(function(l) {
                            if (lastyear < l.properties.lastyear) {
                                lastyear = l.properties.lastyear;
                            }
                        });

                        $("#nbObs").html("Dernière année d'observation : " + lastyear);
                    });
                }
            });
        }

        // if not display Maille
    } else {
        if (configuration.MAP.ENABLE_SLIDER) {
            // Slider event
            mySlider.on("slideStop", function () {
                sliderTouch = true;
                years = mySlider.getValue();
                yearMin = years[0];
                yearMax = years[1];

                removeAllLayerFromMap();

                displayMarkerLayerFicheEspece(
                    observationsPoint,
                    yearMin,
                    yearMax,
                    sliderTouch
                );

                nbObs = 0;
                observationsPoint.features.forEach(function(point){
                    if (point.properties.year >= yearMin && point.properties.year <= yearMax){
                        nbObs +=1;
                    }
                });

                $("#nbObs").html("Nombre d'observation(s): " + nbObs);
            });

            mySlider.on("change", function () {
                years = mySlider.getValue();
                yearMin = years[0];
                yearMax = years[1];

                $("#yearMin").html(yearMin + "&nbsp;&nbsp;&nbsp;&nbsp;");
                $("#yearMax").html("&nbsp;&nbsp;&nbsp;&nbsp;" + yearMax);
            });
        }
    }
});

// Gestion des clics sur les onglets de la MAP
document.addEventListener('DOMContentLoaded', function () {
    const ongletDate = document.getElementById('datemapTab');
    const ongletNb = document.getElementById('nbmapTab');

    ongletDate.addEventListener('click', function () {
        activerOnglet('date');
    });

    ongletNb.addEventListener('click', function () {
        activerOnglet('nb');
    });

    function activerOnglet(mode) {
        // Retirer la classe active des deux
        ongletDate.classList.remove('active');
        ongletNb.classList.remove('active');

        // on efface les couches affichées
        removeAllLayerFromMap();

        // Activer l'onglet cliqué
        if (mode === 'date') {
            ongletDate.classList.add('active');
            displayMailleLastObsLayerFicheEspece();
        } else {
            ongletNb.classList.add('active');
            displayMailleLayerFicheEspece();
        }
    }
});


function eventOnZoom(observationsMaille, observationsPoint) {
    // ZoomEvent: change maille to point
    var legendblock = $("div.info");
    var activeMode = "Maille";
    map.on("zoomend", function () {
        if (
            activeMode != "Point" &&
            map.getZoom() >= configuration.ZOOM_LEVEL_POINT
        ) {
            removeAllLayerFromMap();

            legendblock.attr("hidden", "true");

            var yearMin = null;
            var yearMax = null;
            if (configuration.MAP.ENABLE_SLIDER) {
                years = mySlider.getValue();
                yearMin = years[0];
                yearMax = years[1];
            }

            displayMarkerLayerFicheEspece(
                observationsPoint,
                yearMin,
                yearMax,
                sliderTouch
            );
            activeMode = "Point";
        }
        if (
            activeMode != "Maille" &&
            map.getZoom() <= configuration.ZOOM_LEVEL_POINT - 1
        ) {
            //pas besoin de recharger les données apres le changement de zoom
            //loadMailleLastObsLayerFicheEspece(observationsMaille, yearMin, yearMax, sliderTouch);
            //loadMailleLayerFicheEspece(observationsMaille, yearMin, yearMax, sliderTouch);

            removeAllLayerFromMap();

            // display legend
            legendblock.removeAttr("hidden");
            if (document.getElementById('datemapTab').classList.contains('active')) {
                displayMailleLastObsLayerFicheEspece();
            } else {
                displayMailleLayerFicheEspece();
            };
            activeMode = "Maille";
        }
    });
}

// Legende

htmlLegend =
    "<i style='border: solid " +
    configuration.MAP.BORDERS_WEIGHT +
    "px " +
    configuration.MAP.BORDERS_COLOR +
    ";'> &nbsp; &nbsp; &nbsp;</i> Limite du " +
    configuration.STRUCTURE;

generateLegende(htmlLegend);
