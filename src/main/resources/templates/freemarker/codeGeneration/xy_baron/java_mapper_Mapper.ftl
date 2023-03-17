package ${packageName}.mapper;

import ${packageName}.entity.${tableInfo.className}Entity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}数据访问层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Mapper
public interface ${tableInfo.className}Mapper extends BaseMapper<${tableInfo.className}Entity> {

}