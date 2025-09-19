---
title: github 部署hexo静态博客
comments: true
toc: true
donate: true
share: true
date: 2025-09-19 15:22:56
categories:
tags:
- 记录
- hexo
---

## 部署hexo到Github

### 一、创建github项目仓库

在github页面创建一个自己的仓库，这个应该没啥问题

![image-20250919152645642](152543.png)

然后拉取远程仓库（我这边用的是kratos rebirth的模板，以下以此模板为例）

```bash
git clone https://github.com/kratos-rebirth/quickstart.git
npm install


```

修改完配置后用hexo进行部署

==注意==：在部署的时候分支与修改格式内容的分支尽量重命名，以免后期发生git merge事件！！！

------

### 二、之后就是hexo的部署

```bash
hexo clean
hexo g
hexo d
```

然后就完成部署了

-----

### 更新：

尝试部署到cloudflare上，但是发现静态文件的路径不可用，部署上的网页无法渲染，遂修改静态资源路径，重新开设了一个分支cloudflare，但是后来发现要更新2次就放弃了。。。

-----

真恶心，晚上用mac推送博文发现疯狂报错：

> Error: Spawn failed
>     at ChildProcess.<anonymous> (/Users/dasiweida/Blog/myblog.github.io/node_modules/hexo-deployer-git/no
> de_modules/hexo-util/lib/spawn.js:51:21)
>     at ChildProcess.emit (node:events:508:28)
>     at ChildProcess._handle.onexit (node:internal/child_process:294:12)

死活推送不到github

尝试了包括但不限于以下方法：

1. 重新删除`.deploy-git`文件：没用
2. 修改整个目录权限：没用
3. 最后终于给我找的了，原来是git push的缓冲区有限制！！！太坑了！

```bash
git config --golbal http.postBuffer
```

