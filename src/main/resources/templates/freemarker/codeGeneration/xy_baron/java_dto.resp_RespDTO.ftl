package ${packageName}.dto.resp;

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
 * <p>Description: ${tableInfo.tableRemarks}响应体对象</p>
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
@ApiModel("${tableInfo.tableRemarks}返回DTO")
public class ${tableInfo.className}RespDTO {

    <#list tableInfo.fieldList as field>
        <#if field.fieldRemarks != "">
    @ApiModelProperty("${field.fieldRemarks}")
        </#if>
    private ${field.fieldType} ${field.fieldName};

    </#list>
}