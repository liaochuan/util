package ${packageName}.api.dto.resp;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
<#list tableInfo.typeSet as type>
import ${type};
</#list>

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(description = "${tableInfo.tableRemarks}响应体对象")
public class ${tableInfo.className}VO implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list tableInfo.fieldList as field>
        <#if field.columnName == "id">
    @ApiModelProperty(value = "主键id")
    private String id;
        <#else>
            <#if field.fieldRemarks != "">
    @ApiModelProperty(value = "${field.fieldRemarks}")
            </#if>
    private ${field.fieldType} ${field.fieldName};
        </#if>

    </#list>
}