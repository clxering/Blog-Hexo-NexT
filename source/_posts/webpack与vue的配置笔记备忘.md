---
title: webpack+vue 的配置笔记备忘（continue...）
date: 2019-03-23 12:33:00
categories:
- 前端技术
tags:
- webpack
- vue
---

> 摘要：本文记录了 webpack 以及配合 vue 的相关配置等内容。

<!-- more -->

## 一、webpack 的配置和初步使用
npm 版本：5.6.0
webpack 版本：4.15.1

### 1 安装方式
webpack 依赖于 node.js，需要先进行 node.js 的安装。可参考建立以下目录结构：

```
.
├── dist（存放产品输出）
├── src（存放 css、js、html 文件）
├── node_modules
├── package.json（应用程序的信息）
├── package-lock.json
```

#### 1.1 全局安装 webpack
运行命令 `npm install webpack -g`，这样就能在全局使用 webpack 的命令，在项目中即使安装了本地 webpack，也无法识别命令。

#### 1.2 本地安装 webpack
在项目根目录中运行 `npm i webpack --save-dev` 安装到项目开发环境依赖中。经试验，本地 webpack 4.14 只能写入 dependencies 中（生产环境依赖）

**注意：在 webpack 3.x 及之前版本，CLI 已经整合，但是 4.x 版本将两者分开，需要另外安装，否则会提示 Cannot find module 'webpack-cli/bin/config-yargs'，输入查看版本号命令 npm -v 时，也会提示安装。执行 npm install webpack-cli –g 全局安装即可。**

**附加内容：查看/修改 npm 默认的全局安装目录**
- 查看：使用命令 `npm config ls`，查看 prefix 值可知当前默认的全局安装目录。
- 修改：使用命令 `npm config set prefix "D:\npm_global_modules"`

**附加内容：使用淘宝镜像**
使用命令 `npm install cnpm -g --registry=https://registry.npm.taobao.org`

**附加内容：什么时候用本地或全局安装**
- 当试图安装命令行工具的时候，例如 grunt CLI 的时候，使用全局安装。全局安装的方式：`npm install <name> -g`
- 当试图通过 npm 安装某个模块，并通过 `require('xx')` 的方式引入的时候，使用本地安装。本地安装的方式：`npm install <name>`

**附加内容：npm –save 和 npm --save-dev 的区别**
- `npm install <name>` 安装好后，写入 `package.json` 的 `dependencies` 中（生产环境依赖）
- `npm install <name> --save` 安装好后写入 `package.json` 的 `dependencies` 中（生产环境依赖）。在 npm 5 之后的版本可以用 `npm install <name> --save-prod`，同样的效果。
- `npm install <name> --save-dev` 安装好后写入 `package.json` 的 `devDepencies` 中（开发环境依赖），如果在 `dependencies` 存在，则移动到 `devDepencies`。
- `dependencies` 是运行时依赖，`devDependencies` 是开发时的依赖。`devDependencies` 下列出的模块是开发时用的，比如我们安装 js 的压缩包 gulp-uglify 时，我们采用的是 `npm install --save-dev gulp-uglify` 命令安装，因为我们在发布后用不到它，而只是在我们开发才用到它。`dependencies` 下的模块，则是我们发布后还需要依赖的模块，如 jQuery 库，在开发完后还要依赖，否则无法运行。

**附加内容：查看和删除模块**
- 查看全局新安装模块：`npm list -g --depth 0`
- 删除全局模块：`npm uninstall <name> -g`
- 删除本地模块：`npm uninstall <name>`，删除模块时，无论安装在 `dependencies` 还是 `devDepencies` 中都会删除，并更新在 `package.json` 中的对应信息。命令后面加不加 `--save` 或 `--save-dev` 参数效果都一样。

**附加内容：查看最新（所有）版本**
- 查看所有版本：`npm view webpack versions`
- 查看最新版本：`npm view webpack version`
- 查看版本及版本信息：`npm info webpack`

