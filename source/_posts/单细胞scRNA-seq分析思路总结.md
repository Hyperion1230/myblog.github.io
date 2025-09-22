---
title: 单细胞scRNA-seq分析思路总结
comments: true
toc: true
donate: true
share: true
date: 2025-09-19 19:09:47
categories:
tags:
- 单细胞
- scRNA-seq
- Private
---


**单细胞分析思路**，把常见的步骤和逻辑框架讲清楚。这里主要以 **单细胞转录组（scRNA-seq）** 为例。

------

# 具体流程

## **数据准备与质控 (QC)**

- **输入**：原始 UMI/reads 矩阵（细胞 × 基因）。
- **目标**：筛掉低质量细胞，保证分析结果可靠。
- **常见 QC 指标**：
  - 每个细胞的总 reads/UMI 数（低了可能是坏细胞，高了可能是双细胞 doublet）。
  - 检测到的基因数。
  - 线粒体基因比例（过高说明细胞可能坏死）。
- **操作**：
  - `subset`、`filter` 去掉异常细胞。
  - `DoubletFinder` / `Scrublet` 识别双细胞。

{% collapse 具体方法 %}

```R
#TODO
```

{% endcollapse %}

------

## **标准化与特征选择**

**归一化 (Normalize)**：

- LogNormalize：每个细胞的 counts 除以总数 × scale.factor，再 log1p。

{% alertpanel info 标准化意义 %}

1. **消除文库大小差异**

- 每个细胞的表达量变成“相对表达”，能直接比较不同细胞。

2. **突出生物差异**

- 高表达的基因被 log 压缩，不至于主导后续分析；
- 中低表达的差异会更明显，利于发现 marker 基因。

3. **为下游分析提供可比性输入**

- PCA、聚类、UMAP 等方法都需要输入可比较的数值矩阵。
- LogNormalize 后的矩阵能让算法真正捕捉生物学差异，而不是技术噪音。

{% endalertpanel %}

**高变基因选择 (FindVariableFeatures)**：

- 找出在细胞间变异度最高的一批基因（常用 2000）。

{% collapse 具体方法 %}

🔬 Seurat 内置的三种方法

在 `FindVariableFeatures()` 里可以设置 `selection.method`：

1. `"vst"`（Variance Stabilizing Transformation）👉 默认、推荐

- **思路**：

  - 对每个基因，在所有细胞里的表达做方差估计；
  - 把方差和均值之间的关系建模（负二项分布近似）；
  - 计算残差方差（observed variance / expected variance）。

- **特点**：

  - 在去除了均值依赖性后，能稳健地挑出高变基因；
  - 对高表达基因不会过度偏向；
  - 推荐作为大多数 scRNA-seq 分析的标准方法。

  ------

  2. `"mean.var.plot"`（MVP，均值-方差图方法）

- **思路**：

  - 把基因按均值分成 bins；
  - 计算每个基因在 bin 内的 `z-score`（方差相对 bin 内基因的偏高程度）；
  - 取方差最高的一批基因。

- **特点**：

  - 方法简单直观，可以画图展示（Mean-Variance Plot）。
  - 对噪音和批次效应敏感，不如 `vst` 稳健。

  ------

  3. `"dispersion"`（离散度方法）

- **思路**：

  - 类似于 MVP，但直接用 **标准化后的方差/均值比（dispersion）** 来挑基因。

- **特点**：

  - 速度快；
  - 但容易偏向于低均值、相对离散度高的基因。

{% endcollapse %}

**缩放 (ScaleData)**：

- `Z-score` 标准化基因表达，用于 PCA 等。

{% collapse 'what is Z-score' %}

**Z-score**（标准分数、标准化值）是统计学里常用的一个指标，表示一个数值偏离平均值多少个标准差。

公式：
$$
z=\frac{x−μ}{σ}
$$

`x`：某个观测值

`μ`：总体/样本的平均值

`σ`：总体/样本的标准差

-----

 **在单细胞分析里的应用**

- 在 **高变基因筛选（mean.var.plot 方法）** 中，Seurat 会把基因按表达均值分成 bins：
  - 先算每个基因的方差；
  - 再和同 bin 内的基因比较，用 `z-score` **标准化**，得到它在该均值水平下是否“比平均更离散”。
- 高 `z-score` → 说明这个基因在同水平基因里“更变异”，可能是高变基因。

