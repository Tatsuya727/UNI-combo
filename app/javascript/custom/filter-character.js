// 選んだキャラクターによってコマンドを出す
document.addEventListener("turbo:load", function () {
  var comboCharacterId = document.querySelector("#character-select");

  if (comboCharacterId) {
    comboCharacterId.addEventListener("change", function () {
      var character_id = this.value;
      var xhr = new XMLHttpRequest();
      xhr.open(
        "GET",
        "/combos/filter_ajax?character_id=" + encodeURIComponent(character_id),
        true
      );

      xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 400) {
          var comandoContainer = document.querySelector(".comando-container");
          if (comandoContainer) {
            comandoContainer.innerHTML = xhr.responseText;
          }
          console.log(xhr.responseText);
        } else {
          console.error("Failed to load partial");
        }
      };

      xhr.onerror = function () {
        console.error("Failed to load partial");
      };

      xhr.send();
    });
  }
});
