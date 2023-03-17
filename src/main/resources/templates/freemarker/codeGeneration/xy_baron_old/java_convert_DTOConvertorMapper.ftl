package ${packageName}.convertor;

import com.baron.base.request.PageReq;
import com.baron.base.response.PageResp;
import com.baron.mapstrcut.BaseDTOMapStruct;
import com.baron.mapstrcut.EpochMillisConvertorMapper;
import com.baron.mapstrcut.ObjectConvertorMapper;
import ${packageName}.dto.req.${tableInfo.className}ModifyDTO;
import ${packageName}.dto.req.${tableInfo.className}QueryDTO;
import ${packageName}.entity.${tableInfo.className}Entity;
import ${packageName}.entity.${tableInfo.className}QueryEntity;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}dto与entity转换</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Mapper(uses = {ObjectConvertorMapper.class, EpochMillisConvertorMapper.class},
        unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE,
        collectionMappingStrategy = CollectionMappingStrategy.ADDER_PREFERRED,
        builder = @Builder(disableBuilder = true)
)
public interface ${tableInfo.className}DTOConvertorMapper extends BaseDTOMapStruct<${tableInfo.className}ModifyDTO, ${tableInfo.className}Entity> {

    ${tableInfo.className}DTOConvertorMapper INSTANCE = Mappers.getMapper(${tableInfo.className}DTOConvertorMapper.class);

    PageReq<${tableInfo.className}QueryEntity> req2page(PageReq<${tableInfo.className}QueryDTO> dtoReq);

    ${tableInfo.className}QueryEntity queryDto2entity(${tableInfo.className}QueryDTO dto);

    PageResp<${tableInfo.className}ModifyDTO> page2resp(PageResp<${tableInfo.className}Entity> page);
}