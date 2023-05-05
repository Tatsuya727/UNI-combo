document.addEventListener("turbo:load", () => {
  const video = document.getElementById("video");
  const playbackSpeedSelect = document.getElementById("playbackSpeed");
  const toggleLoopButton = document.getElementById("toggleLoop");

  playbackSpeedSelect.addEventListener("change", () => {
    video.playbackRate = parseFloat(playbackSpeedSelect.value);
  });

  toggleLoopButton.addEventListener("click", () => {
    video.loop = !video.loop;

    // ボタンのテキストを更新して、ループが有効かどうかを表示します。
    if (video.loop) {
      toggleLoopButton.textContent = "ループ：オン";
    } else {
      toggleLoopButton.textContent = "ループ：オフ";
    }
  });
});
