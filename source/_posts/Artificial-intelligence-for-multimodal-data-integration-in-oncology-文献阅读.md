---
title: Artificial intelligence for multimodal data integration in oncology 文献阅读
comments: true
toc: true
donate: true
share: true
date: 2025-09-24 09:41:21
categories:
cover: COVER.png
tags:
- AI
- 文献阅读
---

# Artificial intelligence for multimodal data integration in oncology 文献阅读



## AI在肿瘤学中的应用

作者从方法上将AI分类为监督学习`supervised`，弱监督学习`weakly supervised`和无监督学习`unsupervised`

![FIG1](Artificial-intelligence-for-multimodal-data-integration-in-oncology-文献阅读/gr2.jpg)

### 监督学习

特点：使用了标注的数据点将输入的数据映射到提前定义的标签中

例子：

**人工标注**

> 优点：人工标注的优势在于不需要进行特征的计算，能够简化模型结构，降低计算成本。且由于预测使用的特征为人为选择，因此模型具有较高的可解释性（同时带来较低的可迁移性）。
>
> 不足：在特征提取时可能会存在人为偏见产生的偏差，同时对于很多人类无法捕捉到的信息被忽视，常常会导致无法对更深入的特征的捕获。

**表示学习方法**（以CNN为例）

> 通过卷积与池化来提取并压缩特征，同过多次的卷积与池化的交替，提取关键特征（卷积➡️非线性激活➡️池化。。。*重复这个过程* ）整个过程中卷积层提取特征。

  
