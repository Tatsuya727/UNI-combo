function getSelectedPrefixes() {
  const prefixCheckboxes = document.querySelectorAll(".prefix-filter");
  const selectedPrefixes = [];

  prefixCheckboxes.forEach((checkbox) => {
    if (checkbox.checked) {
      selectedPrefixes.push(checkbox.value);
    }
  });

  return selectedPrefixes;
}

// 選択された始動技に一致するコマンドのみ表示する
function filterCommands(selectedPrefixes) {
  const allPosts = document.querySelectorAll(".microposts li");

  if (selectedPrefixes.length === 0) {
    allPosts.forEach((post) => {
      post.style.display = "block";
    });
  } else {
    allPosts.forEach((post) => {
      const command = post.querySelector(".comando").textContent;
      const prefix = command.split(/[>\s]+/)[0];
      post.style.display = selectedPrefixes.includes(prefix) ? "block" : "none";
    });
  }
}

// ラジオボタンのうち選択されているもののvalueを返す
function getSelectedRadioValue(radioButtons) {
  let selectedValue = null;

  radioButtons.forEach((radio) => {
    if (radio.checked) {
      selectedValue = radio.value;
    }
  });

  return selectedValue;
}

// 選択されたラジオボタンに従ってコマンドを並べ替える
function sortPosts(attribute, order) {
  const allPosts = document.querySelectorAll(".microposts li");
  const postList = document.querySelector(".microposts");
  const sortedPosts = Array.from(allPosts).sort((a, b) => {
    const aValue = parseInt(a.querySelector(`.${attribute}`).textContent, 10);
    const bValue = parseInt(b.querySelector(`.${attribute}`).textContent, 10);

    if (order === "asc") {
      return aValue - bValue;
    } else {
      return bValue - aValue;
    }
  });

  postList.innerHTML = "";

  sortedPosts.forEach((sortedPost) => {
    postList.appendChild(sortedPost);
  });
}

// フィルタリングと並べ替えを適用する
document.addEventListener("turbo:load", function () {
  const applyFiltersButton = document.getElementById("apply-filters");
  const hitCountRadios = document.getElementsByName("hit_count_sort");
  const damageRadios = document.getElementsByName("damage_sort");
  const likesRadios = document.getElementsByName("likes_sort");

  if (applyFiltersButton) {
    applyFiltersButton.addEventListener("click", function () {
      const selectedPrefixes = getSelectedPrefixes();
      filterCommands(selectedPrefixes);

      const hitCountOrder = getSelectedRadioValue(hitCountRadios);
      const damageOrder = getSelectedRadioValue(damageRadios);
      const likesOrder = getSelectedRadioValue(likesRadios);

      if (hitCountOrder) {
        sortPosts("hit_count", hitCountOrder);
      } else if (damageOrder) {
        sortPosts("damage", damageOrder);
      } else if (likesOrder) {
        sortPosts("likes-count", likesOrder);
      }
    });

    // 始動技を1つだけ選択可能にする
    const prefixCheckboxes = document.querySelectorAll(".prefix-filter");
    prefixCheckboxes.forEach((checkbox) => {
      checkbox.addEventListener("change", function () {
        if (checkbox.checked) {
          prefixCheckboxes.forEach((otherCheckbox) => {
            if (otherCheckbox !== checkbox) {
              otherCheckbox.checked = false;
            }
          });
        }
      });
    });

    const commandoButtons = document.querySelector(".comando-button");
    if (commandoButtons) {
      commandoButtons.forEach((checkbox) => {
        checkbox.addEventListener("change", function () {
          if (checkbox.checked) {
            commandoButtons.forEach((otherCheckbox) => {
              if (otherCheckbox !== checkbox) {
                otherCheckbox.checked = false;
              }
            });
          }
        });
      });
    }

    // モーダルを閉じるイベント
    const closeModalButton = document.getElementById("close-modal");
    closeModalButton.addEventListener("click", function () {
      const modal = document.getElementById("filter-modal");
      modal.style.display = "none";
    });
  }
});

//  フィルタリングのみ適用する
document.addEventListener("turbo:load", function () {
  const applyFiltersButton = document.getElementById("apply-filters");
  if (applyFiltersButton) {
    applyFiltersButton.addEventListener("click", function () {
      const prefixFilterCheckboxes =
        document.querySelectorAll(".prefix-filter");
      const checkedPrefixes = Array.from(prefixFilterCheckboxes)
        .filter((checkbox) => checkbox.checked)
        .map((checkbox) => checkbox.value);
      filterCommands(checkedPrefixes);
    });
  }
});

//  並べ替えのみ適用する
document.addEventListener("turbo:load", function () {
  const openModalButton = document.getElementById("open-modal");
  const closeModalButton = document.getElementById("close-modal");
  const filterModal = document.getElementById("filter-modal");

  if (openModalButton) {
    openModalButton.addEventListener("click", function () {
      filterModal.style.display = "block";
    });
  }

  if (closeModalButton) {
    closeModalButton.addEventListener("click", function () {
      filterModal.style.display = "none";
    });
  }

  window.addEventListener("click", function (event) {
    if (event.target === filterModal) {
      filterModal.style.display = "none";
    }
  });
});

// リセットボタンを押したときに、フィルターと並べ替えをリセットする
document.addEventListener("turbo:load", function () {
  const resetFiltersButton = document.getElementById("reset-filters");

  if (resetFiltersButton) {
    resetFiltersButton.addEventListener("click", function () {
      // チェックボックスをリセット
      const prefixCheckboxes = Array.from(
        document.getElementsByTagName("input")
      ).filter(
        (input) =>
          input.type === "checkbox" && input.classList.contains("prefix-filter")
      );
      const situationCheckboxes =
        document.querySelectorAll(".situation-filter");
      prefixCheckboxes.forEach((checkbox) => {
        checkbox.checked = false;
      });
      situationCheckboxes.forEach((checkbox) => {
        checkbox.checked = false;
      });

      // ラジオボタンをリセット
      const hitCountRadios = document.getElementsByName("hit_count_sort");
      const damageRadios = document.getElementsByName("damage_sort");
      const likesRadios = document.getElementsByName("likes_sort");
      hitCountRadios.forEach((radio) => {
        radio.checked = false;
      });
      damageRadios.forEach((radio) => {
        radio.checked = false;
      });
      likesRadios.forEach((radio) => {
        radio.checked = false;
      });

      // セレクトボックスをリセット
      const characterSelect = document.getElementById("character-select");
      if (characterSelect) {
        characterSelect.value = "";
      }
    });
  }
});

// キャラクターによってコマンドを表示する
document.addEventListener("turbo:load", function () {
  var modalOptions = document.querySelectorAll(
    '#filter-modal input[type="checkbox"], #filter-modal input[type="radio"]'
  );

  var selectedOptionsElement = document.getElementById("selected-options");

  function updateSelectedOptions() {
    var selectedOptions = [];

    modalOptions.forEach(function (option) {
      if (option.checked || option.selected) {
        selectedOptions.push(option.parentElement.textContent.trim());
      }
    });

    if (selectedOptions.length > 0) {
      selectedOptionsElement.textContent =
        "選択されたオプション: " + selectedOptions.join(", ");
    } else {
      selectedOptionsElement.textContent = "選択されたオプション: なし";
    }
  }

  modalOptions.forEach(function (option) {
    option.addEventListener("change", updateSelectedOptions);
  });

  var applyFiltersButton = document.getElementById("apply-filters");
  if (applyFiltersButton) {
    applyFiltersButton.addEventListener("click", function () {
      updateSelectedOptions();
    });
  }
});
