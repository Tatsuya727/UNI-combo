// 選んだキャラクターによって、コンボの一覧を変更する

document.addEventListener("turbo:load", function () {
  var comboCharacterId = document.querySelector("#combo_character_id");

  if (comboCharacterId) {
    comboCharacterId.addEventListener("change", function () {
      var character_id = this.value;
      var xhr = new XMLHttpRequest();
      xhr.open("GET", "/combos/post_ajax?character_id=" + encodeURIComponent(character_id), true);

      xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 400) {
          var buttonContainer = document.querySelector(".button-container");
          if (buttonContainer) {
            buttonContainer.innerHTML = xhr.responseText;
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