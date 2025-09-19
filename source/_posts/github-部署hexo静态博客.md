---
title: github 部署hexo静态博客
comments: true
toc: true
donate: true
share: true
date: 2025-09-19 15:22:56
categories:
tags:
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

