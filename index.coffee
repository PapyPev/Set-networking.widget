
# Appearance
width        = '367px'
barHeight    = '36px'
labelColor   = '#fff'
usedColor    = '#d7051d'
freeColor    = '#525252'
bgColor      = '#fff'
borderRadius = '3px'
bgOpacity    = 0.9

command:"Set-networking.widget/getnet.sh"

refreshFrequency: 5000

style: """

  // Align contents left or right
  widget-align = left
  
  // Position where you want
  top: 170px
  left: 10px
  
  // Statics text settings
  color: #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 15px
  border-radius 5px
  
  // Style
  .container
    width: 300px
    text-align: widget-align
    position: relative
    clear: both

  .container:not(:first-child)
    margin-top: 20px

  .widget-title
    text-align: widget-align

  .stats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  td.pctg
    float: right

  .widget-title, p
    font-size 10px
    text-transform uppercase
    font-weight bold

  .label
    font-size 8px
    text-transform uppercase
    font-weight bold


"""

humanize: (sizeString) ->
  sizeString + 'B'


render: (output) -> """
  <div class="container">
    <div class="widget-title">Network - Wifi</div>
    <table class="stats-container" width="100%">
	  <tr>
	  	<td class="stat"><span class="used">IP Addr :</span></td>
	    <td class="stat pctg"><span class="used"><div class="ip"></div></span></td>
	  </tr>
	  <tr>
	  	<td class="stat"><span class="used">Netmask :</span></td>
	    <td class="stat pctg"><span class="used"><div class="netmask"></div></span></td>
	  </tr>
	  <tr>
	  	<td class="stat"><span class="used">Gateway :</span></td>
	    <td class="stat pctg"><span class="used"><div class="gateway"></div></span></td>
	  </tr>
    </table>
    <div class="bar-container">
      <div class="bar bar-used" style="width: 10"></div>
    </div>
  </div>
"""

afterRender: (domEl) ->
  
  $(domEl).find('.static').on 'click', => @run("networksetup -setmanual \"Wi-Fi\" " + $(domEl).find('.ip').val() + " " + $(domEl).find('.netmask').val() + " " + $(domEl).find('.gateway').val())
  $(domEl).find('.dhcp').on 'click', =>@run("networksetup -setdhcp \"Wi-Fi\" ")

update: (output, domEl) ->

  data = JSON.parse output
  console.log()
  $(domEl).find('.ip').html(data.service.ipaddress)
  $(domEl).find('.netmask').html(data.service.netmask)
  $(domEl).find('.gateway').html(data.service.gateway)