> **z-score 就是“标准化的偏离程度”**，告诉你一个值比均值高/低了多少个标准差。
>  在单细胞分析里，它常被用来比较基因在不同均值水平下的方差是否异常高，从而识别高变基因。

{% endcollapse %}

------

## **降维**

**线性降维 (PCA)**：

- 提取主要变异维度。

> **对于非同一批次的数据进行整合需对批次效应进行排除**

{% collapse "常见的去除批次效应的方法"  %}

## 1. **Harmony**

- **简介**：Harmony 是一个非常强大的 **批次效应校正工具**，它通过在低维空间（通常是 PCA 空间）里对批次信息进行校正，迭代优化嵌入坐标，使得同一类型的细胞跨批次聚合，而不同类型的细胞仍然保持分开。

- **使用方式**：

  ```R
  obj <- RunHarmony(
      object = obj,
      group.by.vars = "batch",   # 批次信息
      reduction.use = "pca",     # 使用 PCA 空间
      reduction.name = "harmony",  # 输出降维名称
      dims.use = 1:30            # 使用的主成分数目
  )
  ```

- **优点**：

  - 通过 **soft clustering** 方法校正批次效应，而不仅仅是按批次分配。
  - 适用于大规模数据集，且处理速度较快。

- **适用场景**：

  - 数据来源于不同的批次、实验条件、平台或样本，需要整合成一个一致的低维表示。

------

## 2. **ComBat (from sva package)**

- **简介**：ComBat 是一种常用的 **批次效应校正方法**，基于 **贝叶斯模型**，用于从数据中去除批次效应。它通过调节每个基因在不同批次之间的均值和方差，使得不同批次之间的基因表达更加一致。

- **使用方式**：

  ```R
  library(sva)
  obj$batch <- as.factor(obj$batch)  # 批次信息列
  obj$gene_expression_corrected <- ComBat(
      dat = obj$RNA@data, 
      batch = obj$batch, 
      mod = NULL, 
      par.prior = TRUE, 
      prior.plots = FALSE
  )
  ```

- **优点**：

  - ComBat 方法是广泛应用于多组学数据的标准方法，适用于连续数据。
  - 在批次效应较为显著时效果明显。

- **适用场景**：

  - 批次效应较为明显且数据在实验设计中是 **成对的**（例如多次测量或不同的实验条件）。

------

## 3. **Seurat v4 的多模态整合 (`FindMultiModalNeighbors`)**

- **简介**：Seurat 提供了多模态数据整合的方法（例如 **RNA + ATAC** 或 **RNA + ADT**），可以通过 **WNN（加权最近邻）** 融合不同模态的数据，并在这个过程中去除批次效应。`FindMultiModalNeighbors` 会通过 **加权相似度** 减少不同模态之间的批次效应，同时保持每个模态在细胞分类上的表达差异。

- **使用方式**：

  ```R
  obj <- FindMultiModalNeighbors(
      object = obj,
      reduction.list = list("pca", "lsi"),  # RNA 使用 PCA，ATAC 使用 LSI
      dims.list = list(1:30, 2:30),           # 选定的维度数
      modality.weight.name = "RNA.weight",    # 设定权重名称
      verbose = TRUE
  )
  ```

- **优点**：

  - 无需在传统的 PCA/UMAP 上做批次效应校正。
  - 同时考虑多个模态，减少它们之间的批次效应。

- **适用场景**：

  - 多模态数据（如 RNA 和 ATAC、RNA 和 ADT）的整合，适用于跨批次、多模态的数据校正。

------

## 4. **MNN (Mutual Nearest Neighbors)**

- **简介**：MNN 是另一种批次校正方法，基于 **互近邻**（mutual nearest neighbors）进行批次校正。它通过对比批次间的最近邻，校正不同批次的样本，使其在低维空间中的表现更加一致。

- **使用方式**：

  ```R
  library(SingleCellExperiment)
  mnn_res <- MNNCorrect(obj, batch = obj$batch)  # 对象和批次信息
  obj$corrected_data <- mnn_res$corrected
  ```

- **优点**：

  - 能够处理不同批次数据之间的相对差异，保留生物学信号。
  - 可以应用于多个批次的整合。

- **适用场景**：

  - 当批次效应很大，尤其是多批次的情况下，适用于处理不同批次数据的整合。

------

## 5. **PCA + Batch Regressing (经典方法)**

- **简介**：经典的做法是通过 **回归（regress）** 在主成分（PCA）上去除批次信息。
   你可以在执行 PCA 前后，将批次信息作为回归变量，从数据中去除批次效应。