**附加内容：查看所有包的目前最新版本**
- `npm outdated -g`

**附加内容：全局包或指定包升级到最新版本**
- `npm install –g <name>`

### 2 使用方式
（1）运行npm init初始化项目，本地安装webpack。填写完提示信息后（可全部回车最后选 Y），在目录生成 `package.json` 文件。注：也可使用 `npm init –y`，从当前目录中提取的信息生成默认的 `package.json`，创建过程中不会提问。

（2）创建 `main.js` 文件，将项目依赖都写在这里。

（3）例如，本地安装 `jquery 3.0.0`，执行 `npm install jquery@3.0.0 --save-dev`

（4）在 `main.js` 中，引入本地 jquery，使用命令：`import $ from 'jquery'`，这种是 ES6 中导入模块的方式，ES6 语法浏览器可能不支持，需要用 webpack 处理。webpack 不仅能够处理 JS 文件的互相依赖关系，还能够处理 JS 的兼容问题，把高级的、浏览器不是别的语法，转为低级的，浏览器能正常识别的语法。

（5）将 `main.js` 用 webpack 进行处理。输入命令：`webpack  .\src\main.js  .\dist\bundle.js`，（注意：这种方式在 4.x 版本不能再使用，必须使用配置文件）指定目标和输出目录。每次都要手动指定目录非常不便，此时在配置文件 `webpack.config.js` 中设置入口和出口，直接使用 webpack 命令即可。配置文件内容：

```
const path = require('path')
module.exports = {
// 指定入口，表示要使用 webpack 打包的文件
  entry: path.join(__dirname, './src/main.js'),
  // 输出文件相关的配置
  output: {
    path: path.join(__dirname, './dist'), // 指定打包好的文件的输出目录
    filename: 'bundle.js' // 指定输出的文件的名称
  }
}
```

**附加内容: webpack4.x的配置变化**
- webpack4.x中，CLI被移动到了一个专门的包 webpack-cli里了, 需要全局安装webpack-cli：npm install webpack-cli -g
- webpack  目标路径  输出路径，这种命令在4.x版本不能再使用，必须使用配置文件。
- webpack.config.js，不再支持 module下的loaders，需要把loaders改成rules。如下：

```
module: {
        rules: [
            //针对css文件，进行对应的loader处理
            { test: /\.css$/, loader: "style-loader!css-loader" }
        ]
    }
```

- 新增配置项 mode，取值 'development' 或 'production'，例如：

```
module.exports={
    mode: 'development'
}
```

- 为了更加简便，并实现自动打包、编译，页面自动刷新的功能，可安装 webpack-dev-server。使用命令：`npm install webpack-dev-server --save-dev`

**注意1：使用webpack-dev-server要求webpack必须在本地安装，即使全局安装过，也要执行一次本地安装。webpack-cli全局安装即可，不用在本地安装。**

**注意2：本地安装的 webpack-dev-server无法作为脚本命令在powershell 终端中直接运行，只有安装到全局才能在终端中正常执行。**

**注意3：安装完成后需要在 `package.json` 中 `<script>` 添加下列语句：**

```
"dev":"webpack-dev-server --open --config webpack.config.js"
```

表示添加启动命令 dev，运行时自动打开默认浏览器展示效果，指定配置文件。系列参数也可以在配置文件中设置，在 `webpack.config.js` 增加 `dev-server` 配置项即可（不推荐这种方式，推荐用命令）：

```
  devServer: {
    open: true, // 自动打开浏览器
    port: 3000, // 设置启动时候的运行端口
contentBase: 'src', // 指定托管的根目录，自动打开时以此目录为基础找index.html
    hot: true // 启用热更新（第一步）。在配置文件中设置热部署（第二步），在webpack.config.js中增加一项：const webpack = require('webpack')
  } ,
  plugins: [
new webpack.HotModuleReplacementPlugin() // 实例化一个热更新的模块对象（第三步）
]
```

