//= require active_admin/base
//= require activeadmin_addons/all
//= require active_material
//= require activeadmin_reorderable

$(function daumMap(model) {
  $.ajaxSetup({
    headers: {
      "X-CSRF-Token": $('meta[name="csrf-token"]').attr("content")
    }
  });

  let viewer = ImageViewer();
  $("img").click(function() {
    let imgSrc = this.src;
    viewer.show(imgSrc);
  });
});
