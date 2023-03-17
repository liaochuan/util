package ${packageName}.dto.req;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

<#list tableInfo.typeSet as type>
    <#if type != "java.time.Instant">
import ${type};
    </#if>
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
        <#if field.fieldName == "id">
    private String id;
        <#elseif field.fieldType == "Instant">
    private Long ${field.fieldName};
        <#else>
    private ${field.fieldType} ${field.fieldName};
         </#if>

    </#list>
}