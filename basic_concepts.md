# Verilog HDL 数字设计与综合
下面是关于Verilog的好多好多细节. __May it be helpful!__

# Chapter3
## 词法规定
- Verilog是大小写相关的，关键词全部为小写
- 空白符(`\b \t 换行符`)仅用于分割标识符，在编译阶段被忽略
- 单行注释`//` 多行注释`/* */` (多行注释不允许嵌套)
- 操作符包含单目、双目和三目
- `<size>'<base_format><number>`数字声明如果不指出基数，则为10
- x表示不确定，z表示高阻
- 在位宽前加入`-`号表示负数
- 下划线只是提高可读性，在编译阶段会被忽略掉
- 问号表示高阻，不care。`4'b10??`相当于`4'b10zz`
- 字符串不能多行。将字符串当作单字节的ASCII字符列表
- 标识符由字母，数字，下划线和$，第一个字符必须是字母或下划线

## 数值类型
- 0, 1, x, z
- 线网`wire`和寄存器`reg`
- 线网的默认值是z, 但trireg除外，为x(与reg类型相同)
- net不是一个关键词，包含`wire`,`wand`,`wor`,`tri`,`triand`,`trireg`等
- 寄存器不需要驱动源，也不需要时钟信号，在仿真的任何阶段可直接赋值
- 寄存器也可signed
- 驱动由强到弱supply, strong, pull, large, weak, medium, small, highz
- 向量[#high:#low]与[#low,#high]以及[<starting_bit>+:width]从起始位开始，位宽为width
- integer, real, time. 注意智能仿真，而integer，real是一种通用寄存器数据类型
- integer是有符号数. reg是补码保存，取出来无符号，而integer一直有符号
- time最小64位 $time可得当前时间
- 注意数组的声明（在后边），与向量不同
- 存储器是reg的数组
- parameter与localparameter #(.N(\_))重载
- 字符串保存在reg变量里面,如果位数不够则左面去掉

## 系统任务与编译指令
- $<keyword>表示系统指令
- %d, %b, %B, %m(显示层次名), %v(显示强度), %e(科学计数), %T(时间)
- $monitor $display $stop(暂停结束仿真)
- \`include和\`define
- `\`include header.v`

# Chapter4
## 模块
- module, 模块名，端口声明，可选参数声明，endmodule
- 模块内部五部分，变量声明、数据流语句、底层模块实例、行为语句块和任务函数

## 端口
- input, output, inout
- reg, wire可以连input, 输出端口只能wire连接，input必须永远wire
- 允许不同位宽（模块调用），允许未连接（空开就行）
- 顺序连接，或者端口名连接（.b(B)）

## 层次命名
- 整个设计层次，每个标识符具有唯一的位置
- $display %m

# Chapter5
## 门的类型
- 与/或门类（多输入，单输出）和缓冲器/非门类（单输入，多输出）
- 注意and, or, nand, nor, xor, xnor的逻辑符号以及运算结果
- __注意x,z的情况__
- bufif1, bufif0, notif1, notif0
- 注意如果很多个一维tmp变量，可以用数组完成
- 门原语不能写到过程块里
- 支持内部原语实例数组和用户自定义模块

## 门延迟
- 允许通过门延迟来说明逻辑电路的延迟
- 默认无延迟
- 上升延迟(0,x,z->1)，下降延迟(1,x,z->0)，关断延迟（0,1,x->z）
- `and #(rise_val, fall_val, turnoff_val) b1 (out, in, ctrl)`
- 如果用户指定了一个，那么所有的延迟都按这个，如果两个，则为上升和下降，关断为二者小者，如果三个，则依次是上升，下降，关断
- 用户还可以对于每种类型的延迟指定最小值，最大值，典型值
- 具体的控制方法与仿真器和操作系统有关
- `and #(2:3:4, 3:4:5, 4:5:6) a3(out, i1, i2)`
- 上例子，若最小延迟，则上升、下降和关断分别为2,3,4,若经典则都取第三个值
- `verilog test.v +maxdelays(+mindelays/+typdelays)`

# Chapter6
## 连续赋值语句
