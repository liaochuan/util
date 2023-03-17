package com.liaocl.util.utils.code.entity;

import lombok.Data;

/**
 * 代码生成信息
 * @author liaocl
 */
@Data
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
     * 文件生成路径
     */
    private String filePath;

    /**
     * 是否依据包名路径生成文件
     */
    private boolean pathByPackage;

    /**
     * 是否删除上次生成的代码
     */
    private boolean deleteOld;

}
