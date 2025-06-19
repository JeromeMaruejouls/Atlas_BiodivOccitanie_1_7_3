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

//Circle graph for parts graph
circleChart = function (element, labels, values, colors) {
    return new Chart(element, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                    label: 'observations',
                    data: values,
                    backgroundColor: colors
                }]
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

var color_tab = [
    '#E1CE7AA0',
    '#FBFFB9A0',
    '#FDD692A0',
    '#EC7357A0',
    '#754F44A0',
    '#FB6376A0',
    '#B7ADCFA0',
    '#DEE7E7A0',
    '#F4FAFFA0',
    '#383D3BA0',
    '#7C7C7CA0',
    '#B5F44AA0',
    '#D6FF79A0',
    '#507255A0',
    '#381D2AA0',
    '#BA5624A0',
    '#FFA552A0',
    '#F7FFE0A0',
    '#49C6E5A0',
    '#54DEFDA0',
    '#0B5563A0',
    '#54DEFDA0'
  ];

var groupChartElement = document.getElementById('groupChart');
const groupChart = circleChart(groupChartElement, getChartDatas(dataset, 'group2_inpn'), getChartDatas(dataset, 'nb_obs_group'), color_tab);
