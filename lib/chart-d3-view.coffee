$ = jQuery = require 'jquery'
echarts = require 'echarts'
require 'echarts/theme/dark.js'



module.exports =
class ChartD3View

  @option = null
  @LineChart4FPS = null
  @gaugeg4FPS = null
  @option4gauge = null
  @app = {};

  constructor: (serializedState) ->
    # Create root element


    @element = document.createElement('div')
    @element.classList.add('chart-d3')

    @elementCharts = document.createElement('div')
    @elementCharts.classList.add('chart-d3-charts-div')



    # Create message element
    message = document.createElement('div')
    message.textContent = "The Chart Of Performance"
    message.classList.add('chart-d3-bar-title')

    # Create tabs for Chart
    controlButtons = document.createElement('div')
    controlButtons.classList.add('control-button-view')




    #create buttons
    controlRunButton = document.createElement('a')
    controlRunButton.classList.add('button','monitoring')
    controlRunButton.textContent = 'Monitoring'

    controlStopButton = document.createElement('a')
    controlStopButton.classList.add('button','stop-monitor')
    controlStopButton.textContent = 'Stop-Monitor'

    controlStopButton = document.createElement('a')
    controlStopButton.classList.add('button','stop-monitor')
    controlStopButton.textContent = 'Stop-Monitor'

    controlLogButton = document.createElement('a')
    controlLogButton.classList.add('button','logs')
    controlLogButton.textContent = 'Logs'

    controlPrintButton = document.createElement('a')
    controlPrintButton.classList.add('button','print')
    controlPrintButton.textContent = 'Print'

    # Create message element
    message = document.createElement('div')
    message.textContent = "The Chart Of Performance"
    message.classList.add('chart-d3-bar-title')

    # Create tabs for Chart
    chart4Fps = document.createElement('div')
    chart4Fps.classList.add('chart-fps-div')
    chart4Fps.setAttribute('style','width: 550px;height:400px;')

    # Create tabs for Chart
    chart4Fps2 = document.createElement('div')
    chart4Fps2.classList.add('chart-fps-div')
    chart4Fps2.setAttribute('style','width: 550px;height:400px;')

    # Create tabs for Chart
    chart4memory = document.createElement('div')
    chart4memory.classList.add('chart-fps-div')
    chart4memory.setAttribute('style','width: 550px;height:400px;')


    li4Item = document.createElement('li')
    li4Item.classList.add('fa','fa-bar-chart','li4Left')

    message.appendChild(li4Item)

    controlButtons.appendChild(controlRunButton)
    controlButtons.appendChild(controlStopButton)
    controlButtons.appendChild(controlLogButton)
    controlButtons.appendChild(controlPrintButton)



    @element.appendChild(message)
    @element.appendChild(controlButtons)
    @element.appendChild(@elementCharts)
    @elementCharts.appendChild(chart4Fps)
    @elementCharts.appendChild(chart4Fps2)
    @elementCharts.appendChild(chart4memory)

    #echarts.registerTheme('customed', @jsonData)
    @LineChart4FPS = echarts.init(chart4Fps,'dark')
    @gaugeg4FPS = echarts.init(chart4Fps2,'dark')




    # 指定图表的配置项和数据
    @option =
      title:{
        text: 'Frames Per Second Chart'
        textStyle:{

          fontSize:20
          fontFamily:'PT Sans Narrow, sans-serif'
        }
      }

      toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar', 'stack', 'tiled']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
      }
      calculable:true
      autoPlay:true
      loop:true
      playInterval:2000

        # 提示框
      tooltip: {
        trigger: 'axis',           # 触发类型，默认数据触发，见下图，可选为：'item' ¦ 'axis'
        showDelay: 20,             # 显示延迟，添加显示延迟可以避免频繁切换，单位ms
        hideDelay: 100,            # 隐藏延迟，单位ms
        transitionDuration : 0.4,  # 动画变换时间，单位s
        backgroundColor: 'rgba(0,0,0,0.7)',     # 提示背景颜色，默认为透明度为0.7的黑色
        borderColor: '#333',       # 提示边框颜色
        borderRadius: 4,           # 提示边框圆角，单位px，默认为4
        borderWidth: 0,            # 提示边框线宽，单位px，默认为0（无边框）
        padding: 5,                # 提示内边距，单位px，默认各方向内边距为5，
                                   # 接受数组分别设定上右下左边距，同css
        axisPointer : {            # 坐标轴指示器，坐标轴触发有效
            type : 'line',         # 默认为直线，可选为：'line' | 'shadow'
            lineStyle : {          # 直线指示器样式设置
                color: '#48b',
                width: 2,
                type: 'solid'
            },
            shadowStyle : {                       # 阴影指示器样式设置
                width: 'auto',                   # 阴影大小
                color: 'rgba(150,150,150,0.3)'  # 阴影颜色
            }
        },
        textStyle: {
            color: '#fff'
        }
      }

      legend: data: [ 'FPS Count' ]
      xAxis: [{
            type : 'category'
            boundaryGap : false
            data : ['周一','周二','周三','周四','周五','周六','周日','周一','周二','周三','周四','周五','周六','周日','周一','周二','周三','周四','周五','周六','周日','周一','周二','周三','周四','周五','周六','周日']
            axisLabel:{
                 #X轴刻度配置
                 #interval:0 #0：表示全部显示不间隔；auto:表示自动根据刻度个数和宽度自动设置间隔个数
                 auto:true
            }
        }
      ]

      yAxis: {
         type : 'value',
         #splitArea : {show : true}
      }
      series: [ {
        name: 'FPS'
        type: 'line'
        smooth:true
        itemStyle: {normal: {areaStyle: {type: 'dark'}}}
        data: [5,20,36,10,10,20,11,23,11,55,79,101,404]
      } ]
      backgroundColor:{222,222,222}

    #################################################################################################
    @option4gauge = {
      title:{
        text: 'Frames Per Second Gauge Chart'
        textStyle:{
          fontSize:20
          fontFamily:'PT Sans Narrow, sans-serif'
        }
        color : {78,154,188}
      }
      backgroundColor:{222,222,222}
      tooltip : {
        formatter: "{a} <br/>{b} : {c}%"
      },
      toolbox: {
        feature: {
            restore: {},
            saveAsImage: {}
        }
      },
      series: [
        {
            name: '业务指标',
            type: 'gauge',
            detail: {formatter:'{value}'},
            data: [{value: 50, name: 'FPS'}]
        }]
    }


    console.log @option4gauge.series[0].data[0].value

    setInterval((=>
      #data = (Math.random() * 100).toFixed(2) - 0
      #console.log @option4gauge.series[0].data[0].value
      #updateData(data)
      @option4gauge.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0
      @gaugeg4FPS.setOption @option4gauge, true
      return
    ), 2000)


    #使用刚指定的配置项和数据显示图表。
    @LineChart4FPS.setOption(@option,true);



  # Returns an
  updateData: (data) ->
    @option4gauge.series[0].data[0].value = data
    @gaugeg4FPS.setOption @option4gauge, true


  # Returns an object that can be retrieved when package is activated
  serialize: ->


  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
