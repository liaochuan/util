package com.liaocl.util.utils.code.entity;

/**
 * 代码生成信息
 * @author liaocl
 */
public class GenerateInfo {

    /**
     * 项目名称
     */
    private String projectName;
    
    /**
     * 表名
     */
    private String tableName;
    
    /**
     * 作者
     */
    private String author;
    
    /**
     * 包名
     */
    private String packageName;

    /**
     * 是否依据包名路劲生成文件
     */
    boolean pathByPackage;

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public boolean isPathByPackage() {
        return pathByPackage;
    }

    public void setPathByPackage(boolean pathByPackage) {
        this.pathByPackage = pathByPackage;
    }
}
