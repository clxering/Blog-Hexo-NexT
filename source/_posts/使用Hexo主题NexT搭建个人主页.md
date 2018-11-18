---
title: 使用Hexo主题NexT搭建个人主页
date: 2018/9/11 17:15:25
categories:
- 前端技术
tags:
- 综合
---

> 摘要：本文记录了使用Hexo主题NexT搭建个人主页的关键步骤，包括部署、修改主题默认样式和事件、域名配置等内容。

<!-- more -->

## 前言

按照惯例，搭建完成后，将流程记录下来作为开篇文章。

## 环境
- git 2.16.1
- node 8.11.3

## 参考文档
- Hexo文档地址：https://hexo.io/zh-cn/

- NexT主题文档地址：http://theme-next.iissnan.com/

- NexT主题github地址：https://github.com/iissnan/hexo-theme-next/blob/master/README.cn.md

## 步骤概览

### 1、安装git和node.js
- 安装过程简单，略。

### 2、配置github
- 在github新建仓库`<githubUserName>.github.io`
- 注意事项
	- 该仓库只能建立一个
	- 建立仓库后留空备用，不用建立任何默认文件，如Readme、License等。这个库只保留部署生成的代码（**不是源码！**），Hexo发布网站时，push命令加了`--force`参数，每次提交都会强制覆盖远程仓库。
	- 如果要在github保存源码，最好是另外开一个仓库，这时就和常规开源项目一样的操作了。

### 3、建立工作文件夹
- 任意位置，名称不限（遵循合法命名规则为前提）

### 4、初始化hexo环境
- 全局安装hexo：`$ npm install -g hexo-cli`
- 进入命令行，在工作文件夹下执行命令：`$ hexo init`。初始化完成后，工作文件夹的结构及**主要**文件（夹）描述如下：

```
.
├── _config.yml（站点配置文件）
├── package.json（应用程序的信息）
├── scaffolds（模版文件夹。新建文章时，Hexo会根据scaffold来建立文件）
├── source（资源文件夹）
|   ├── _drafts（草稿，初始化后不一定能看到，需要另行配置）
|   └── _posts（保存文章）
└── themes（主题文件夹。Hexo会根据主题来生成静态页面。）
├── node_modules
├── .gitignore
├── package-lock.json
```

- 验证默认主题
	- 工作文件夹下执行启动服务器命令：`$ hexo server`（可简写为`$ hexo s`）
	- 浏览器访问默认地址`http://localhost:4000/`，此时应该能够看到Hexo的默认主题。

### 5、引入NexT主题
- 在工作文件夹下右键进入命令行，执行命令：`$ git clone https://github.com/iissnan/hexo-theme-next themes/next`
- 打开`站点配置文件`，找到`theme` 字段，并将其值更改为`next`。
- 验证主题
	- 工作文件夹下执行启动服务器命令：`$ hexo server`
	- 浏览器访问默认地址`http://localhost:4000/`，若配置无误，即可看到NexT主题的默认样式。

### 6、发布
- 安装git依赖。工作文件夹下执行命令`$ npm install hexo-deployer-git --save`
- 编辑`站点配置文件`，修改`# Deployment`条目下的内容：

```
# Deployment
deploy:
  type: git
  repo: https://github.com/githubUserName/githubUserName.github.io.git（仓库地址，这里用https或ssh均可）
  branch: master（分支名称）
```
- 工作文件夹下执行命令`$ hexo clean`，清除缓存文件 (db.json) 和已生成的静态文件 (public)
- 工作文件夹下执行命令`$ hexo generate`（可简写为`$ hexo g`），生成静态文件
- 工作文件夹下执行命令`$ hexo deploy`（可简写为`$ hexo d`），发布到远程仓库


## 修改默认配置

### ⭐网站信息
- 编辑`站点配置文件`，修改`# Site`条目下的内容：
```
# Site
title: Hexo（网站标题，默认值：Hexo）
subtitle:（网站副标题）
description:（网站描述，会显示在侧边栏，若设置博客作者头像，默认会显示在头像下方）
keywords:
author: John Doe（作者名字）
language:（设置语言）
timezone:
```
- description主要用于SEO，告诉搜索引擎一个关于站点的简单描述，通常建议在其中包含网站的关键词
- author参数用于主题显示文章的作者

