package ${packageName}.service.impl;

import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${packageName}.entity.${tableInfo.className}Entity;
import ${packageName}.mapper.${tableInfo.className}Mapper;
import ${packageName}.service.${tableInfo.className}Service;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}业务逻辑层实现类</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Service
public class ${tableInfo.className}ServiceImpl extends ServiceImpl<${tableInfo.className}Mapper, ${tableInfo.className}Entity> implements ${tableInfo.className}Service {

}