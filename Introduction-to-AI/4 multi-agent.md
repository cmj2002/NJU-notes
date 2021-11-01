# multi-agent

有多种情况：

* agent的数量
* 零和还是可合作？
* 随机性还是确定性？（比如飞行棋有随机性）
* 完全知道局势吗？（比如看不到别人的手牌）

通常不考虑optimal，因为对手选择未知

## MiniMax

假设对手每次都作出对自己最不利的决定

<img src="4 multi-agent.assets/image-20210927113753255.png" align="left" alt="image-20210927113753255" style="zoom:67%;" />

<img src="4 multi-agent.assets/image-20211011101507654.png" align="left" alt="image-20211011101507654" style="zoom:50%;" />

<img src="4 multi-agent.assets/image-20211011101747664.png" align="left" alt="image-20211011101747664" style="zoom:50%;" />

### alpha-beta剪枝

有了这项技术，minimax才是一个可用的算法

除了更省时间和空间，其他性质和minimax没有任何区别，返回的结果一模一样。

<img src="4 multi-agent.assets/image-20211011111439195.png" align="left" alt="image-20211011111439195" style="zoom:35%;" />

<img src="4 multi-agent.assets/image-20211011111602899.png" align="left" alt="image-20211011111602899" style="zoom:35%;" />

<img src="4 multi-agent.assets/image-20211011111749911.png" align="left" alt="image-20211011111749911" style="zoom:35%;" />

<img src="4 multi-agent.assets/image-20211011111031887.png" align="left" alt="image-20211011111031887" style="zoom:50%;" />

### 考虑随机性

在这种情况下很难进行剪枝

通常用强化学习进行剪枝

<img src="4 multi-agent.assets/image-20211011113448983.png" align="left" alt="image-20211011113448983" style="zoom:75%;" />

## MCTS

### 随机数

计算机中没有真随机数，随机数都是算出来的

<img src="4 multi-agent.assets/image-20211018102004199.png" align="left" alt="image-20211018102004199" style="zoom:50%;" />

### 老虎机模型（bandit）

<img src="4 multi-agent.assets/image-20211018102917154.png" align="left" alt="image-20211018102917154" style="zoom:67%;" />

每条摇臂都有一定的期望返还（reward），但期望和分布未知。
