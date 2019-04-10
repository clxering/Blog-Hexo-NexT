---
title: GitHub 中使用 issues 模版和 pull request 模版
date: 2018-12-01 22:35:33
categories:
- 通用技术
tags:
- git
---

> 摘要：在GitHub代码库中，引入代码库维护者定制的 issues 模版和 pull request 模版，让人们可以有针对性的提供某类问题的准确信息，从而在后续维护中能够进行有效地对话和改进，而不是杂乱无章的留言。

<!-- more -->

### 一、issues 模版

#### 1.1 默认模版
- 在代码库新建目录：`.github`
- 在 `.github` 目录下添加 `ISSUE_TEMPLATE.md` 文件作为 issues 默认模版。当创建 issue 时，若未建立多模版或选择了 `Open a regular issue` 时，系统会引用该模版。

{% asset_img 1.png %}

#### 1.2 多模版
- 在代码库新建目录：`.github/ISSUE_TEMPLATE`
- 该目录下可添加多个 `.md` 文件作为 issues 模版。当创建 issue 时，系统会展示这些模版供选择。
- `.md` 文件参考格式如下：

```
---
name: 该模版的名称（创建 issue 时，系统展示模版列表时会显示该名称）
about: 该模版的描述（创建 issue 时，系统展示模版列表时会显示该描述）
---

正文内容……
```

#### 1.3 注意事项
- issues 的默认模版和多模版可同时存在。
- 关于 issues 模版的描述可详见帮助文档：https://help.github.com/articles/manually-creating-a-single-issue-template-for-your-repository/

### 二、pull request 模版

#### 2.1 默认模版
- 在代码库新建目录：`.github`
- 在 `.github` 目录下添加 `PULL_REQUEST_TEMPLATE.md` 文件作为 pull request 默认模版。当创建不带参数的 pull request 时，系统会引用该模版。

#### 2.2 多模版
- 在代码库新建目录：`.github/PULL_REQUEST_TEMPLATE`
- 该目录下可添加多个 `.md` 文件作为 pull request 模版。
- pull request 模版要通过查询参数来调用。例如，要使用 `pr-template-1.md` 这个模版，可使用如下查询：

```
https://github.com/用户名/代码库名称/compare/分支名称?expand=1&template=pr-template-1.md
或参考GitHub帮助文档的格式，如下。两者效果相同。
https://github.com/用户名/代码库名称/compare/master...分支名称?expand=1&template=pr-template-1.md
```
- 可选查询参数
  - `expand=1`，直接跳转到 pull request 界面。如果不带此参数会先到 compare 界面，需手动进入pull request 界面。
  - `template=pr-template-1.md`，调用名为 `pr-template-1.md` 的模版。如果不带此参数，则调用默认模版。
  - `title=New+bug+report`（或者 `title=New%20bug%20report`），指定 pull request 的标题为 `New bug report`
  - 其他参数可详见帮助文档：https://help.github.com/articles/about-automation-for-issues-and-pull-requests-with-query-parameters/

#### 2.3 注意事项
- pull request 的默认模版和多模版可同时存在。
- 关于 pull request 模版的描述可详见帮助文档：https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/