- **使用方式**：

  ```R
  obj <- ScaleData(obj, vars.to.regress = "batch")  # 在数据缩放时回归掉批次效应
  obj <- RunPCA(obj, features = VariableFeatures(obj))
  ```

- **优点**：

  - 非常简单，适合较小的批次效应。
  - 用于细胞类型之间没有太大差异的场景。

- **适用场景**：

  - 批次效应较小或已经知道批次信息，需要简单回归去除。

------

## 总结

排除批次效应的方法主要有：

1. **Harmony**（适合大规模数据和多批次整合，批次校正和聚类都做）
2. **ComBat**（基于贝叶斯模型，适用于批次差异较大的数据）
3. **Seurat 多模态整合**（适用于 RNA 和 ATAC/ADT 等模态整合）
4. **MNN**（适用于多批次数据的整合）
5. **PCA + 回归**（经典方法，适用于批次效应较小的情况）。

{% endcollapse %}

**非线性降维 (UMAP/tSNE)**：

- 用于可视化，把高维数据投射到 2D/3D。

{% alertpanel info  %}

对于单细胞RNA-seq而言，降维分析时先使用PCA提取变异的主成分这里有一些{% blur （可能是20？） %}，再对得到的降维数据进行UMPA聚类。

{% endalertpanel %}

------

## **邻居图构建与聚类**

- **FindNeighbors**：构建 kNN 图或 SNN 图。

{% collapse "What's KNN and SNN"  %}

**`KNN` ("k-Nearest neighbors graph")**

**定义**：

- 对每个细胞，找出在降维空间（如 PCA、LSI）里最接近的 k 个邻居。
- 用这些邻居建立边 → 得到一个 **KNN 图**。

**特点**：

- 边表示“几何上接近”；
- 但仅靠 KNN 容易受局部噪音影响。

在 Seurat 里：

- `FindNeighbors()` 默认先构建 **KNN 图**（存储在 `obj@neighbors`，一般名字是 `RNA_nn` 或 `ATAC_nn`）。

-----

**`SNN`（Shared Nearest Neighbors graph）**

**定义**：

- 在 KNN 图的基础上，看两个细胞的 **邻居集合重叠多少**。
- 重叠越大 → 相似度越高 → 边的权重越大。
- 用这个权重矩阵构建 **SNN 图**。

**特点**：

- 比单纯的 KNN 更鲁棒：即使两个细胞不是直接最近邻，但如果它们共享很多邻居，也会被连在一起。
- 常用于 **聚类**（比如 Seurat 的 Louvain/Leiden）。

- 在 Seurat 里：
  - `FindNeighbors(..., compute.SNN=TRUE)` 会生成 **SNN 图**（一般名字是 `RNA_snn` 或 `wsnn`）。

-----

> 一般情况下，先使用KNN对单细胞数据进行预处理，再使用SNN对KNN的数据进行聚类

{% endcollapse %}

- **FindClusters**：基于图的社区检测算法（Louvain/Leiden），得到细胞簇。
- **意义**：把表达相似的细胞归为一群。

------

## **细胞类型注释**

- **找 marker 基因 (FindAllMarkers)**：每个 cluster 的特异表达基因。
- **对照已知 marker**：推断 cluster 对应的细胞类型。
- **可选**：用参考数据库或自动化工具（SingleR, CellTypist）。

------

## **下游分析**

根据研究问题不同，可能包括：

- **差异表达分析 (FindMarkers)**：比较不同 cluster / 条件下的基因表达差异。
- **轨迹推断 (pseudotime)**：Monocle/Slingshot 分析发育或分化轨迹。
- **细胞通讯 (CellChat, CellPhoneDB)**：预测细胞间配体-受体相互作用。
- **基因调控网络 (SCENIC, pySCENIC)**：推断转录因子活性。
- **多组学整合 (WNN, MOFA+, Seurat v5)**：整合 RNA、ATAC、ADT 等。

------

## **可视化与验证**

- UMAP/tSNE 图上展示 cluster/marker 表达。
- 小提琴图、热图展示基因表达模式。
- 对关键结果做实验验证（qPCR, FISH, flow cytometry）。

-----

**单细胞分析思路** = 质控 → 归一化 → 特征选择 → 降维 → 构图聚类 → 注释 → 下游分析（差异、轨迹、通讯等）。

它的核心是**把高维 noisy 的单细胞数据，通过降维和聚类整理成有生物学意义的细胞群体，然后结合 marker/功能信息解读**

