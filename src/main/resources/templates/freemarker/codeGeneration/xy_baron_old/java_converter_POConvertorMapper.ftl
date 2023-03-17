package ${packageName}.convertor;

import com.baron.mapstrcut.BasePOMapStruct;
import com.baron.mapstrcut.EpochMillisConvertorMapper;
import com.baron.mapstrcut.ObjectConvertorMapper;
import ${packageName}.entity.${tableInfo.className}Entity;
import ${packageName}.po.${tableInfo.className}PO;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}PO与entity转换</p>
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
        collectionMappingStrategy = CollectionMappingStrategy.ADDER_PREFERRED
)
public interface ${tableInfo.className}POConvertorMapper extends BasePOMapStruct<${tableInfo.className}PO, ${tableInfo.className}Entity> {

    ${tableInfo.className}POConvertorMapper INSTANCE = Mappers.getMapper(${tableInfo.className}POConvertorMapper.class);

}