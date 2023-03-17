package ${packageName}.repository;

import ${packageName}.po.${tableInfo.className}PO;
import ${packageName}.mapper.${tableInfo.className}POMapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}业务层实现类</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Service
@RequiredArgsConstructor
public class ${tableInfo.className}RepositoryImpl extends ServiceImpl<${tableInfo.className}POMapper, ${tableInfo.className}PO> implements ${tableInfo.className}Repository {

}