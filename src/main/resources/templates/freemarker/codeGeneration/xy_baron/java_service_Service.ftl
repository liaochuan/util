package ${packageName}.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ${packageName}.entity.${tableInfo.className}Entity;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}业务逻辑层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
public interface ${tableInfo.className}Service extends IService<${tableInfo.className}Entity> {
    
}