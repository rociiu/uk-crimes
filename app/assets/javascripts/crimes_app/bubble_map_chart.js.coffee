class CrimesApp.BubbleMapChart

  constructor: (opts)->
    @el = opts.el
    @data = opts.data

  render: ->
    map = L.map(@el).setView([52.810871, -4.563929], 6)

    @renderTileLayer(map)
    @renderBubbles(map)
    # @renderLegend(map)

  renderTileLayer: (map)->
    L.tileLayer(
      'https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                'Imagery © <a href="http://mapbox.com">Mapbox</a>'
        id: 'examples.map-i875mjb7'
    }).addTo(map)

  renderBubbles: (map)->
    counts = _.map(@data, (d)->d.count)
    @scale = d3.scale.linear().domain([d3.min(counts), d3.max(counts)]).range([0, 100000])
    for d in @data
      @renderBubble(map, d, @scale(d.count))

  renderBubble: (map, d, radius)->
    circle = L.circle([d.lat, d.lon], radius, {
      color: 'red',
      fillColor: '#f03',
      fillOpacity: 0.5
    }).addTo(map)

    circle.bindPopup("#{d.force}: #{d.count}")
    circle.on('mouseover', (e)->
      @openPopup()
    )
    circle.on('mouseout', (e)->
      @closePopup()
    )

  renderLegend: (map)->
    legend = L.control({position: 'bottomright'})
    legend.onAdd = (map)=>
      div = L.DomUtil.create('div', 'info legend')
      grades = [0, 10, 20, 50, 100, 200, 500, 1000]
      labels = []
      _.each grades, (grade, i)=>
        div.innerHTML += '<i style="background:' + @getColor(grade + 1) + '"></i> ' + grade + (if grades[i + 1] then ('-' + grade + '<br>') else '+')
      div
    legend.addTo(map)

  getColor: (d)->
    return '#800026' if d > 1000
    return '#BD0026' if d > 500
    return '#E31A1C' if d > 200
    return '#FC4E2A' if d > 100
    return '#FD8D3C' if d > 50
    return '#FEB24C' if d > 20
    return '#FED976' if d > 10
    '#FFEDA0'
