document.addEventListener("turbo:load", () => {
  const likeButtons = document.querySelectorAll(".like-button");
  likeButtons.forEach((button) => {
    button.addEventListener("click", (e) => {
      e.preventDefault();

      const comboId = e.currentTarget.dataset.comboId;
      const url = `/combos/${comboId}/likes`;

      fetch(url, {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
          "Content-Type": "application/json",
          Accept: "application/json",
        },
      })
        .then((response) => response.json())
        .then((data) => {
          const likesCount = document.querySelector(`#likes-count-${comboId}`);
          likesCount.innerText = data.likes_count;
        });
    });
  });
});
