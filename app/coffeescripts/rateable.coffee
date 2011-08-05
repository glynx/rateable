rate = (star) ->
  url = star.data()["url"]
  stars = star.data()["stars"]
  $.ajax url,
    type: "POST"
    data: 
      stars : stars
    dataType: "html"
    error: (resp) ->
      window.reload()
    success: (resp) ->
      star.parent().replaceWith(resp)

jQuery ->
  $(".rating a").bind "click", (e) ->
    rate $(this)
    e.preventDefault()
