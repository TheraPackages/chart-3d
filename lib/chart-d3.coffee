ChartD3View = require './chart-d3-view'
{CompositeDisposable} = require 'atom'

module.exports = ChartD3 =
  chartD3View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @chartD3View = new ChartD3View(state.chartD3ViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @chartD3View.getElement(), visible: false)


    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'chart-d3:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @chartD3View.destroy()

  serialize: ->
    chartD3ViewState: @chartD3View.serialize()

  toggle: ->
    console.log 'ChartD3 was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
