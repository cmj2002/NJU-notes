# 7 基于知识的Agent

使用 Knowledge Base (一个命题集)进行推理

简单版本：

<img src="7 基于知识的Agent.assets/image-20211108101841795.png" alt="image-20211108101841795" style="zoom:67%;" />

对知识的表示越简单（简短），进行推理时越复杂

## 命题逻辑Agent

大量使用数理逻辑知识，这里不详细写

### 基于枚举的

<img src="7 基于知识的Agent.assets/image-20211108102725651.png" alt="image-20211108102725651" style="zoom:67%;" />

### 基于Horn子句的（前向）推理

从KB出发，推理所有的结果，查看需要证明的是否在其中

<img src="7 基于知识的Agent.assets/image-20211108102931602.png" alt="image-20211108102931602" style="zoom:67%;" />

### 后向推理

从结果出发，推理需要的条件，查看KB是否满足

### 合取范式

需要进行消解（resolution）

<img src="7 基于知识的Agent.assets/image-20211108104513823.png" alt="image-20211108104513823" style="zoom:67%;" />

<img src="7 基于知识的Agent.assets/image-20211108103421004.png" alt="image-20211108103421004" style="zoom:67%;" />

<img src="7 基于知识的Agent.assets/image-20211108103833052.png" alt="image-20211108103833052" style="zoom:67%;" />

## 基于

### 命题逻辑的缺陷

命题逻辑的表达能力不足，要用很啰嗦的办法描述环境

只能描述具体的事实，不能描述普遍规则

<img src="7 基于知识的Agent.assets/image-20211108110007718.png" alt="image-20211108110007718" style="zoom: 67%;" />

依次为命题逻辑、一阶逻辑、时序逻辑、概率论、模糊逻辑