以上配置等同于在 `package.json` 中 `<script>` 添加：

```
"dev":"webpack-dev-server --open --port 3000 --contentBase src --hot"
```

配置完成后，使用命令：`npm run dev`，即可打开页面。

**注意：用命令配置最为简便。而且经过试验，在 `webpack 4.14.0` 中已经自带热更新，如果命令中使用参数 `--hot`，执行 `npm run dev` 后反而不会自动刷新。**

webpack-dev-server 帮我们打包生成的 bundle.js 文件，并没有存放到实际的物理磁盘上，而是托管到了内存中，项目根目录中，找不到这个打包好的 bundle.js。可以认为 `webpack-dev-server` 把打包好的文件，以一种虚拟的形式，托管到项目的根目录中，虽然看不到它，但是它和 dist、src、node_modules 目录平级，能够在浏览器地址栏可输入：http://localhost:8080/bundle.js 访问到，在 `index.html` 页面中的引用，应使用根目录的 `bundle.js`，即：`<script src="/bundle.js">`，放到内存中能够不受硬盘转速影响，提高实时打包速度，减少硬盘读写。

（7）使用 `html-webpack-plugin` 插件。使用该插件之后，我们不再需要手动处理 `bundle.js` 的引用路径了，因为这个插件已经帮我们自动创建了合适的 script, 并且在页面引用了正确的路径。安装命令：

```
npm install html-webpack-plugin --save-dev
```

安装完成后，在 `webpack.config.js` 中增加两个配置：

```
//导入插件
const htmlWebpackPlugin = require('html-webpack-plugin')
//在plugins节点增加一项数据，创建一个在内存中生成 HTML页面的插件
plugins: [
      new htmlWebpackPlugin({
      template: path.join(__dirname, './src/index.html'), // 指定模板页面，根据指定的页面路径生成内存中的页面。
      filename: 'index.html' // 指定生成的页面的名称。
    })
  ]
```

该插件可在内存中生成一个 html 页面，同时自动把打包好的 `bundle.js` 追加到页面中去，浏览器查看页面源代码可以发现，底部自动插入了一行：
`<script type="text/javascript" src="bundle.js"></script>`


### 3 webpack 导入样式
#### 3.1 引入模块加载器
在main.js中引入样式：`import './css/index.css'`。webpack 默认只能处理 js 类型的文件，处理 css 文件需要引入两个 loader，命令：`npm i style-loader css-loader –d`

#### 3.2 配置第三方模块加载器
安装完成后，在 `webpack.config.js` 增加 module 配置项，配置所有第三方模块加载器：

```
module: {
    //所有第三方模块的匹配规则
    rules: [
    //配置处理 .css 文件的第三方loader 规则
    { test: /\.css$/, use: ['style-loader', 'css-loader'] },    
    //配置处理 .less 文件的第三方 loader 规则
    { test: /\.less$/, use: ['style-loader', 'css-loader', 'less-loader'] },       
    //配置处理 .scss 文件的 第三方 loader 规则
    { test: /\.scss$/, use: ['style-loader', 'css-loader', 'sass-loader'] },     
    ]
}
```

#### 3.3 webpack 处理第三方文件类型的过程
1. 发现要处理的文件不是JS文件，然后在配置文件中，查找有没有对应的第三方loader规则；
2. 如果能找到对应的规则， 就会调用对应的 loader 处理这种文件类型；
3. 在调用loader 的时候，是从后往前调用的；
4. 当最后的一个loader调用完毕，会把处理的结果，直接交给 webpack 进行打包合并，最终输出到  bundle.js

#### 3.4 匹配 less 文件和 scss 文件
分别另外安装专用 loader：
- 命令：`npm install less-loader --save–dev`
- 命令：`npm install sass-loader --save–dev`

