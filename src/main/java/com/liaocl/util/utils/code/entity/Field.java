package com.liaocl.util.utils.code.entity;

import lombok.Data;

/**
 * 字段信息
 * @author liaocl
 */
@Data
public class Field {

    /**
     * 字段名
     */
    private String fieldName;

    /**
     * 数据库列名
     */
    private String columnName;

    /**
     * 字段类型
     */
    private String fieldType;

    /**
     * 字段注解
     */
    private String fieldRemarks;
}


