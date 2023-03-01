package ${packageName}.po;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baron.mybatisplus.base.BasePO;
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
@EqualsAndHashCode(callSuper = false)
public class ${tableInfo.className}PO extends BasePO {

    <#list tableInfo.fieldList as field>
        <#if field.fieldRemarks != "">
    /**
     * ${field.fieldRemarks}
     */
        </#if>
    private ${field.fieldType} ${field.fieldName};

    </#list>
}