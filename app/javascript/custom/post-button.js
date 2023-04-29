window.addEventListener("turbo:load", function () {
  $(document).on("click", ".button-container button", function () {
    var comando = $(this).text();
    var input = $(".input-comando");
    var input_val = input.val();
    if (input_val == "") {
      input.val(comando);
    } else {
      input.val(input_val + " > " + comando);
    }
  });

  $(document).on("click", ".common-comando button", function () {
    var comando = $(this).text();
    var input = $(".input-comando");
    var input_val = input.val();
    if (input_val == "") {
      input.val(comando);
    } else {
      input.val(input_val + " > " + comando);
    }
  });

  // 一つ戻すボタンを押すと、最後のコマンドを消す
  $(document).on("click", ".system-button button", function () {
    var input = $(".input-comando");
    var input_val = input.val();
    var input_val_array = input_val.split(" > ");
    if (input_val_array.length > 1) {
      input_val_array.pop();
      input.val(input_val_array.join(" > "));
    }
  });

  $(document).on("click", ".delete-button", function () {
    var input = $(".input-comando");
    input.val("");
  });
});



// 一つ戻すボタンを押すと、最後のコマンドを消す
window.addEventListener("turbo:load", function () {
  $(document).on("click", ".system-button button", function () {
    var input = $(".input-comando");
    var input_val = input.val();
    var input_val_array = input_val.split(" > ");
    if (input_val_array.length > 1) {
      input_val_array.pop();
      input.val(input_val_array.join(" > "));
    }
  });
});

// すべて消すボタンを押すと、textareaの中身を消す
window.addEventListener("turbo:load", function () {
  $(document).on("click", ".delete-button", function () {
    var input = $(".input-comando");
    input.val("");
  });
});
