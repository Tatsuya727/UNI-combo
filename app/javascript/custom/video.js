window.addEventListener("turbo:load", function () {
  document.getElementById("increaseSpeed").addEventListener("click", function () {
      let video = document.getElementById("video");
      video.playbackRate = 2;
    });

  document.getElementById("decreaseSpeed").addEventListener("click", function () {
      let video = document.getElementById("video");
      video.playbackRate = 0.5;
    });

  document.getElementById("toggleLoop").addEventListener("click", function () {
    let video = document.getElementById("video");
    video.loop = !video.loop;
  });
});
