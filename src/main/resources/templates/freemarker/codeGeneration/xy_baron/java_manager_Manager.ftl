package ${packageName}.manager;

import com.baomidou.mybatisplus.extension.service.IService;
import ${packageName}.entity.${tableInfo.className}Entity;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}综合业务层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
public interface ${tableInfo.className}Manager extends IService<${tableInfo.className}Entity> {
    
}