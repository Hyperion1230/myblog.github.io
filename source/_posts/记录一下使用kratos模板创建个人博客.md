---
title: 记录一下使用kratos模板创建个人博客
comments: true
toc: true
donate: true
share: true
date: 2025-09-18 17:03:28
categories: Done!
cover: pic1.png
tags:
- 记录
- kratos
- Private
---
## 记录一下使用kratos模板创建个人博客

以下是用于美化的css文件

花了一个下午研究这玩意，而且在一些奇怪的地方有BUG。

```css
/* ==================== 导航栏样式 ==================== */
/* 修改导航栏背景色 */
.kratos-topnav {
  background: #085c0999 !important;
  justify-content: center;
  height: 80px;
}

/* 菜单居中显示 */
.sf-menu {
  display: flex;
  justify-content: center;
}

/* 调整导航字体大小和间距 */
#kratos-menu-wrap .sf-menu a {
  color: #ffffff;
  /* text-shadow: 0 0 10px #000000, 0 0 20px #000000, 0 0 30px #000000; */
  margin: 10px 10px;
  font-size: 20px;
}

/* 导航菜单项样式 */
#kratos-menu-wrap .sf-menu a {
  border: 2px solid #090909;
  background-color: #d4d4d499;
  border-radius: 15px;
}

/* 子菜单项文字颜色 */
#kratos-desktop-topnav .sf-menu>li>ul.sub-menu a {
    color: #000000;
}

/* 标签链接样式 */
.kratos-entry-footer .footer-tag a {
  color: #000000;
  background-color: #ffffff;
  border-radius: 15px;
}

/* ==================== 小部件样式 ==================== */
/* 关于小部件样式调整 */
#kratos-widget-area .widget.widget-kratos-about{
    padding-left: 0;
    padding-right: 0;
    padding-top: 0;
    border-radius: 15px
}

/* 最后一个小部件圆角 */
#kratos-widget-area .widget:last-child {
    border-radius: 15px;
}

/* ==================== 文章样式 ==================== */
/* 文章元信息圆角 */
.kratos-entry-border .kratos-entry-post-meta {
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
    border-bottom-right-radius: 15px;
    border-bottom-left-radius: 15px
}

/* 博客文章圆角 */
#kratos-blog-post .row article{
    border-radius: 15px;
}

/* 子菜单项样式 */
#kratos-desktop-topnav .sf-menu>li>ul.sub-menu li a {
    font-size: 15px;
    margin-left: auto;
    margin-right: auto;
    text-align: center;
}

/* 子菜单位置 */
#kratos-desktop-topnav .sf-menu>li>ul.sub-menu{
  left:0px;
}

/* 评论区域圆角 */
.kr-comments {
    border-radius: 15px;
}

/* ==================== 页面交互效果 ==================== */
/* 向下滚动时隐藏导航栏 */
body.scroll-down.nav-up #kratos-desktop-topnav {
    top:-81px
}

/* ==================== APlayer 音频播放器样式 ==================== */
/* APlayer 日间模式调整 */
/* 背景色 */
.aplayer {
  background: rgba(255, 255, 255, 0.6) !important;
  box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.07), 0 1px 5px 0 rgba(0, 0, 0, 0.1);
  position: relative;
}

/* 隐藏歌词滚动条 */
.aplayer.aplayer-fixed .aplayer-lrc:after,
.aplayer.aplayer-fixed .aplayer-lrc:before {
  display: none;
}

/* 固定播放器背景 */
.aplayer.aplayer.aplayer-fixed .aplayer-body {
  background: rgba(255, 255, 255, 0.6) !important;
  box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.07), 0 1px 5px 0 rgba(0, 0, 0, 0.1);
  position: fixed;
  border-radius: 6px;
}

/* 滚动条 */
.aplayer .aplayer-list ol::-webkit-scrollbar {
  width: 5px;
}

.aplayer .aplayer-list ol::-webkit-scrollbar-thumb {
  border-radius: 3px;
  background-color: var(--theme-color) !important;
}

.aplayer .aplayer-list ol::-webkit-scrollbar-thumb:hover {
  background-color: var(--theme-color) !important;
}

/* 圆角 */
.aplayer.aplayer-fixed .aplayer-list {
  border-radius: 6px 6px 0 0 !important;
}

.aplayer.aplayer-fixed .aplayer-miniswitcher {
  border-radius: 0 6px 6px 0 !important;
}

.aplayer.aplayer-fixed.aplayer-narrow .aplayer-body {
  transition: 0.28s !important;
  border-radius: 6px !important;
}

/* 选中与播放中歌曲激活颜色 */
.aplayer .aplayer-list ol li:hover {
  background: var(--theme-color) !important;
}

.aplayer .aplayer-list ol li.aplayer-list-light {
  background: var(--theme-color) !important;
}

/* 歌词 */
.aplayer-lrc p {
  color: #ffffff !important;
  text-shadow: #000000 1px 0 0, #000000 0 1px 0, #000000 -1px 0 0, #000000
      0 -1px 0 !important;
}

/* APlayer 黑暗模式 */
[data-theme="dark"] .aplayer {
  background: rgba(22, 22, 22, 0.6) !important;
  color: rgb(255, 255, 255);
  box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.07), 0 1px 5px 0 rgba(0, 0, 0, 0.1);
}

[data-theme="dark"] .aplayer.aplayer-fixed .aplayer-body {
  background: rgba(22, 22, 22, 0.6) !important;
  color: rgb(255, 255, 255);
  box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.07), 0 1px 5px 0 rgba(0, 0, 0, 0.1);
}

[data-theme="dark"]
  .aplayer
  .aplayer-info
  .aplayer-controller
  .aplayer-time
  .aplayer-icon
  path {
  fill: #d4d4d4;
}

[data-theme="dark"] .aplayer .aplayer-list ol li:hover {
  background: var(--theme-color) !important;
}

[data-theme="dark"] .aplayer .aplayer-list ol li.aplayer-list-light {
  background: var(--theme-color) !important;
}

[data-theme="dark"] .aplayer .aplayer-info .aplayer-controller .aplayer-time {
  color: #d4d4d4;
}

[data-theme="dark"] .aplayer .aplayer-list ol li .aplayer-list-index {
  color: #d4d4d4;
}

[data-theme="dark"] .aplayer .aplayer-list ol li .aplayer-list-author {
  color: #d4d4d4;
}

/* ==================== 主题背景色设置 ==================== */
/* 日间模式背景色 */
[data-theme="light"] .kratos-hentry, 
[data-theme="light"] .navigation div,
[data-theme="light"] #kratos-widget-area .widget {
    background-color: #ffffffed !important;
    border-radius: 15px
}

/* 黑暗模式背景色 */
[data-theme="dark"] .kratos-hentry, 
[data-theme="dark"] .navigation div, 
[data-theme="dark"] #kratos-widget-area .widget {
    background: #1a1a1aed !important;
    border-radius: 15px
}

/* ==================== 页面内容圆角 ==================== */
/* 页面内容圆角 */
.kratos-hentry.kratos-page-inner{
    border-radius: 15px;
}
#kratos-widget-area .widget.widget-kratos-about .photo-wrapper img {
    margin: -100px 0 0;
    width: 130px;
    height: 130px;
}

```

最终成果如图：

![屏幕截图 2025-09-18 165919](pic1.png)

-----

2025年9月24日更新：

安装了hexo-asset-image后发现文章的图都挂了。。。。

debug发现原来是链接地址多出了一个github的库名

第一次尝试修改._config.yml文件的URL

结果是在本地可以显示图片，而部署到github上就不行了

于是对插件进行了修改
```js
var beginPos = getPosition(link, '/', 3) + 1;
//改成
var beginPos = getPosition(link, '/', 4) + 1;
```



图片就加载出来了



于2025年9月18日17:01:49，NJU