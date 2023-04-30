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
function filterCommands(prefixes) {
  const listItems = document.querySelectorAll('.microposts li');
  listItems.forEach(item => {
    const commandElement = item.querySelector('.comando');
    const commandText = commandElement.textContent;
    const commands = commandText.split('>');
    const hasMatchingPrefix = commands.some(command => prefixes.includes(command));
    if (hasMatchingPrefix) {
      item.style.display = 'list-item';
    } else {
      item.style.display = 'none';
    }
  });
}

document.addEventListener('turbo:load', function() {
  const applyFiltersButton = document.getElementById('apply-filters');
  applyFiltersButton.addEventListener('click', function() {
    const prefixFilterCheckboxes = document.querySelectorAll('.prefix-filter');
    const checkedPrefixes = Array.from(prefixFilterCheckboxes)
      .filter(checkbox => checkbox.checked)
      .map(checkbox => checkbox.value);
    filterCommands(checkedPrefixes);
  });
});

document.addEventListener('turbo:load', function() {
  const openModalButton = document.getElementById('open-modal');
  const closeModalButton = document.getElementById('close-modal');
  const filterModal = document.getElementById('filter-modal');

  openModalButton.addEventListener('click', function() {
    filterModal.style.display = 'block';
  });

  closeModalButton.addEventListener('click', function() {
    filterModal.style.display = 'none';
  });

  window.addEventListener('click', function(event) {
    if (event.target === filterModal) {
      filterModal.style.display = 'none';
    }
  });
});


