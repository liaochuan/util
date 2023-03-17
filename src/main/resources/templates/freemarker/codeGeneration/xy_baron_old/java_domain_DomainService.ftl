package ${packageName}.domain;

import ${packageName}.repository.${tableInfo.className}Repository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}领域业务逻辑实现类</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Service
@RequiredArgsConstructor
public class ${tableInfo.className}DomainService {

    private final ${tableInfo.className}Repository ${tableInfo.className?uncap_first}Repository;

}