#### 3.5 处理图片
有如下css样式。默认情况下，webpack 无法处理 CSS 文件中的 url 地址，不管是图片还是字体库，只要是 URL 地址，都处理不了。

```
html, body{
    .box{
        background: url('../images/xx.jpg');
    }
}
```

需要安装两个专用loader，使用命令：`npm install url-loader file-loader --save–dev`，其中 file-loader 是内部依赖。再增加匹配规则，处理 jpg、png、gif、bmp、jpeg 文件：

```
{
    test: /\.(jpg|png|gif|bmp|jpeg)$/,
    use: 'url-loader?limit=7631&name=[hash:8]-[name].[ext]'
}
```

url-loader参数名称是固定的，意义如下：
- limit：文件大小决定是否使用base64处理，如果小于给定值则转为base64字符串。
- name：不指定该参数时，默认使用hash值命名防止重名，[hash:8] 代表图片8位hash值，最长32位；[name]为真实文件名。

#### 3.6 处理字体文件
要使用 bootstrap 中的样式 `<link rel="stylesheet" href="/node_modules/bootstrap/dist/css/bootstrap.css">` 引入一个图标 `<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>`，在 main.js 中引入 `import 'bootstrap/dist/css/bootstrap.css'`

**注意： 如果要通过路径的形式，去引入 node_modules 中相关的文件，可以直接省略路径前面的 node_modules 这一层目录，直接写包的名称，然后后面跟上具体的文件路径。不写 node_modules 这一层目录 ，默认就会去 node_modules 中查找。**

处理字体文件的 loader：`{ test: /\.(ttf|eot|svg|woff|woff2)$/, use: 'url-loader' }`


### 4 webpack 下 babel 的安装和配置
#### 前言
class 关键字，是 ES6 中提供的新语法，是用来实现 ES6 中面向对象编程的方式，例子用法：

```
class Person {
  static info = { name: 'zs', age: 20 }
}
var p1 = new Person()
```

访问 Person 类身上的  info 静态属性：`console.log(Person.info)`。这种方法与 Java、C# 等实现面向对象的方式完全一样了，class 是从后端语言中借鉴过来的，来实现面向对象。

使用 static 关键字，可以定义静态属性，所谓的静态属性，就是可以直接通过类名，直接访问的属性。实例属性是只能通过类的实例，来访问的属性，叫做实例属性。以前的实现构造函数方式：

```
function Animal(name){
    this.name  = name
}
var a1 = new Animal('小花')
Animal.info = 123
//静态属性：
console.log(Animal.info)
//实例属性：
console.log(a1.name)
```

但是上述代码无法在浏览器中运行，此时需要引入 babel。

#### 处理 ES6 代码
在 webpack 中，默认只能处理一部分 ES6 的新语法，一些更高级的 ES6 语法或者 ES7 语法，webpack 是处理不了的。这时候，就需要借助于第三方的 loader 来帮助 webpack 处理这些高级的语法，当第三方 loader 把高级语法转为低级的语法之后，会把结果交给 webpack 去打包到 `bundle.js` 中。可通过 Babel 帮我们将高级的语法转换为低级的语法。

（1）在 webpack 中，可以运行如下命令，安装两套包，安装 Babel 相关的 loader 功能：
- 第一套包：Babel 的转化工具，共 3 个包：`npm install babel-core babel-loader babel-plugin-transform-runtime --save–dev`
- 第二套包： 高级语法到低级语法的对应关系字典，共 2 个包：`npm install babel-preset-env babel-preset-stage-0 --save–dev`

**注：babel-preset-env 是比较新的 ES 语法字典，它包含了所有的和 ES 相关的语法。之前经常安装的是 babel-preset-es2015，ES2015 也就是 ES6。**

（2）打开 webpack 的配置文件，在 module 节点下的 rules 数组中，添加一个新的匹配规则：`{ test:/\.js$/, use: 'babel-loader', exclude:/node_modules/ }`

