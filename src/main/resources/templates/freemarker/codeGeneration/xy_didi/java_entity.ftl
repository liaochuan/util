package ${packageName}.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.xy.core.base.BaseModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

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
@EqualsAndHashCode(callSuper = true)
public class ${tableInfo.className} extends BaseModel {

    <#list tableInfo.fieldList as field>
        <#if !",id,createTime,createBy,updateTime,updateBy,deleted,system,"?contains(","+field.fieldName+",")>
            <#if field.fieldRemarks != "">
    /**
     * ${field.fieldRemarks}
     */
            </#if>
    private ${field.fieldType} ${field.fieldName};

        </#if>
    </#list>
}