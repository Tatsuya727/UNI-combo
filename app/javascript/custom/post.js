// 選んだキャラクターによって、コンボの一覧を変更する

window.addEventListener("DOMContentLoaded", function () {
  $("#combo_character_id").on("change", function () {
    var character_id = $(this).val();
    $.ajax({
      url: "/combos/post_ajax",
      type: "GET",
      data: { character_id: character_id },
    })
      .done(function (partial) {
        $(".button-container").html(partial);
        console.log(partial);
      })
      .fail(function () {
        console.log("Failed to load partial");
      });
  });
});
