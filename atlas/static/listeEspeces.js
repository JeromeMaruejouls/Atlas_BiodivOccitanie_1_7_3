$(".lazy").lazy({
          effect: "fadeIn",
          effectTime: 2000,
          threshold: 0,
          appendScroll: $("#taxonList")
        });
$('[data-toggle="tooltip"]').tooltip();
$(document).ready(function(){
  $("#taxonInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});

function filterOiseaux(e){
  document.getElementById('taxonInput').value = "Oiseaux";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("oiseaux") > -1)
    });
  e.preventDefault();
}

function filterMammifères(e){
  document.getElementById('taxonInput').value = "Mammifères";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("mammiferes") > -1)
    });
  e.preventDefault();
}

function filterInsectes(e){
  document.getElementById('taxonInput').value = "Insectes";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("insectes") > -1)
    });
  e.preventDefault();
}

function filterAll(e){
  document.getElementById('taxonInput').value = "";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("") > -1)
    });
  e.preventDefault();
}

function filterReptiles(e){
  document.getElementById('taxonInput').value = "Reptiles";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("reptiles") > -1)
    });
  e.preventDefault();
}

//Filtres des plantes :
function filterAngiospermes(e){
  document.getElementById('taxonInput').value = "Angiospermes";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("angiospermes") > -1)
    });
  e.preventDefault();
}

function filterGymnospermes(e){
  document.getElementById('taxonInput').value = "Gymnospermes";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("gymnospermes") > -1)
    });
  e.preventDefault();
}

function filterFougeres(e){
  document.getElementById('taxonInput').value = "Fougères";
    $("#taxonList li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf("fougeres") > -1)
    });
  e.preventDefault();
}