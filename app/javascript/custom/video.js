document.addEventListener("turbo:load", () => {
  const video = document.getElementById("video");
  const playbackSpeedSelect = document.getElementById("playbackSpeed");
  const toggleLoopButton = document.getElementById("toggleLoop");

  if (video) {
    playbackSpeedSelect.addEventListener("change", () => {
      video.playbackRate = parseFloat(playbackSpeedSelect.value);
    });

    toggleLoopButton.addEventListener("click", () => {
      video.loop = !video.loop;

      if (video.loop) {
        toggleLoopButton.textContent = "ループ：オン";
      } else {
        toggleLoopButton.textContent = "ループ：オフ";
      }
    });
  }
});