**注意：在配置 babel 的 loader 规则的时候，必须把 node_modules 目录通过 exclude 选项排除掉。如果不排除，babel 会把 node_modules 中所有的第三方 JS 文件打包编译，这样非常消耗 CPU，打包速度非常慢。即使把所有 node_modules 中的 JS 转换完毕了，项目也无法正常运行。**

（3）在项目根目录中，新建一个叫做 `.babelrc` 的 babel 配置文件，该文件属于 JSON 格式，所以，在写 `.babelrc` 配置的时候，必须符合 JSON 语法规范：不能写注释，字符串必须用双引号。

安装的两套包中 `babel-preset` 前缀是语法类的包，`babel-plugin` 前缀是插件类的包。在 `.babelrc` 中根据安装的包写如下的配置：
```
{
    "presets": ["env", "stage-0"],
    "plugins": ["transform-runtime"]
}
```

配置完成后，即可运行 ES6 语法的相关内容。

#### render 函数
与传统使用组件的方式不同，该函数能够将绑定的操作区域整体替换为组件，例子中的 `<p>` 标签内容不会出现，并且每个操作区域只能渲染一个组件。

```
<body>
<div id="app">
    <p>test!</p>
</div>
<script src="https://unpkg.com/vue/dist/vue.js"></script>

<script type="text/x-template" id="tempComp">
    <div>我是模板组件</div>
</script>

<script>
    var tempComp = {
        template: "#tempComp"
    }
    new Vue({
        el: "#app",
        render: function (createElement) {
            return createElement(tempComp);
        }
    });
</script>
</body>
</html>
```


## 二、webpack 下使用 vue
### 1 安装
（1）执行命令：npm install vue --save-dev

（2）在main.js中导入：import Vue from "vue"，但是这种方式引入的vue构造是运行时版本（runtime-only），功能并不完全，传统例子不能运行。

### 2 导入vue包的查找规则
（1）找项目根目录中有没有node_modules的文件夹

（2）在node_modules中根据包名，找对应的vue文件夹

（3）在vue文件夹中，找一个叫做package.json的包配置文件

（4）在package.json文件中，查找一个main属性，main属性指定了这个包在被加载时候，的入口文件。"main": "dist/vue.runtime.common.js"，在main.js中导入的Vue就是从这里拿到，转到dist目录，发现有其他的包，vue.min.js、vue.js。因此可以有以下方法：
- 给定路径，import Vue from "../node_modules/vue/dist/vue.js"
- 在webpack.config.js中添加resolve数据项，修改 Vue结尾的文件被导入时候的引用包的路径：

```
resolve: {
    alias: {
       "vue$": "vue/dist/vue.js"
    }
  }
```

### 3 使用runtime-only模式渲染组件
（1）建立 vue 文件，例子，建立 `login.vue`，内容如下：

```
<template>
  <div><h1>这是登录组件，使用 .vue 文件定义出来的 --- {{msg}}</h1></div>
</template>
<script>
export default {
  data() {
    // 注意：组件中的 data 必须是 function
    return {
      msg: "123"
    };
  },
  methods: {
    show() {
      console.log("调用了 login.vue 中的 show 方法");
    }
  }
};
</script>
<style></style>
```

（2）main.js中导入该组件：`import login from './login.vue'`，默认情况下 webpack 无法打包 `.vue` 文件，需要安装相关的 loader：`npm install vue-loader vue-template-compiler --save-dev`

在配置文件中，新增 loader 配置项 ，vue-template-compiler 是内部依赖：`{ test:/\.vue$/, use: 'vue-loader' }`

**注意：webpack 4.x 中使用 vue-loader 要在 `webpack.config.js` 中另外配置以下内容：**

```
const VueLoaderPlugin=require("vue-loader/lib/plugin");
//在plugins节点增加一项数据
new VueLoaderPlugin()
```

