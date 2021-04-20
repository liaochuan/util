package com.liaocl.util.utils.code.entity;

import java.util.List;
import java.util.Set;

/**
 * @author liaocl
 */
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

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableRemarks() {
        return tableRemarks;
    }

    public void setTableRemarks(String tableRemarks) {
        this.tableRemarks = tableRemarks;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public List<Field> getFieldList() {
        return fieldList;
    }

    public void setFieldList(List<Field> fieldList) {
        this.fieldList = fieldList;
    }

    public Set<String> getTypeSet() {
        return typeSet;
    }

    public void setTypeSet(Set<String> typeSet) {
        this.typeSet = typeSet;
    }
}


