function attachCommandButtonListeners() {
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
}

function loadHandler() {
  attachCommandButtonListeners();
}

function renderHandler() {
  document.removeEventListener("turbo:load", loadHandler); // ロードイベントのリスナーを削除
  attachCommandButtonListeners();
  setTimeout(function () {
    // 少し遅延させてロードイベントのリスナーを再登録
    document.addEventListener("turbo:load", loadHandler);
  }, 0);
}

document.addEventListener("turbo:load", loadHandler);
document.addEventListener("turbo:render", renderHandler);

function attachBackDeleteButtonListeners() {
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
  if (inputComando) {
    backButton.addEventListener("click", handleBackButtonClick);
    deleteButton.addEventListener("click", handleDeleteButtonClick);
  }
}

document.addEventListener("turbo:load", attachBackDeleteButtonListeners);
document.addEventListener("turbo:render", attachBackDeleteButtonListeners);
