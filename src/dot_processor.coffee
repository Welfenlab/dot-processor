
markdownItGraph = require './md_graph'
d3 = require 'd3'
dagreD3 = require 'dagre-d3'
dot = require 'graphlib-dot'
uuid = require 'node-uuid'

dotProcessor = (tokens, graph_template, error_template) ->
  render = dagreD3.render()
  register: (mdInstance, postProcessors) ->
    markdownItGraph(tokens).register mdInstance, (graphStr) ->
      try
        graph = dot.read graphStr
        id = "dg-" + uuid.v4()
        postProcessors.registerElemenbById id, (elem, done) ->
            d3.select(elem).call(render, graph)
            svgElem = elem.getElementsByClassName('output')[0]
            svgHeight = svgElem?.getBoundingClientRect().height || 0
            elem.style.height = svgHeight + 22

            # remove arrows in undirected graphs
            if !graph.isDirected()
              tags = elem.getElementsByTagName('path')
              [].forEach.call tags, (e) ->
                e.setAttribute 'marker-end', ''

            done()

        # graph was parsed succesful
        return graph_template id: id

      # parsing errors..
      catch e
        return error_template error: e

    return null

module.exports = dotProcessor
