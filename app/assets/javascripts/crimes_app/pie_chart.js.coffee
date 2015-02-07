class CrimesApp.PieChart

  constructor: (opts={})->
    @el = opts.el
    @data = _.map(opts.data, (d)->([d.force, d.count]))

  render: ->
    $(@el).highcharts
      chart:
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false
      title:
          text: 'Forces'
      tooltip:
        pointFormat: '<b>{point.percentage:.1f}%</b>'
      plotOptions:
        pie:
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels:
            enabled: false
          showInLegend: true
      series: [{
        type: 'pie',
        name: 'Browser share',
        data: @data
      }]
