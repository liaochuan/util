package com.liaocl.util.utils.code.entity;

import lombok.Data;

import java.util.List;
import java.util.Set;

/**
 * 表信息
 * @author liaocl
 */
@Data
public class TableInfo {

    /**
     * 表名
     */
    private String tableName;

    /**
     * 表注释
     */
    private String tableRemarks;

    /**
     * 生成实体类的名字
     */
    private String className;

    /**
     * 字段集合
     */
    private List<Field> fieldList;

    /**
     * 需引用的字段类型集合
     */
    private Set<String> typeSet;
}


