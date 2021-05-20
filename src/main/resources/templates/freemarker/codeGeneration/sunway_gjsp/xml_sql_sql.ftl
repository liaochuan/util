<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${packageName}.sql">

    <select id="select${tableInfo.className}ByCond" parameterType="java.util.Map"
            resultType="com.sunwayworld.iframework.bean.ExtendBean">
        SELECT T.* FROM ${tableInfo.tableName} T
        <where>
            <include refid="${packageName}.SQLCOND${tableInfo.className}" />
            <include refid="${packageName}.sql.${tableInfo.className?lower_case}_keywords"/>
        </where>
    </select>

    <!-- ${tableInfo.tableRemarks}全局搜索 -->
    <sql id="${tableInfo.className?lower_case}_keywords">
        <if test='keywords != null and keywords != ""'>
            and (
            T.recorderdesc LIKE ${"#"}{keywords}
            OR date_format( T.recordtime, '%Y-%m-%d' ) LIKE ${"#"}{keywords}
            )
        </if>
    </sql>
</mapper>