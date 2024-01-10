package ${packageName}.infrastructure.dao.mapper;

import ${packageName}.infrastructure.dao.entity.${tableInfo.className}Entity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

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
public interface ${tableInfo.className}Mapper extends BaseMapper<${tableInfo.className}Entity> {

}