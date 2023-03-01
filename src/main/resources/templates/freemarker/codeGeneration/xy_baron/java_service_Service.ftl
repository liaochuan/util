package ${packageName}.service;

import ${packageName}.domain.${tableInfo.className}DomainService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}业务逻辑调用层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Service
@RequiredArgsConstructor
public class ${tableInfo.className}Service {

    private final ${tableInfo.className}DomainService ${tableInfo.className?uncap_first}DomainService;
    
}