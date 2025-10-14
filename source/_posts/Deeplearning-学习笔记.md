---
title: Artificial intelligence Deeplearning 学习笔记
comments: true
toc: true
donate: true
share: true
date: 2025-09-25 10:53:01
categories: Unfinished
cover: image-20250925105713663.png
tags:
- AI
- 记录
---

**本学习笔记是基于“李宏毅机器学习深度学习系列”视频及PDF所建立的，所以的学习资源都可以在互联网上找到**。

# 第一节：理解What‘ is ML/DL？

机器学习的本质：找一个复杂的==f(x)==能够解决复杂的问题。

## 机器学习的类别：

`Regression`(回归)，`Classification`(分类)，`Structured`(创造)。

## case1

预测视频观看人数：

### step1: Build Model

Model:
$$
y=b+wx
$$
其中 $y$ 和 $x$ 为已知的数值，而b（bias）与w（weight）是位置的

### step2: Define Loss Funcaiton

定义：
$$
L(b,w)
$$
计算：

假设
$$
L(0.5k,1)
$$
则可知
$$
0.5k+x=y
$$
带入已知的 $x$ 得到的 $y$ 与 $\widehat{y}$ 直接的差距 $e$，把所有数据的 $x$ 代入得到的 $y$ 与 $\widehat{y}$的差距 $e$ 求和，可以得到下面的公式
$$
LOSS=\frac{1}{n}\sum^{n}e_n
$$
其中当：
$$
e=|y-\widehat{y}|
$$
时 $L$ 称为mean absolute error（MAE）

> 待补充

当：
$$
e=(y-\widehat{y})^2
$$
时 $L$ 称为mean square error （MSE）

> 待补充

### step3 Optimization

使用方法：

**梯度下降 `Gradient Descent`**

解释：通过对损失函数Loss`微分`进行计算来判断某个参数的最优值。

> Hyperparameters: 超参数
>
> such as：学习率 $\eta$、最大学习次数

$$
改变值=\eta * \Delta dy(w_0的微分)
$$



==Local minimum==: 

​	在机器学习中局部最小值（Local minimum）是指在此处所有参数对损失（Loss）的微分为0，这个问题其实并不常见，对于二维的损失函数而言，在任意的一个$W$对L导数为0时则为其局部最小值，而非严格最小值（Strict minimum）。但随着维数增加，我们可以发现，有一种情况也可能导致其$W$对Loss的导数为0，这种情况就是==鞍点（Saddle point）==。

​	那我们如何判断我们是否在Local Minimun还是在Saddle Point呢？这时候就有一个十分巧妙的构思。已知，机器学习的过程可以大致的看成是在求整合方程体系对输入值与输出值之间的

-----

ML总结流程：

![image-20250925131706899](Deeplearning-学习笔记/image-20250925131706899.png)

## 激活函数

Sigmoid Function：

![image-20250925133222014](Deeplearning-学习笔记/image-20250925133222014.png)

对于不同参数的sigmoid Function：

![image-20250925133411071](Deeplearning-学习笔记/image-20250925133411071.png)



**激活函数的意义：**

理论上机器学习的神经元是一个线性方程即 $y=b+w（x+b）$ ,当每个层有输入了大于1个特征后任继续使用线性方程函数来表达，这个层内的function则变为: $y=b_1,_2,_3...+w_1（x+b_1）x+w_2(x+b_2)+...w_n(x+b_n)$ 这样我们无论如何都只能得到一个线性方程，这显然与我们的希望相悖（自然界大多数事物之间的关系都不单纯是线性的，{% blur （这是一个哲学问题） %}），我们希望通过在一个层中使用不同的特征拟合一个能够预测或是分类其特征的方程。因此，我们需要改变每个单独特征对整体激活值的关系，将这种非线性关系叠加在一起来拟合我们的需求。因此我们在此引入了**激活函数**这个概念。

-----

