document.addEventListener("turbo:load", () => {
  let tabs = Array.prototype.slice.call(
    document.querySelectorAll("ul.nav-tabs > li > a")
  );
  tabs.forEach((tab) => {
    tab.addEventListener("click", (e) => {
      e.preventDefault();
      document.querySelectorAll("ul.nav-tabs > li").forEach((node) => {
        node.classList.remove("active");
        node.classList.remove("in");
      });
      document.querySelectorAll(".tab-pane").forEach((node) => {
        node.classList.remove("active");
        node.classList.remove("in");
      });
      tab.parentElement.classList.add("active");
      tab.parentElement.classList.add("in");
      document.querySelector(tab.getAttribute("href")).classList.add("active");
      document.querySelector(tab.getAttribute("href")).classList.add("in");
    });
  });
});
