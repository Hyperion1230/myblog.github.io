---
title: 记录一下使用kratos模板创建个人博客
comments: true
toc: true
donate: true
share: true
date: 2025-09-18 17:03:28
categories:
cover: pic1.png
tags:
- 记录
- kratos
---
## 记录一下使用kratos模板创建个人博客

以下是用于美化的css文件

花了一个下午研究这玩意，而且在一些奇怪的地方有BUG。

```css
.kratos-topnav {
  background: #085c0999 !important;
  justify-content: center;
  height: 80px;

}

.sf-menu {
  display: flex;
  justify-content: center;
}

#kratos-menu-wrap .sf-menu a {
  color: #ffffff;
  /* text-shadow: 0 0 10px #000000, 0 0 20px #000000, 0 0 30px #000000; */
  margin: 10px 10px;
  font-size: 20px;
}
#kratos-menu-wrap .sf-menu a {
  border: 2px solid #090909;
  background-color: #d4d4d499;
  border-radius: 15px;
}
#kratos-desktop-topnav .sf-menu>li>ul.sub-menu a {
    color: #000000;
}
.kratos-entry-footer .footer-tag a {
  color: #000000;
  background-color: #ffffff;
  border-radius: 15px;
}

```

最终成果如图：

![屏幕截图 2025-09-18 165919](pic1.png)







于2025年9月18日17:01:49，NJU