（3）在 webpack 中要使用 vue 文件渲染，要使用 render 函数的方式，不能在 runtime-only 模式下使用传统的添加标签，否则报错。例子：

```
render: function (createElements) {
    return createElements(login)
}
```

改为ES6语法

```
render: c => c(login)
```

完成以上配置后，执行 `npm run dev` 后组件成功加载。

### 4 export、import详解
在 ES6 中，也通过规范的形式，规定了 ES6 中如何导入和导出模块，ES6 中导入模块，可使用两种方式：
- `import 模块名称 from '模块标识符'`
- `import '路径'`

在ES6中，使用 export default 和 export 向外暴露成员：`module.exports = {}`，这是 Node 中向外暴露成员的形式。

使用要点：
- export default 向外暴露的成员，可以使用任意的变量名来接收。**注意： 在一个模块中，export default只允许向外暴露1次。**
- 在一个模块中，可以同时使用export default和export向外暴露成员。
- 使用export向外暴露的成员，只能使用{ }的形式来接收。
- export可以向外暴露多个成员，如果某些成员在import的时候不需要，则可以不在{ }中定义，这种方式称为按需导出。
注意：使用export导出的成员，必须严格按照导出时候的名称来使用。
- 使用export导出的成员，可以使用as来起别名。

例子：src目录下的test.js中有如下内容：

```
var info = {
  name: 'zs',
  age: 20
}
export default info
export var title = '标题'
export var content = '目录'
```

在 src 目录下的 main.js 中调用：

```
import abc, { title as myTitle, content } from './test.js'
console.log(abc)//abc对应default，控制台输出对象info。注意：只能有一个default
console.log(myTitle + ' --- ' + content)//myTitle是title的别名，对应test.js中的title
```

**附加内容**
`npm install` 命令可以自动安装当前目录下 `package.json` 中记录下来的包。因此，复制项目或上传项目时，可以排除 node_modules 目录。

## 三、webpack 下使用 vue 路由
1、导入模块

`import Vue from 'vue'`

`import VueRouter from 'vue-router'`

2、在模块化工程中，必须使用 `Vue.use()` 安装路由模块 `Vue.use(VueRouter);`

3、导入需要展示的组件

`import login from './components/account/login.vue'`

`import register from './components/account/register.vue'`

4、在 `main.js` 中创建路由对象
```
var router = new VueRouter({
  routes: [
    { path: '/', redirect: '/login' },
    { path: '/login', component: login },
    { path: '/register', component: register }
  ]
});
```
5、在 `main.js` 中将路由对象，挂载到 Vue 实例上
```
var vm = new Vue({
  el: '#app',
  // render: c => { return c(App) }为什么不用？
  render(c) {
  return c(App);
  },
  router // 将路由对象，挂载到 Vue 实例上
});
```
6、`App.vue` 组件中，在 template 标签内添加 `router-link` 和 `router-view` 标签。
```
<template>
  <div>
    <h1>这是 App 组件</h1>
    <router-link to="/login">登录</router-link>
    <router-link to="/register">注册</router-link>
<router-view></router-view>
  </div>
</template>
<script></script>
<style></style>
```

### 子路由
还是使用上面的例子，子路由，独立一个路由 `router.js` 文件，内容如下：
```
import VueRouter from 'vue-router'
// 导入 Account 组件
import account from './main/Account.vue'
import goodslist from './main/GoodsList.vue'
// 导入Account的两个子组件
import login from './subcom/login.vue'
import register from './subcom/register.vue'
// 3. 创建路由对象
var router = new VueRouter({
  routes: [
// account的子路由，即渲染account后再进一步渲染login或register。
// 注意：子路由不带“/”
    {
      path: '/account',
      component: account,
      children: [
        { path: 'login', component: login },
        { path: 'register', component: register }
      ]
    },
    { path: '/goodslist', component: goodslist }
  ]
})
// 把路由对象暴露出去
export default router
```
