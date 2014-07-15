this.change_html = (elem, h) ->
  if $(elem).is(':hidden')
    $(elem).html(h)
  else
    wipe = -> $(elem).html("")
    setTimeout wipe, 601
