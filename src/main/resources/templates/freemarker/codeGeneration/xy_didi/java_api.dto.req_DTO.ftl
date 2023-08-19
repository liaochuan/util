package ${packageName}.api.dto.req;

import ${packageName}.api.dto.validation.group.UpdateGroup;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.io.Serializable;
<#list tableInfo.typeSet as type>
import ${type};
</#list>

@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ApiModel(description = "${tableInfo.tableRemarks}请求体对象")
public class ${tableInfo.className}DTO implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list tableInfo.fieldList as field>
        <#if field.columnName == "id">
    @NotBlank(groups = UpdateGroup.class)
    @Pattern(regexp = "^[0-9]*$")
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