class CrimesApp.BarChart

  constructor: (opts={})->
    @el = opts.el
    @data = _.sortBy(opts.data, (d)-> -d.count)

  render: ->
    $(@el).highcharts
      chart:
        type: 'bar'
      title:
        text: 'Top Forces'
      xAxis:
        type: 'category'
      yAxis:
        title:
          text: 'Count'
      legend:
        enabled: false
      tooltip:
        pointFormat: '<b>{point.y}</b>'
      series: [{
        data: _.map(@data, (d)-> {name: d.force, y: d.count} )
      }]
