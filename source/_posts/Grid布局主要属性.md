---
title: Grid 布局主要属性
date: 2019-04-11 21:52:17
categories:
- 前端技术
tags:
- Grid
---

> 摘要：记录 Grid 布局主要属性以及使用案例。

<!-- more -->

## 一、容器属性
### display: grid
指定一个容器采用网格布局。

### display: inline-grid
指定容器是一个行内元素，该元素内部采用网格布局。

**附加内容：设置容器居中显示。**
body 标签使用 `"text-align: center"` 属性，容器要使用 `display: inline-grid;` 属性，如下：
```
<body style="text-align: center">

<div style="display: inline-grid;grid-row-gap: 20px;">
        <div style="width: 100px;height: 100px;border: 1px solid rgb(204, 224, 255);">

        </div>
        <div class="container">
            <div class="item">菜单1</div>
            <div class="item">菜单2</div>
            <div class="item">菜单3</div>
        </div>
    </div>
</body>
```

**注意：设为网格布局（grid 或 inline-grid）以后，容器子元素的 float、`display: inline-block`、`display: table-cell`、`vertical-align` 和 `column-* ` 等设置都将失效。**

### grid-template-columns、grid-template-rows
定义每一列的列宽和行高，可以使用绝对单位，也可以使用百分比：

### repeat() 函数
1、简化重复的值
例如：`grid-template-columns: 33.33% 33.33% 33.33%` 可以简化为 `grid-template-columns: repeat(3, 33.33%)`
2、重复某种模式：`grid-template-columns: repeat(2, 100px 20px 80px)`，该样式定义了 6 列，第一列和第四列的宽度为 100px，第二列和第五列为 20px，第三列和第六列为 80px。

### auto-fill 关键字
表示自动填充，让每一行（或每一列）容纳尽可能多的单元格。
例子：`grid-template-columns: repeat(auto-fill, 100px)`，表示每列宽度 100px，然后自动填充，直到容器不能放置更多的列。

### fr 关键字
表示比例关系，可以与绝对长度的单位结合使用。
例子：`grid-template-columns: 150px 1fr 2fr`，第一列的宽度为 150px，第二列的宽度是第三列的一半。

### auto 关键字
表示由浏览器自己决定长度。
例子：`grid-template-columns: 100px auto 100px`，第二列的宽度，基本上等于该列单元格的最大宽度，除非单元格内容设置了min-width，且这个值大于最大宽度。

### 指定网格线的名称
```
.container {
  display: grid;
  grid-template-columns: [c1] 100px [c2] 100px [c3] auto [c4];
  grid-template-rows: [r1] 100px [r2] 100px [r3] auto [r4];
}
```
同一根线可以有多个名字，比如 `[fifth-line row-5]`

### row-gap、column-gap
设置行间距和列间距

### gap
是 column-gap 和 row-gap 的合并简写形式，即 `gap: <row-gap> <column-gap>`，若省略了第二个值，浏览器认为第二个值等于第一个值。

### grid-template-areas
网格布局允许指定区域，一个区域由单个或多个单元格组成。
例子：

### grid-auto-flow
元素的放置顺序，默认值是 row，即「先行后列」。也可以将它设成 column，变成「先列后行」。还可以设成row dense和column dense。这两个值主要用于，某些子元素指定位置以后，剩下的子元素怎么自动放置，尽可能紧密填满，尽量不出现空格。

### justify-items、align-items
设置单元格内容的水平和垂直对齐方式。这两个属性的写法完全相同，都可以取下面这些值：
- start：对齐单元格的起始边缘。
- end：对齐单元格的结束边缘。
- center：单元格内部居中。
- stretch：拉伸，占满单元格的整个宽度（默认值）。
注意：如果元素本身的 height 或 width 属性被固定为具体值，则 stretch 无效，改为 auto 则有效。。

### place-items
是 align-items 属性和 justify-items 属性的合并简写形式。`place-items: <align-items> <justify-items>`，如果省略第二个值，则浏览器认为与第一个值相等。

### justify-content、align-content
整个内容区域在容器里面的水平和垂直位置，这两个属性的写法完全相同，都可以取下面这些值。（下面的图都以justify-content属性为例，align-content属性的图完全一样，只是将水平方向改成垂直方向。）
- start - 对齐容器的起始边框。
- end - 对齐容器的结束边框。
- center - 容器内部居中。
- stretch - 子元素大小没有指定时，拉伸占据整个网格容器。
- space-around - 每个子元素两侧的间隔相等。所以，子元素之间的间隔比子元素与容器边框的间隔大一倍。
- space-between - 子元素与子元素的间隔相等，子元素与容器边框之间没有间隔。
- space-evenly - 子元素与子元素的间隔相等，子元素与容器边框之间也是同样长度的间隔。

### place-content
align-content 属性和 justify-content 属性的合并简写形式。格式：`place-content: <align-content> <justify-content>` 如果省略第二个值，浏览器就会假定第二个值等于第一个值。

