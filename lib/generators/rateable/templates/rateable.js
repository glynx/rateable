/* DO NOT MODIFY. This file was compiled Fri, 05 Aug 2011 22:17:18 GMT from
 * /home/andre/Dokumente/yvi/comics/app/coffeescripts/rateable.coffee
 */

var rate;
rate = function(star) {
  var stars, url;
  url = star.data()["url"];
  stars = star.data()["stars"];
  return $.ajax(url, {
    type: "POST",
    data: {
      stars: stars
    },
    dataType: "html",
    error: function(resp) {
      return window.reload();
    },
    success: function(resp) {
      return star.parent().replaceWith(resp);
    }
  });
};
jQuery(function() {
  return $(".rating a").bind("click", function(e) {
    rate($(this));
    return e.preventDefault();
  });
});