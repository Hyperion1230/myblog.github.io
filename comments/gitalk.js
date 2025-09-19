(() => {
  const loadComments = async () => {
    if (typeof Gitalk === "undefined") {
      setTimeout(loadComments, 100);
    } else {
      const container = document.getElementById('gitalk-container');
      if (!container) {
        return;
      }
      const path = container.getAttribute("data-path");
      const gitalk = new Gitalk(Object.assign({
        //   id: path, // 直接使用路径作为 id
          id: container.getAttribute("data-path-hash"), // 使用 hash 作为 ID
          path: path,
      }, {
        clientID: 'Ov23liEPcwPsUXR6o3wk',
        clientSecret: 'c10c8e0b8605cbbb07977c874a7b628938d8bc87',
        repo: "myblog.github.io",
        owner: "Hyperion1230",
        admin: ["Hyperion1230"],
        distractionFreeMode: false,
      }));

      gitalk.render('gitalk-container');
    }
  };

  window.loadComments = loadComments;
  window.addEventListener('pjax:success', () => {
    window.loadComments = loadComments;
  });
})();
