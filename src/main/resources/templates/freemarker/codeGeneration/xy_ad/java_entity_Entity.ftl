package ${packageName}.entity;

import com.xy.ad.common.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
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
public class ${tableInfo.className}Entity extends BaseEntity {

    <#list tableInfo.fieldList as field>
        <#if !",id,createTime,createBy,updateTime,updateBy,deleted,"?contains(","+field.fieldName+",")>
            <#if field.fieldRemarks != "">
    /**
     * ${field.fieldRemarks}
     */
            </#if>
    private ${field.fieldType} ${field.fieldName};

        </#if>
    </#list>
}