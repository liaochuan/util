package ${packageName}.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

<#list tableInfo.typeSet as type>
import ${type};
</#list>

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}领域对象</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${tableInfo.className}Entity {

    <#list tableInfo.fieldList as field>
        <#if field.fieldRemarks != "">
    /**
     * ${field.fieldRemarks}
     */
        </#if>
    private ${field.fieldType} ${field.fieldName};

    </#list>
}