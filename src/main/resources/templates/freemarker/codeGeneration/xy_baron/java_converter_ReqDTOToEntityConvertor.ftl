package ${packageName}.converter;

import com.baron.common.core.mapstrcut.BaseDTOMapStruct;
import com.baron.common.core.mapstrcut.ObjectConvertorMapper;
import ${packageName}.api.dto.req.${tableInfo.className}ReqDTO;
import ${packageName}.entity.${tableInfo.className}Entity;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

 /**
  *
  * <p>Description: ${tableInfo.tableRemarks}数据库实体和请求体DTO转换工具类</p>
  *
  * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
  *
  * @author ${author}
  * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
  * @version 1.0
  */
@Mapper(uses = {ObjectConvertorMapper.class},
        unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE,
        collectionMappingStrategy = CollectionMappingStrategy.ADDER_PREFERRED,
        builder = @Builder(disableBuilder = true)
)
public interface ${tableInfo.className}ReqDTOToEntityConvertor extends BaseDTOMapStruct<${tableInfo.className}ReqDTO, ${tableInfo.className}Entity> {

    ${tableInfo.className}ReqDTOToEntityConvertor INSTANCE = Mappers.getMapper(${tableInfo.className}ReqDTOToEntityConvertor.class);

}