class CrimesApp.LineChart

  constructor: (opts={})->
    @el   = opts.el
    @data = opts.data
    @year = opts.year

  render: ->
    $(@el).highcharts
      title:
        text: "#{@year} Crimes"
        x: -20
      xAxis:
        categories: _.map(@data, (d)->d[0])
      yAxis:
        min: 0
        title:
          text: ''
        plotLines: [
          value: 0,
          width: 1,
          color: '#808080'
        ]
      series: [{
          name: 'Crimes',
          data: _.map(@data, (d)->d[1])
      }]
