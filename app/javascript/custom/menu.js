// ヘッダーのドロップダウンメニュー
document.addEventListener("turbo:load", function () {
  let hamburger = document.querySelector("#hamburger");
  hamburger.addEventListener("click", function (event) {
    event.preventDefault();
    let menu = document.querySelector("#navbar-menu");
    menu.classList.toggle("collapse");
  });

  let account = document.querySelector("#account");
  if (account) {
    account.addEventListener("click", function (event) {
      event.preventDefault();
      let menu = document.querySelector("#dropdown-menu");
      menu.classList.toggle("active");
    });
  }
});

// キャラクタータグのサイドメニュー
document.addEventListener("turbo:load", function () {
  let sideMenu = document.getElementById("side-menu");
  let sideMenuToggle = document.getElementById("side-menu-toggle");

  if (sideMenu) {
    sideMenuToggle.addEventListener("click", function () {
      sideMenu.classList.toggle("side-menu-collapsed");
      sideMenuToggle.innerHTML = sideMenu.classList.contains(
        "side-menu-collapsed"
      )
        ? "&#9658;"
        : "&#9668;";
    });
  }
});

// サイドメニューの開閉
function toggleSideMenu() {
  const sideMenu = document.getElementById("side-menu");
  const sideMenuToggle = document.getElementById("side-menu-toggle");

  if (sideMenu) {
    if (window.innerWidth <= 1500) {
      sideMenu.classList.add("side-menu-collapsed");
      sideMenuToggle.innerHTML = "&#9776;"; // ハンバーガーアイコン
    } else {
      sideMenu.classList.remove("side-menu-collapsed");
      sideMenuToggle.innerHTML = "&#9654;"; // 右矢印
    }
  }
}

document.addEventListener("DOMContentLoaded", function () {
  const sideMenu = document.getElementById("side-menu");
  const sideMenuToggle = document.getElementById("side-menu-toggle");

  if (sideMenuToggle) {
    sideMenuToggle.addEventListener("click", function () {
      sideMenu.classList.toggle("side-menu-collapsed");
      if (sideMenu.classList.contains("side-menu-collapsed")) {
        sideMenuToggle.innerHTML = "&#9776;"; // ハンバーガーアイコン
      } else {
        sideMenuToggle.innerHTML = "&#9654;"; // 右矢印
      }
    });
  }

  // ウィンドウのリサイズイベントを監視
  window.addEventListener("resize", toggleSideMenu);

  // 初期状態でサイドメニューを折りたたむか展開するかを設定
  toggleSideMenu();
});
