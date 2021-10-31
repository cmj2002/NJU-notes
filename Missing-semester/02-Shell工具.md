# Shell 工具和脚本

## Shell 技巧

“上一条命令”包括脚本内的命令

| 输入      | 含义                                   | 备注                                                         |
| :-------- | :------------------------------------- | ------------------------------------------------------------ |
| `$_`      | 上一条命令的最后一个参数               | 如果你正在使用的是交互式shell，你可以通过按下 `Esc` 之后键入 `.`来获取这个值 |
| `$?`      | 上一条命令的返回值                     | 返回值不是在输出值（屏幕上的显示值）。此变量通常用于获得错误信息，0没有错误<br>`true`总返回0，`false`总返回1 |
| `!!`      | 完整的上一条命令                       |                                                              |
| `$@`      | 脚本的所有参数                         |                                                              |
| `$#`      | 脚本的参数个数                         |                                                              |
| `$$`      | 当前脚本的进程识别码                   |                                                              |
| `$0`      | 脚本名                                 |                                                              |
| `$1`~`$9` | 脚本的第1~9个参数值                    |                                                              |
| `${10}`   | 脚本的第10个参数值                     | 10以后以此类推                                               |
| `$*`      | 以一个单字符串显示所有向脚本传递的参数 |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |
|           |                                        |                                                              |

## 脚本语言

空格在脚本语言中非常重要。不要乱增删空格

### 变量

定义变量：`foo=bar`将值`bar`赋给`foo`

访问变量：`$foo`

字符串`"hello $foo"`等价于字符串`"hello bar"`

如果使用单引号可以不对`$foo`进行转义

```bash
[cmj@aubin new]$ foo=bar
[cmj@aubin new]$ echo "hello $foo"
hello bar
[cmj@aubin new]$ echo 'hello $foo'
hello $foo
```

可以把命令的输出赋给变量：

```bash
[cmj@aubin ~]$ foo=$(pwd)
[cmj@aubin ~]$ echo $foo
/home/cmj
```

也可以直接使用命令的输出：

```bash
[cmj@aubin ~]$ echo "we are in $(pwd)"
we are in /home/cmj
```



### 函数

`bash`支持函数，例如这样可以定义函数：

```bash
[cmj@aubin ~]$ mcd(){
> mkdir -p "$1"
> cd "$1"
> }
```

这个函数接受第一个参数并以它为名字创建一个文件夹，然后切换到这个文件夹

* `-p`使`mkdir`为所给出的目录建立丢失了的父目录。

如果写在文件中，函数应当写作

```bash
mcd () {
    mkdir -p "$1"
    cd "$1"
}
```

假设这个文件叫做`mcd.sh`，我们在Bash中输入`source mcd.sh`来导入它

* `source`指令在Bash中执行(execute)一个脚本并加载(load)它

shell函数和脚本有如下一些不同点：

