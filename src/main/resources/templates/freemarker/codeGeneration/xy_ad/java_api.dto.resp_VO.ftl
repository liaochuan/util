package ${packageName}.api.dto.resp;

import io.swagger.v3.oas.annotations.media.Schema;
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
@Schema(description = "${tableInfo.tableRemarks}响应体对象")
public class ${tableInfo.className}VO implements Serializable {

    private static final long serialVersionUID = 1L;

    <#list tableInfo.fieldList as field>
        <#if field.columnName == "id">
    @Schema(description = "主键id")
    private String id;
        <#else>
            <#if field.fieldRemarks != "">
    @Schema(description = "${field.fieldRemarks}")
            </#if>
    private ${field.fieldType} ${field.fieldName};
        </#if>

    </#list>
}