package ${packageName}.valueobject;

import com.sunwayworld.iframework.bean.BaseInfo;

import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Entity;

<#list tableInfo.typeSet as type>
import ${type};
</#list>

/**
 *
 * <p>Title: ${tableInfo.tableRemarks}表</p>
 *
 * <p>Description: ${tableInfo.tableRemarks}表</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * <p>Company: www.sunwayworld.com</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Entity
@Table(name="${tableInfo.tableName}")
public class ${tableInfo.className} extends BaseInfo {

	private static final long serialVersionUID = 1L;

    <#list tableInfo.fieldList as field>
        <#if field.fieldRemarks != "">
    /**
     * ${field.fieldRemarks}
     */
        </#if>
    private ${field.fieldType} ${field.fieldName};

    </#list>
	@Id
    <#list tableInfo.fieldList as field>
    @Column
    public ${field.fieldType} get${field.fieldName?cap_first}(){
        return ${field.fieldName};
    }

    public void set${field.fieldName?cap_first}(${field.fieldType} ${field.fieldName}){
        this.${field.fieldName} = ${field.fieldName};
    }

    </#list>
}