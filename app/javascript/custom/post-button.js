document.addEventListener("turbo:load", function () {
  const inputComando = document.querySelector(".input-comando");
  const buttonContainer = document.querySelector(".button-container");

  // ボタンのクリックイベントを処理する関数
  function handleButtonClick(event) {
    if (event.target.classList.contains("comando-button")) {
      // テキストエリアの値が空でない場合、">"を追加
      const prefix = inputComando.value.length > 0 ? " > " : "";

      // ボタンのテキストをテキストエリアに挿入
      inputComando.value += prefix + event.target.textContent;
    }
  }

  // 静的なボタンにイベントリスナーを追加
  const comandoButtons = document.querySelectorAll(".comando-button");
  comandoButtons.forEach((button) => {
    button.addEventListener("click", handleButtonClick);
  });

  // 動的なボタンにイベントリスナーを追加
  if (buttonContainer) {
    buttonContainer.addEventListener("click", handleButtonClick);
  }
});

document.addEventListener("turbo:load", function () {
  const inputComando = document.querySelector(".input-comando");
  const backButton = document.querySelector(".back-button");
  const deleteButton = document.querySelector(".delete-button");

  // 一つ戻すボタンのクリックイベントを処理する関数
  function handleBackButtonClick() {
    const lastIndexOfArrow = inputComando.value.lastIndexOf(" > ");

    if (lastIndexOfArrow !== -1) {
      inputComando.value = inputComando.value.slice(0, lastIndexOfArrow);
    } else {
      inputComando.value = "";
    }
  }

  // すべて消すボタンのクリックイベントを処理する関数
  function handleDeleteButtonClick() {
    inputComando.value = "";
  }

  // ボタンにイベントリスナーを追加
  backButton.addEventListener("click", handleBackButtonClick);
  deleteButton.addEventListener("click", handleDeleteButtonClick);
});
