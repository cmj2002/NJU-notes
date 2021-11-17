# 10 Disjoint Set（不相交集，并查集）

## Disjoint-set ADT

一个不相交集维护一组集合，这些集合是不相交且动态的

$\mathcal{S}=\{S_1,S_2,\cdots,S_k\}$

每一个 $S_i$ 具有一个“代表性”（representative）成员（leader）

不相交集支持以下操作：

* `MakeSet(x)` ，创建一个只包含 `x` 的集合并将该集合加入 $\mathcal{S}$
* `Union(x,y)` 找到包含 `x` ，`y` 的集合 $S_x,S_y$，从 $\mathcal{S}$ 中删除，并将 $S_x\cup S_y$ 加入 $\mathcal{S}$
* `Find(x)` 找到包含 `x` 的集合，返回其leader的指针

不支持删除或分割集合的操作

也称为**UnionFind ADT**（并查集）

应用：

<img src="10 Disjoint Set.assets/image-20211116163627294.png" alt="image-20211116163627294" style="zoom:70%;" />

## 用链表实现

![image-20211116163705895](10 Disjoint Set.assets/image-20211116163705895.png)

### 时间复杂度

* `MakeSet(x)` ，创建一个新链表，$\Theta(1)$

* `Find(x)` ，通过 `x` 的指针得到集合，再取第一个元素即可，$\Theta(1)$

*  `Union(x,y)`，将 $S_y$ 的链表加到 $S_x$ 末尾，释放 $S_y$，更改 $S_y$ 中元素（指向集合）的指针。$\Theta(sizeof(S_y))$

  * 最坏情况下为 $\Theta(n)$，$n$ 为 $\mathcal{S}$ 的总元素个数，即使均摊分析也并不降低。

  * 改进：选择短的集合接到长的集合末尾（union-by-size），这需要额外维护保存集合大小的变量（代价不大）。不会降低最坏情况渐进时间复杂度，但是降低平均到 $O(\lg n)$ ，而且可能大幅降低某些调用它的函数的时间复杂度，比如：

    ```pseudocode
    MakeSet(x0)
    for (i=1 to n)
    	MakeSet(xi)
    	Union(xi,x0)
    ```

    $\Theta(n^2)\to \Theta(n)$

![image-20211116164356338](10 Disjoint Set.assets/image-20211116164356338.png)

改进之后，对于任意`MakeSet`，`Find`，`Union` 组成的序列：

![image-20211116165819004](10 Disjoint Set.assets/image-20211116165819004.png)

## 用有根树实现

使用有根树来表现一个集合，树根是集合的leader

每一个节点有一个指向它父亲的指针，根节点的父亲是它自己

![image-20211116170129279](10 Disjoint Set.assets/image-20211116170129279.png)

### 时间复杂度

* `MakeSet(x)` ，创建一个新树，$\Theta(1)$
* `Find(x)` ，从根开始找，$\Theta(h)$
* `Union(x)`，先查找，再将 `x` 的树的根节点指向 `y` 的树的根节点，$\Theta(h)$

### Union by height

额外维护树的高度

在 `Union` 时总是将高度更小的插入更大的

减少了 `Find` 的时间复杂度

通过归纳法不难证明此时 `Find` 和 `Union` 的最坏时间复杂度为 $O(\log n)$

### Union by rank

#### Path-Compression in find

在 `Find` 时将遍历到的所有节点的父指针直接指向根节点

不会提高 `Find` 的渐进时间复杂度，但是降低了未来的 `Find` 的时间复杂度

问题：此时难以维护树的高度了

解决：维护一个rank，定义为“不考虑Path-Compression的树高”，也就是忽略 `Find` 对树高的影响

#### 时间复杂度

* `MakeSet`：$\Theta(1)$
* `Find` 和 `Union` ：几乎 $O(1)$

实际上是 $O(\alpha(n))=o(\log^* n)$

如果将已知宇宙的原子数作为 $n$，$\alpha(n)\leq3,\log^*n\leq 6$

#### 时间复杂度的证明

下面证明它的三种操作的序列具有很低的平均时间复杂度

可以将 `MakeSet` 移动到开头，不影响时间复杂度

所以需要证明的是，对于有 $n$ 个节点的森林，`Find` 和 `Union` 的序列具有很低的平均时间复杂度

Cost[`Union(x,y)`] = Cost[`Find(x)`] + Cost[`Find(y)`] + $O(1)$