### ⭐语言
- 编辑`站点配置文件`，将language设置成所需语言，详见[NexT主题文档](http://theme-next.iissnan.com/getting-started.html)。例如选用简体中文，配置如下：
```
language: zh-Hans
```

### ⭐导航菜单
- 导航栏项目均为可选
- 添加标签页Tags page
	- 工作文件夹下执行命令：`$ hexo new page "tags"`,在`source`下建立`tags`文件夹，用于保存每篇文章的标签信息。
	- 编辑`tags`文件夹下的`index.md`
	- 设置页面类型为`tags`。`index.md`内容如下：

	```
	title: All tags（点击导航栏的标签后，显示的文本）
  date: 2018-09-12 10:01:04（这一项，改与不改暂时没发现有什么影响）
  type: "tags"
	```
	- 在`主题配置文件`中解开`menu`项目下的相应注释即可。
	```
	# Value before `||` delimeter is the target link.
	# Value after `||` delimeter is the name of FontAwesome icon. If icon (with or without delimeter) is not specified, question icon will be loaded.
	menu:
	  home: / || home
	  #about: /about/ || user
	  #tags: /tags/ || tags
	  #categories: /categories/ || th
	  archives: /archives/ || archive
	  #schedule: /schedule/ || calendar
	  #sitemap: /sitemap.xml || sitemap
	  #commonweal: /404/ || heartbeat
	```
- 添加分类页Categories page
	- 同上条所述，在`source`下建立`categories`文件夹
	- 修改`index.md`
	- 在`主题配置文件`中解开`menu`项目下的相应注释即可。
- 标签页数量、分类数量、文章的数量如果大于0，默认显示位置在侧边栏。

### ⭐社交媒体Social Media
- 在`主题配置文件`中解开`social`项目下相应的注释即可开启。该部分的链接默认显示位置在侧边栏中。
```
social:
  #GitHub: https://github.com/yourname || github
  #E-Mail: mailto:yourname@gmail.com || envelope
  #Google: https://plus.google.com/yourname || google
  #Twitter: https://twitter.com/yourname || twitter
  #FB Page: https://www.facebook.com/yourname || facebook
  #VK Group: https://vk.com/yourname || vk
  #StackOverflow: https://stackoverflow.com/yourname || stack-overflow
  #YouTube: https://youtube.com/yourname || youtube
  #Instagram: https://instagram.com/yourname || instagram
  #Skype: skype:yourname?call|chat || skype
```

## 修改默认样式和事件

### ⭐修改社交媒体列表的默认位置
- 这里以`scheme: Muse`的显示模式为例
- 社交媒体开启后默认位置显示在侧边栏，现在将其移动到页面底部
- 先执行`$ hexo s`启动服务器，在浏览器开启F12，定位到社交媒体的<span>标签，发现样式`links-of-author-item`
```
<div class="links-of-author motion-element" style="opacity: 1; display: block; transform: translateX(0px);">      
	<span class="links-of-author-item">
		<a href="https://github.com/yourname" target="_blank" title="GitHub">
		<i class="fa fa-fw fa-github"></i>GitHub</a>
	</span>    
</div>
```
- 在`themes/next/layout`下使用通配符`*.swig`搜索全部swig文件，全选后用notepad++一并打开。注：这里不一定用notepad++，只是一种参考途径。
- 在全部已经打开的文件中搜索`links-of-author-item`，即可定位有关社交媒体部分的源码如下：
```
{% if theme.social %}
            <div class="links-of-author motion-element">
                {% for name, link in theme.social %}
                  <span class="links-of-author-item">
                    <a href="{{ link.split('||')[0] | trim }}" target="_blank" title="{{ name }}">
                      {% if theme.social_icons.enable %}
                        <i class="fa fa-fw fa-{{ link.split('||')[1] | trim | default('globe') }}"></i>{#
                    #}{% endif %}{#
                      #}{% if not theme.social_icons.icons_only %}{#
                        #}{{ name }}{#
                      #}{% endif %}{#
                  #}</a>
                  </span>
                {% endfor %}
            </div>
{% endif %}
```
- 逻辑很简单，但是需要注意的是，需要把`default('globe')`从样式列表中移除，否则整个列表不显示。至于其他的问题，字号、字体什么的，添加行内样式即可解决。
- 同理，F12查看脚注元素，在全部swig文件中搜索`copyright`（找其他样式也行）
```
<footer id="footer" class="footer">
	<div class="footer-inner">
		<div class="copyright">© <span itemprop="copyrightYear">2018</span>
			<span class="with-love">
				<i class="fa fa-user"></i>
			</span>
			<span class="author" itemprop="copyrightHolder">John Doe</span>
		</div>
		<div class="powered-by">Powered by <a class="theme-link" target="_blank" href="https://hexo.io">Hexo</a></div>
		<span class="post-meta-divider">|</span>
		<div class="theme-info">Theme — <a class="theme-link" target="_blank" href="https://github.com/iissnan/hexo-theme-next">NexT.Muse</a> v5.1.4</div>
	</div>
</footer>
```
- 定位脚注部分的源码
```
<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} &mdash; {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.footer.icon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || config.author }}</span>
…………（略）
```
- 接下来，将社交媒体的源码移动到脚注部分的适当位置，完成。

### ⭐修改打赏按钮样式及二维码动画
- 在`主题配置文件`中解开`# Reward`项目下相应的注释即可开启，付款二维码自行准备。之后在每篇文章后，会出现打赏按钮，点击则显示支付二维码。
```
# Reward
reward_comment: Donate comment here（打赏按钮上方的描述性文字）
wechatpay: /images/wechatpay.jpg（微信）
alipay: /images/alipay.jpg（支付宝）
#bitcoin: /images/bitcoin.png（bitcoin）
```
- 首先修改打赏按钮样式。在`themes/next/source/css`下，使用通配符`*.styl`，以上例同样的方式定位css如下，按需修改即可。
```
#rewardButton {
    cursor: pointer;
    border: 0;
    outline: 0;
    border-radius: 5px;
    padding: 0;
    margin: 0;
    letter-spacing: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
}
#rewardButton span {
    display: inline-block;
    width: 80px;
    height: 35px;
    border-radius: 5px;
    color: #fff;
    font-weight: 400;
    font-style: normal;
    font-variant: normal;
    font-stretch: normal;
    font-size: 18px;
    font-family: "Microsoft Yahei";
    background: #F44336;
}
#rewardButton span:hover{
    background: #F7877F;
}
```
- 接下来修改二维码动画。通过F12，发现打赏按钮直接在属性里用js实现了click事件，二维码出现时比较生硬，没有动画过渡
```
<button id="rewardButton" disable="enable" onclick="var qr = document.getElementById('QR'); if (qr.style.display === 'none') {qr.style.display='block';} else {qr.style.display='none'}">
    <span>Donate</span>
  </button>
```
- 在`themes/next/source/js/src`下，定位`post-details.js`，添加jQuery代码即可实现动画效果的小幅优化
```
$("#rewardButton").on("click",function(){
	var $btn=$("#QR");
	if ($btn.css('display') === 'none') {
		$btn.fadeIn("normal");
	}
	else {
		$btn.slideUp("normal");
	}
  });
```

### ⭐修改主题的文字对齐方式
- 默认有4个主题：
```
# Schemes
#scheme: Muse
#scheme: Mist
scheme: Pisces
#scheme: Gemini
```
- Pisces主题界面比较简练，但是对齐方式为justify（两端对齐），多行内容展示时很不美观；Gemini主题的对齐方式为left（左对齐），但是界面不如前者简练。基于此需求，下面要将Pisces主题的对齐方式修改为left（左对齐）。
- 在`themes/next/source/css/schemes`下对应各主题的版式，定位：`Pisces/_posts.styl`
- 将默认齐方式justify修改为left
```
.post-body {
  +mobile() {
    text-align: left;
  }
}
```

## 域名配置（需购买，可不备案。以阿里云为例）
- 进入阿里云的域名服务，在`解析设置`添加CNAME解析，将记录值为`<githubUserName>.github.io`，其他设置按需填写即可。

![添加CNAME解析](https://upload-images.jianshu.io/upload_images/5492471-9d3b565d869907d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在工作文件夹的source目录下新建CNAME文件（无扩展名），文件内容仅为购买的域名。

![新建CNAME文件](https://upload-images.jianshu.io/upload_images/5492471-4717b575fc8f6eae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 重新生成部署代码到github，此时进入`<githubUserName>.github.io`库，若在Settings中出现`Your site is published at 域名`的提示，说明配置成功

![查看Setting](https://upload-images.jianshu.io/upload_images/5492471-631ac9c9a4c80200.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
