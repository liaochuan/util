package ${packageName}.infrastructure.dao.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
<#list tableInfo.typeSet as type>
import ${type};
</#list>

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}数据库实体</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Data
@Accessors(chain = true)
@TableName(value = "${tableInfo.tableName}")
@EqualsAndHashCode
public class ${tableInfo.className}Entity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.ASSIGN_ID)
    private Long id;

    @TableField(fill = FieldFill.INSERT)
    private Long createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Long updateTime;

    <#list tableInfo.fieldList as field>
        <#if !",id,createTime,updateTime,"?contains(","+field.fieldName+",")>
            <#if field.fieldRemarks != "">
    /**
     * ${field.fieldRemarks}
     */
            </#if>
    private ${field.fieldType} ${field.fieldName};

        </#if>
    </#list>
}