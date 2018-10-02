---
title: MySQL下使用存储过程批量建表
date: 2018-10-02 07:29:12
categories:
- 后端技术
tags:
- MySQL
---

> 摘要：记录了 MySQL下使用存储过程批量建表的过程和注意事项。

<!-- more -->

## 需求

建立fundvaluedata_0开始，到fundvaluedata_9共10张表，各表的字段结构、数据引擎、编码方式等均相同。

## 解决方案
使用如下存储过程：
```
DELIMITER //
CREATE PROCEDURE create_table()
BEGIN
DECLARE `@i` INT(11);
DECLARE `@sqlstr` VARCHAR(2560);
SET `@i`=0;
WHILE `@i` < 10 DO
SET @sqlstr = CONCAT(
"CREATE TABLE fundvaluedata_",

`@i`,

"(
`ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fundCode` VARCHAR(6) NOT NULL,
  `valueDate` VARCHAR(10) NOT NULL,
  `NAV` VARCHAR(10) NOT NULL,
  `cumulativeNAV` VARCHAR(10) NOT NULL,
  `dailyGrowthRate` VARCHAR(10) NOT NULL,
  `subscribeStatus` VARCHAR(20) NOT NULL,
  `redemptionStatus` VARCHAR(20) NOT NULL,
  `melonCutting` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 "
);
PREPARE stmt FROM @sqlstr;
EXECUTE stmt;

SET `@i` = `@i` + 1;
END WHILE;
END;
```

执行存储过程，执行后删除存储过程并恢复默认命令结束符：

```
CALL create_table();
DROP PROCEDURE create_table;
DELIMITER ;
```

## 注意事项
创建存储过程时，若采用命令行的方式，要先修改默认命令结束符，这样将CREATE到END之间的代码当是一条语句来执行。例如上述代码中的`DELIMITER //`，将命令结束符修改为`//`，执行结束后再修改回`;`。
