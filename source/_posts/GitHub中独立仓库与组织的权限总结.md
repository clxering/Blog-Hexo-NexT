---
title: GitHub 中独立仓库与组织的权限总结
date: 2019-03-23 07:44:16
categories:
- 通用技术
tags:
- git
---

> 摘要：记录了 GitHub 中独立仓库与组织的角色及其对应具备的权限。

<!-- more -->

一、独立仓库（公开或私有）
独立仓库包含 **仓库拥有者和外部协作者** 两种角色，相关权限如下表

| | 直接写入 | issue 操作<br>[删除、隐藏、修改] | 添加标签 |分支操作<br>[删除、创建] | 邀请校对 | 被邀请校对 | 校对操作<br>[同意、驳回、重校] |强制合并 | Setting 菜单可见 |
| :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: |
| 仓库拥有者 | √  | √ | √ | √ | √ | √ | √ | √ | √ |
| 外部协作者 | √ | √ | √ | √ | √ | √ | √ | × | × |

**注：Setting 菜单是否可见决定了是否具备删库、设置分支规则、邀请外部协作者、密钥设置等高级权限。**

二、组织
组织包含 **组织拥有者、成员、外部协作者** 三种角色，以及 **Read、Write、Admin** 三种权限。

1、Base permissions（基本权限）
Base permissions to the organization’s repositories apply to all members and excludes outside collaborators. Since organization members can have permissions from multiple sources, members and collaborators who have been granted a higher level of access than the base permissions will retain their higher permission privileges.

组织存储库的基本权限适用于所有成员（不含外部协作者）。由于组织成员可以拥有多个库的自定义权限，因此被授予比基本权限更高级别访问权限时，成员和协作者将保留更高的权限。

基本权限包含如下几种：

- None，Members will only be able to clone and pull public repositories. To give a member additional access, you’ll need to add them to teams or make them collaborators on individual repositories.

成员只能对公共库实施 clone 和 pull 操作。要为成员提供额外的访问权限，需要将它们添加到团队中，或者让它们成为各个存储库的外部协作者。

- Read，Members will be able to clone and pull all repositories.

成员可以对所有库实施 clone 和 pull 操作。

- Write，Members will be able to clone, pull, and push all repositories.

成员可以对所有库实施 clone、pull 和 push 操作。

- Admin，Members will be able to clone, pull, push, and add new collaborators to all repositories.

成员可以对所有库实施 clone、pull、push 和添加外部协作者的操作。

2、组织角色
- Owner，Has full administrative access to the entire organization.

对整个组织具有完全的管理访问权限。**组织角色为 Owner 时，对于组织中每一个库而言，默认权限都是 Admin。**

- Member，Can see every member and non-secret team in the organization, and can create new repositories.

可以查看组织中的每个成员和非机密团队，并可以创建新的存储库。**组织角色为 Member 时，对于组织中每一个库而言，默认权限都与基本权限相同。**

3、库权限
Read、Write、Admin，详见基本权限的描述。**如果需要在某一个库中授予某个成员高于基本权限的权限，需要将其添加为外部协作者。**

4、组织权限总结如下

| | 直接写入 | issue 操作<br>[删除、隐藏、修改] | 添加标签 |分支操作<br>[删除、创建] | 邀请校对 | 被邀请校对 | 校对操作<br>[同意、驳回、重校] |强制合并 | 库 Setting 菜单可见 | 组织 Setting 菜单可见 |
| :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: |
| 组织拥有者 | √  | √ | √ | √ | √ | √ | √ | √ | √ | √ |
| Read | × | × | × | × | × | √ | × | × | × | × |
| Write | √ | √ | √ | √ | √ | √ | √ | × | × | × |
| Admin | √ | √ | √ | √ | √ | √ | √ | √ | √ | × |
