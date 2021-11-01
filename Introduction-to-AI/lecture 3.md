# 有先验的搜索

<img src="lecture 3.assets/image-20210913224645991.png" alt="image-20210913224645991" align="left" style="zoom:80%;" />

启发函数heuristic function估算当前离目标还有多远

比如在地图上直接求直线距离，作为实际距离的估计

有先验时我们一般使用**最佳优先搜索**（best-first search）

## 最佳优先搜索

$h(n)$ 为启发函数，参数是一个节点，输出到达目标的最小代价路径的最小代价估计

评估函数由启发函数和其他东西共同构成

评估函数最小的节点先进行搜索

下面介绍两种最佳优先搜索。

## 贪婪搜索

是一种思想而非算法

最大化地搜索，比如每次展开与目标最近的节点

* 完全性：如果不对重复作检测，可能进入死循环
* 时间：$O(b^m)$，但一个好的启发函数可以给出极大的改善(dramatic improvement)
* 空间：$O(b^m)$，需要保存所有节点
* 最优化：否

## A*算法

解决了greedy算法不能最优化的问题

评价函数： $f(n)=g(n)+h(n)$ 

* $g(n)$：达到当前位置 $n$ 消耗的cost
* $h(n)$：预计从当前位置到终点的cost
* $f(n)$：预计的总cost

A*算法使用admissible heuristic（可采纳启发式）

* 指实际的cost必须大于等于预计的cost，不能高估
  * 例如平面上用直线估计距离，这样预计的cost永远不会高估
* 保证这一点时，A*算法是最优化的。

证明（$h^*$为实际cost，$h$ 为估计的cost）

<img src="lecture 3.assets/image-20210929171501283.png" align="left" alt="image-20210929171501283" style="zoom:50%;" />

<img src="lecture 3.assets/image-20210929172222532.png" align="left" alt="image-20210929172222532" style="zoom:80%;" />

### 例题

<img src="lecture 3.assets/image-20210929172634031.png" align="left" alt="image-20210929172634031" style="zoom:80%;" />

<img src="lecture 3.assets/image-20210929174851141.png" align="left" alt="image-20210929174851141" style="zoom:80%;" />