### grid-auto-columns、grid-auto-rows
```
.container {
  display: grid;
  grid-template-columns: 100px 100px 100px;
  grid-template-rows: 100px 100px 100px;
  grid-auto-rows: 50px;
}
```
在上述划分好的网格 3 行 x 3 列，但是，8 号子元素指定在网格外第 4 行，9 号子元素指定在第 5 行。
```
.item-8 {
  background-color: #d0e4a9;
  grid-row-start: 4;
  grid-column-start: 2;
}

.item-9 {
  background-color: #4dc7ec;
  grid-row-start: 5;
  grid-column-start: 3;
}
```
因此，指定网格外的行高统一为 50px（原始的行高未设定，则为 100px）。

### grid-template
grid-template-columns、grid-template-rows 和 grid-template-areas 这三个属性的合并简写形式。

### grid
grid-template-rows、grid-template-columns、grid-template-areas、 grid-auto-rows、grid-auto-columns、grid-auto-flow 这六个属性的合并简写形式。

## 子元素属性
### grid-column-start、grid-column-end、grid-row-start、grid-row-end
子元素的位置是可以指定的，具体方法就是指定子元素的四个边框，分别定位在哪根网格线。
- grid-column-start 属性：左边框所在的垂直网格线
- grid-column-end 属性：右边框所在的垂直网格线
- grid-row-start 属性：上边框所在的水平网格线
- grid-row-end 属性：下边框所在的水平网格线
例子，指定 1 号子元素的左边框是第二根垂直网格线，右边框是第四根垂直网格线：
```
.item-1 {
  grid-column-start: 2;
  grid-column-end: 4;
}
```
指定了子元素的左右边框，没有指定上下边框，所以会采用默认位置，即上边框是第一根水平网格线，下边框是第二根水平网格线。

除了1号子元素以外，其他子元素都没有指定位置，由浏览器自动布局，这时它们的位置由容器的 grid-auto-flow 属性决定，这个属性的默认值是 row，因此会「先行后列」进行排列。

这四个属性的值，除了指定为第几个网格线，还可以指定为网格线的名字。
```
.item-1 {
  grid-column-start: header-start;
  grid-column-end: header-end;
}
```
上面代码中，左边框和右边框的位置，都指定为网格线的名字。

这四个属性的值还可以使用 span 关键字，表示「跨越」，即左右边框（上下边框）之间跨越多少个网格。
```
.item-1 {
  grid-column-start: span 2;
}
```
表示，1 号子元素的左边框距离右边框跨越 2 个网格。也可以如下表示：
```
.item-1 {
  grid-column-end: span 2;
}
```
使用这四个属性，如果产生了子元素的重叠，则使用z-index属性指定子元素的重叠顺序。


### grid-column、grid-row
grid-column 属性是 grid-column-start 和 grid-column-end 的合并简写形式；grid-row 属性是 grid-row-start 属性和 grid-row-end 的合并简写形式。
例子：
```
.item-1 {
  grid-column: 1 / 3;
  grid-row: 1 / 2;
}
/* 等同于 */
.item-1 {
  grid-column-start: 1;
  grid-column-end: 3;
  grid-row-start: 1;
  grid-row-end: 2;
}
```
上面代码中，子元素 item-1 占据第一行，从第一根列线到第三根列线。

这两个属性之中，也可以使用span关键字，表示跨越多少个网格。
```
.item-1 {
  background: #b03532;
  grid-column: 1 / 3;
  grid-row: 1 / 3;
}

/* 等同于 */
.item-1 {
  background: #b03532;
  grid-column: 1 / span 2;
  grid-row: 1 / span 2;
}
```
斜杠以及后面的部分可以省略，默认跨越一个网格。如下：
```
.item-1 {
  grid-column: 1;
  grid-row: 1;
}
```

### grid-area
指定子元素放在哪一个区域。
```
.item-1 {
  grid-area: e;
}
```
grid-area 属性还可用作 grid-row-start、grid-column-start、grid-row-end、grid-column-end 的合并简写形式，直接指定子元素的位置。
```
.item {
  grid-area: <row-start> / <column-start> / <row-end> / <column-end>;
}
```

### justify-self、align-self、place-self
justify-self 属性设置单元格内容的水平位置（左中右），跟 justify-items 属性的用法完全一致，但只作用于单个子元素；align-self 属性设置单元格内容的垂直位置（上中下），跟 align-items 属性的用法完全一致，也是只作用于单个子元素。
```
.item {
  justify-self: start | end | center | stretch;
  align-self: start | end | center | stretch;
}
```
这两个属性都可以取下面四个值。
- start：对齐单元格的起始边缘。
- end：对齐单元格的结束边缘。
- center：单元格内部居中。
- stretch：拉伸，占满单元格的整个宽度（默认值）。

### place-self
align-self 属性和 justify-self 属性的合并简写形式。格式：`place-self: <align-self> <justify-self>`，如果省略第二个值，place-self 属性会认为这两个值相等。

## 参考文献
1、http://www.ruanyifeng.com/blog/2019/03/grid-layout-tutorial.html
