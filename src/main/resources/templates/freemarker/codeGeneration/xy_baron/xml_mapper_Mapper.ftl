<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.mapper.${tableInfo.className}Mapper">

  <resultMap id="baseResultMap" type="${packageName}.entity.${tableInfo.className}Entity">
<#list tableInfo.fieldList as field>
    <#if field.columnName == "id">
    <id column="id" property="id" />
    <#else>
    <result column="${field.columnName}" property="${field.fieldName}"/>
     </#if>
</#list>
  </resultMap>

</mapper>