- 函数只能用与shell使用相同的语言，脚本可以使用任意语言。因此在脚本中包含 `shebang` 是很重要的。
- 函数仅在定义时被加载，脚本会在每次被执行时加载。这让函数的加载比脚本略快一些，但每次修改函数定义，都要重新加载一次。
- 函数会在当前的shell环境中执行，脚本会在单独的进程中执行。因此，函数可以对环境变量进行更改，比如改变当前工作目录，脚本则不行。脚本需要使用 [`export`](httsp://man7.org/linux/man-pages/man1/export.1p.html) 将环境变量导出，并将值传递给环境变量。
- 与其他程序语言一样，函数可以提高代码模块性、代码复用性并创建清晰性的结构。shell脚本中往往也会包含它们自己的函数定义。

### 逻辑运算符

逻辑运算符与操作数间要加空格

与C++相同：`&&`，`||`（支持短路求值）

对于字符串，支持`==`，`!=`

对于整数，`==`，`<`，`>`，`!=`，`>=`，`<=`分别变为：`-eq`，`-lt`，`-ne`，`-ge`，`-le`

更多运算符见`man test`

方括号`[]`将把其中的东西作为`test`的参数进行逻辑运算。方括号两边均需要空格

通常建议使用双方括号`[[]]`，这样可以避免许多错误。两者的区别如下：

| **Feature**                                                  | **new test** `[[`                                       | **old test** `[`                                             | **Example**                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| string comparison                                            | `>`                                                     | `\>` [(*)](http://mywiki.wooledge.org/BashFAQ/031#np)        | `[[ a > b ]] || echo "a does not come after b"`              |
|                                                              | `<`                                                     | `\<` [(*)](http://mywiki.wooledge.org/BashFAQ/031#np)        | `[[ az < za ]] && echo "az comes before za"`                 |
|                                                              | `=` (or `==`)                                           | `=`                                                          | `[[ a = a ]] && echo "a equals a"`                           |
|                                                              | `!=`                                                    | `!=`                                                         | `[[ a != b ]] && echo "a is not equal to b"`                 |
| integer comparison                                           | `-gt`                                                   | `-gt`                                                        | `[[ 5 -gt 10 ]] || echo "5 is not bigger than 10"`           |
|| `-lt`                                                        | `-lt`                                                   | `[[ 8 -lt 9 ]] && echo "8 is less than 9"`                   |                                                              
|| `-ge`                                                        | `-ge`                                                   | `[[ 3 -ge 3 ]] && echo "3 is greater than or equal to 3"`    |                                                              
|| `-le`                                                        | `-le`                                                   | `[[ 3 -le 8 ]] && echo "3 is less than or equal to 8"`       |                                                              
|| `-eq`                                                        | `-eq`                                                   | `[[ 5 -eq 05 ]] && echo "5 equals 05"`                       |                                                              
|| `-ne`                                                        | `-ne`                                                   | `[[ 6 -ne 20 ]] && echo "6 is not equal to 20"`              |                                                              
| conditional evaluation                                       | `&&`                                                    | `-a` [(**)](http://mywiki.wooledge.org/BashFAQ/031#np2)      | `[[ -n $var && -f $var ]] && echo "$var is a file"`          |
|| `||`                                                         | `-o` [(**)](http://mywiki.wooledge.org/BashFAQ/031#np2) | `[[ -b $var || -c $var ]] && echo "$var is a device"`        |                                                              
| expression grouping                                          | `(...)`                                                 | `\( ... \)` [(**)](http://mywiki.wooledge.org/BashFAQ/031#np2) | `[[ $var = img* && ($var = *.png || $var = *.jpg) ]] &&` `echo "$var starts with img and ends with .jpg or .png"` |
| Pattern matching                                             | `=` (or `==`)                                           | (not available)                                              | `[[ $name = a* ]] || echo "name does not start with an 'a': $name"` |
| [RegularExpression](http://mywiki.wooledge.org/RegularExpression) matching | `=~`                                                    | (not available)                                              | `[[ $(date) =~ ^Fri\ ...\ 13 ]] && echo "It's Friday the 13th!"` |

(*) This is an extension to the POSIX standard; some shells may have it, others may not.

(**) The `-a` and `-o` operators, and `( ... )` grouping, are defined by POSIX but only for strictly limited cases, and are marked as deprecated. Use of these operators is discouraged; you should use multiple `[` commands instead:

更多关于各种括号与逻辑运算符的信息，见http://mywiki.wooledge.org/BashFAQ/031

### 通配 (globbing)

#### 通配符

分别使用`?`和`*`来匹配一个或任意多个字符

* 例如，对于文件`foo`, `foo1`, `foo2`, `foo10` 和 `bar`, `rm foo?`这条命令会删除`foo1` 和 `foo2` ，而`rm foo*` 则会删除除了`bar`之外的所有文件。

#### 花括号

花括号`{}` - 当你有一系列的指令，其中包含一段公共子串时，可以用花括号来自动展开这些命令。这在批量移动或转换文件时非常方便

例如`image.{png,jpg}`会被展开为`image.png image.jpg`

一句中包含多个花括号将作笛卡尔积

花括号甚至可以规定范围，如`foo/{a..d}`将拓展为`foo/a foo/b foo/c foo/d`

```bash
convert image.{png,jpg}
# 会展开为
convert image.png image.jpg

cp /path/to/project/{foo,bar,baz}.sh /newpath
# 会展开为
cp /path/to/project/foo.sh /path/to/project/bar.sh /path/to/project/baz.sh /newpath

# 也可以结合通配使用
mv *{.py,.sh} folder
# 会移动所有 *.py 和 *.sh 文件

mkdir foo bar

# 下面命令会创建foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h这些文件
touch {foo,bar}/{a..h}
touch foo/x bar/y
# 比较文件夹 foo 和 bar 中包含文件的不同
diff <(ls foo) <(ls bar)
# 输出
# < x
# ---
# > y
```

最后一个的实际运行输出了：

```
9c9
< x
---
> y
```

* `9c9`表示第一个文件的第九行与第二个文件的第九行发生**内容改变**（`c`，change）
* 其他的模式还有`a`（增加，addition），`d`（删除，deletion）
* `d`表示第二个文件比第一个少了参数
* 若出现形如`3,4c3,5`表示文件一的三到四行与文件二的三到五行发生改变

### 用其他语言编写脚本文件

在一个脚本的第一行写入`#!`和一个路径，Shell将调用这个路径中的程序来执行这个脚本

下面列出了一些典型的 shebang 解释器指令：

- `#!/bin/sh`—使用`sh`，即[Bourne shell](https://zh.wikipedia.org/wiki/Bourne_shell)或其它兼容shell执行脚本
- `#!/bin/csh`—使用`csh`，即[C shell](https://zh.wikipedia.org/wiki/C_shell)执行
- `#!/usr/bin/perl -w`—使用带警告的[Perl](https://zh.wikipedia.org/wiki/Perl)执行
- `#!/usr/bin/python -O`—使用具有代码优化的[Python](https://zh.wikipedia.org/wiki/Python)执行
- `#!/usr/bin/php`—使用[PHP](https://zh.wikipedia.org/wiki/PHP)的命令行解释器执行

在某些电脑上，相应的程序可能没有安装在上面的位置。可以使用`env`命令来调用环境变量中的程序来执行脚本

* 例如`#!/usr/bin/env python`调用python执行脚本

## 实用工具

这里大多数工具都需要安装

### Shellcheck

使用shellcheck以定位脚本中的错误（https://github.com/koalaman/shellcheck）

使用方法：`shellcheck script.sh`

安装：`sudo apt-get install shellcheck`，注意大写

### tldr

一种基于例子，比`man`要简单的查询命令方法

使用方法：`tldr convert`以查询`convert`命令的用法

可以查询未安装的命令

可能是基于网络的（没试过）

### find

几乎所有shell都将其作为内置指令，通常无需安装

`find`命令会递归地搜索符合条件的文件

示例：

```bash
# 查找所有名称为src的文件夹
find . -name src -type d
# 查找所有文件夹路径中包含test的python文件
find . -path '*/test/*.py' -type f
# 查找前一天修改的所有文件
find . -mtime -1
# 查找所有大小在500k至10M的tar.gz文件
find . -size +500k -size -10M -name '*.tar.gz'
```

除了列出所寻找的文件之外，find还能对所有查找到的文件进行操作。这能极大地简化一些单调的任务。

```bash
# 删除全部扩展名为.tmp 的文件
find . -name '*.tmp' -exec rm {} \;
# 查找全部的 PNG 文件并将其转换为 JPG
find . -name '*.png' -exec convert {} {}.jpg \;
```

#### 替代品

`fd`是一个更加用户友好的`find`替代品，他需要自行下载

如果希望获得更快的速度，可以依靠 [`locate`](https://man7.org/linux/man-pages/man1/locate.1.html) 。 `locate` 是一个内置指令，使用一个由 [`updatedb`](https://man7.org/linux/man-pages/man1/updatedb.1.html)负责更新的数据库，在大多数系统中 `updatedb` 都会通过 [`cron`](https://man7.org/linux/man-pages/man8/cron.8.html)每日更新。这便需要我们在速度和时效性之间作出权衡。而且，`find` 和类似的工具可以通过别的属性比如文件大小、修改时间或是权限来查找文件，`locate`则只能通过文件名。 [here](https://unix.stackexchange.com/questions/60205/locate-vs-find-usage-pros-and-cons-of-each-other)有一个更详细的对比。

### grep

`grep` 有很多选项，这也使它成为一个非常全能的工具。其中经常使用的有

* `-C` ：获取查找结果的上下文（Context）；
* `-v` 将对结果进行反选（Invert），也就是输出不匹配的结果。举例来说， `grep -C 5` 会输出匹配结果前后五行。
* 当需要搜索大量文件的时候，使用 `-R` 会递归地进入子目录并搜索所有的文本文件。

我们有很多办法可以对 `grep -R` 进行改进，例如使其忽略`.git` 文件夹，使用多CPU等等。

因此也出现了很多它的替代品，包括 [ack](https://beyondgrep.com/), [ag](https://github.com/ggreer/the_silver_searcher) 和 [rg](https://github.com/BurntSushi/ripgrep)。它们都特别好用，但是功能也都差不多，我比较常用的是 ripgrep (`rg`) ，因为它速度快，而且用法非常符合直觉。例子如下：

```
# 查找所有使用了 requests 库的文件
rg -t py 'import requests'
# 查找所有没有写 shebang 的文件（包含隐藏文件）
rg -u --files-without-match "^#!"
# 查找所有的foo字符串，并打印其之后的5行
rg foo -A 5
# 打印匹配的统计信息（匹配的行和文件的数量）。PATTERN为搜索的字符串和其他命令
rg --stats PATTERN
```

与 `find`/`fd` 一样，重要的是你要知道有些问题使用合适的工具就会迎刃而解，而具体选择哪个工具则不是那么重要。

#### 利用grep搜索历史命令

`history` 命令允许您以程序员的方式来访问shell中输入的历史命令。这个命令会在标准输出中打印shell中的里面命令。如果我们要搜索历史记录，则可以利用管道将输出结果传递给 `grep` 进行模式搜索。 `history | grep find` 会打印包含find子串的命令。

对于大多数的shell来说，您可以使用 `Ctrl+R` 对命令历史记录进行回溯搜索。敲 `Ctrl+R` 后您可以输入子串来进行匹配，查找历史命令行。

反复按下就会在所有搜索结果中循环。在 [zsh](https://github.com/zsh-users/zsh-history-substring-search)中，使用方向键上或下也可以完成这项工作。

`Ctrl+R` 可以配合 [fzf](https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#ctrl-r) 使用。`fzf` 是一个通用对模糊查找工具，它可以和很多命令一起使用。这里我们可以对历史命令进行模糊查找并将结果以赏心悦目的格式输出。



## 杂项

1. 如果要在一行中写下多个指令，用`;`分隔

2. `> /dev/null` 以丢弃输出

3. `echo -n something` 在输出 `something` 后不换行。可以配合 `\r` 使用以实现在同一行更新输出

4. 将一个命令输入的多行结果作为另一个命令的输入应当使用 `xargs`

   * `find /sbin -perm +700 |ls -l` 是错误的
   * `find /sbin -perm +700 |xargs ls -l` 才是正确的
5. 

