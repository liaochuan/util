package ${packageName}.dto.req;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

<#list tableInfo.typeSet as type>
import ${type};
</#list>

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}修改请求对象</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel("${tableInfo.tableRemarks}DTO")
public class ${tableInfo.className}ModifyDTO {

    <#list tableInfo.fieldList as field>
        <#if field.fieldRemarks != "">
    @ApiModelProperty("${field.fieldRemarks}")
        </#if>
    private ${field.fieldType} ${field.fieldName};

    </#list>
}