class CrimesApp.BubbleMapChart

  constructor: (opts)->
    @el = opts.el

  render: ->
    map = L.map(@el).setView([51.769408, -2.834209], 5)

    @renderTileLayer(map)
    @renderBubbles(map)
    @renderLegend(map)

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
    circle = L.circle([51.769408, -2.834209], 50000, {
      color: 'red',
      fillColor: '#f03',
      fillOpacity: 0.5
    }).addTo(map)

    circle.bindPopup("I am a circle.")
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
