// ヘッダーのドロップダウンメニュー

document.addEventListener("turbo:load", function () {
  let hamburger = document.querySelector("#hamburger");
  hamburger.addEventListener("click", function (event) {
    event.preventDefault();
    let menu = document.querySelector("#navbar-menu");
    menu.classList.toggle("collapse");
  });

  let account = document.querySelector("#account");
  account.addEventListener("click", function (event) {
    event.preventDefault();
    let menu = document.querySelector("#dropdown-menu");
    menu.classList.toggle("active");
  });
});

// キャラクタータグのサイドメニュー
document.addEventListener("turbo:load", function () {
  let sideMenu = document.getElementById("side-menu");
  let sideMenuToggle = document.getElementById("side-menu-toggle");

  sideMenuToggle.addEventListener("click", function () {
    sideMenu.classList.toggle("side-menu-collapsed");
    sideMenuToggle.innerHTML = sideMenu.classList.contains(
      "side-menu-collapsed"
    )
      ? "&#9658;"
      : "&#9668;";
  });
});

// サイドメニューの開閉
document.addEventListener("DOMContentLoaded", function () {
  const sideMenu = document.getElementById("side-menu");
  const sideMenuToggle = document.getElementById("side-menu-toggle");

  function toggleSideMenu() {
    sideMenu.classList.toggle("side-menu-collapsed");
    if (sideMenu.classList.contains("side-menu-collapsed")) {
      sideMenuToggle.innerHTML = "&#9658;"; // 右矢印
    } else {
      sideMenuToggle.innerHTML = "&#9664;"; // 左矢印
    }
  }

  if (sideMenuToggle) {
    sideMenuToggle.addEventListener("click", toggleSideMenu);
  }

  function handleWindowResize() {
    if (window.innerWidth <= 991) {
      if (!sideMenu.classList.contains("side-menu-collapsed")) {
        toggleSideMenu();
      }
    } else {
      if (sideMenu.classList.contains("side-menu-collapsed")) {
        toggleSideMenu();
      }
    }
  }

  window.addEventListener("resize", handleWindowResize);
  handleWindowResize();
});
