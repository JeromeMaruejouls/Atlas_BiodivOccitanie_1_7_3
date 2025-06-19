// ChartJS Graphs
const chartMainColor = getComputedStyle(document.documentElement).getPropertyValue('--main-color');
const chartHoverMainColor = getComputedStyle(document.documentElement).getPropertyValue('--second-color');

const getChartDatas = function (data, key) {
    let values = [];
    for (var i = 0; i < data.length; i++) {
        values.push(data[i][key])
    }
    return values
};

let delayedVert, delayedHorizon

let widthDecade, heightDecade, gradientDecade;
function getGradientDecade(ctx, chartArea) {
  const chartWidth = chartArea.right - chartArea.left;
  const chartHeight = chartArea.bottom - chartArea.top;
  if (!gradientDecade || widthDecade !== chartWidth || heightDecade !== chartHeight) {
    // Create the gradient because this is either the first render
    // or the size of the chart has changed
    widthDecade = chartWidth;
    heightDecade = chartHeight;
    gradientDecade = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
    // gradient.addColorStop(0, Utils.CHART_COLORS.blue);
    // gradient.addColorStop(0.5, Utils.CHART_COLORS.yellow);
    // gradient.addColorStop(1, Utils.CHART_COLORS.red);
    gradientDecade.addColorStop(0, '#7cb9e8'); //brun
    gradientDecade.addColorStop(0.25, '#a2c348'); //jaune
    gradientDecade.addColorStop(0.5, '#eec400'); //vert
    gradientDecade.addColorStop(0.75, '#bd6c48'); //vert
    gradientDecade.addColorStop(1, '#7cb9e8'); //bleu
  }

  return gradientDecade;
}


//Generic vertical bar graph
verticalBarChart = function (element, labels, values) {
    return new Chart(element, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'observations',
                data: values,
                borderColor: [
                    '#A4BEE1','#A4BEE1','#A4BEE1','#A4BEE1','#A4BEE1','#A4BEE1','#A4BEE1','#A4BEE1',
                    '#A4DB72',//printemps
                    '#A4DB72','#A4DB72','#A4DB72','#A4DB72','#A4DB72','#A4DB72','#A4DB72','#A4DB72',
                    '#FAF36B',//été
                    '#FAF36B','#FAF36B','#FAF36B','#FAF36B','#FAF36B','#FAF36B','#FAF36B','#FAF36B',
                    '#FFCD72',//automne
                    '#FFCD72','#FFCD72','#FFCD72','#FFCD72','#FFCD72','#FFCD72','#FFCD72','#FFCD72',
                    '#A4BEE1' //hiver
                ],
                backgroundColor: [
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4BEE180',
                    '#A4DB7280',//printemps
                    '#A4DB7280',
                    '#A4DB7280',
                    '#A4DB7280',
                    '#A4DB7280',
                    '#A4DB7280',
                    '#A4DB7280',
                    '#A4DB7280',
                    '#A4DB7280',
                    '#FAF36B80',//été
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FAF36B80',
                    '#FFCD7280',//automne
                    '#FFCD7280',
                    '#FFCD7280',
                    '#FFCD7280',
                    '#FFCD7280',
                    '#FFCD7280',
                    '#FFCD7280',
                    '#FFCD7280',
                    '#FFCD7280',
                    '#A4BEE180' //hiver
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{
                    gridLines: {
                        display: false
                    },
                    backgroundColor: function(context) {
                        const chart = context.chart;
                        const {ctx, chartArea} = chart;
                
                        if (!chartArea) {
                            // This case happens on initial chart load
                            return;
                        }
                        return getGradientDecade(ctx, chartArea);
                    }
                }]
            },
            maintainAspectRatio: false,
            plugins: {
                legend: {
                  position: 'top',
                  display: false
                },
            },
            animation: {
                onComplete: () => {
                    delayedVert = true;
                },
                delay: (context) => {
                    let delay = 0;
                    if (context.type === 'data' && context.mode === 'default' && !delayedVert) {
                        delay = context.dataIndex * 100 + context.datasetIndex * 100;
                    }
                    return delay;
                }
            }
        }
    });
};


let widthAlti, heightAlti, gradientAlti;
function getGradientAlti(ctx, chartArea) {
  const chartWidth = chartArea.right - chartArea.left;
  const chartHeight = chartArea.bottom - chartArea.top;
  if (!gradientAlti || widthAlti !== chartWidth || heightAlti !== chartHeight) {
    // Create the gradient because this is either the first render
    // or the size of the chart has changed
    widthAlti = chartWidth;
    heightAlti = chartHeight;
    gradientAlti = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
    gradientAlti.addColorStop(1, '#7e5e52'); //brun
    gradientAlti.addColorStop(0.6, '#dacd65'); //jaune
    gradientAlti.addColorStop(0.4, '#a8c74d'); //vert
    gradientAlti.addColorStop(0, '#96c6cd'); //bleu
  }

  return gradientAlti;
}

//Generic horizontal bar graph
horizontalBarChart = function (element, labels, values) {
    return new Chart(element, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'observations',
                data: values,
                backgroundColor: function(context) {
                    const chart = context.chart;
                    const {ctx, chartArea} = chart;
            
                    if (!chartArea) {
                        // This case happens on initial chart load
                        return;
                    }
                    return getGradientAlti(ctx, chartArea);
                },
                hoverBackgroundColor: chartHoverMainColor,
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            indexAxis: 'y',
            scales: {
                y: {
                    reverse: true
                },
                xAxes: [{
                    gridLines: {
                        display: false
                    }
                }]
            },
            elements: {
                bar: {
                    borderWidth: 2,
                }
            },
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                    display: false
                },
            },
            animation: {
                onComplete: () => {
                    delayedHorizon = true;
                },
                delay: (context) => {
                    let delay = 0;
                    if (context.type === 'data' && context.mode === 'default' && !delayedHorizon) {
                        delay = context.dataIndex * 100 + context.datasetIndex * 100;
                    }
                    return delay;
                }
            }
        }
    });
};



//Circle graph for b defaut area
bDefautPieChart = function (element, labels, values, colors) {
    return new Chart(element, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                    label: 'observations',
                    data: values,
                    backgroundColor: colors
                }],
            hoverOffset: 4
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              position: 'left',
            },
          }
        },
    })
};

var colorBDefaut_tab = [
    '#C22F11A0',//Med
    '#F6391BA0',
    '#EBE238A0',//SubMEd
    '#F0C254A0',
    '#536CFBA0',//PY
    '#3BADEBA0',
    '#ABA6A2A0',//causses
    '#6B6866A0',
    '#37AB4EA0',//MC
    '#31F53EA0',
    '#54DE21A0',
    '#22A82BA0'
  ];
//var monthChartElement = document.getElementById('monthChart');
//const monthChart = verticalBarChart(monthChartElement, months_name, getChartDatas(months_value, 'value'));

var altiChartElement = document.getElementById('altiChart');
const altiChart = horizontalBarChart(altiChartElement, getChartDatas(dataset, 'altitude'), getChartDatas(dataset, 'value'));

var decadeChartElement = document.getElementById('decadeChart');
const decadeChart = verticalBarChart(decadeChartElement, decades_name, getChartDatas(decades_value, 'value'));

var bdefautChartElement = document.getElementById('bdefautChart');
const bdefautChart = bDefautPieChart(bdefautChartElement, bdefaut_name, getChartDatas(bdefaut_value, 'value'), colorBDefaut_tab);
