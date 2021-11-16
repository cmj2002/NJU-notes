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

  * 改进：选择短的集合接到长的集合末尾，这需要额外维护保存集合大小的变量（代价不大）。不会降低渐进时间复杂度，但是可能降低某些调用它的函数的时间复杂度，比如：

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

