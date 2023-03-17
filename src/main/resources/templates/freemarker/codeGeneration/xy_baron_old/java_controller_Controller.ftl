package ${packageName}.controller;

import ${packageName}.api.${tableInfo.className}Interface;
import ${packageName}.service.${tableInfo.className}Service;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}接口实现层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@RestController
@RequestMapping("/${tableInfo.className?uncap_first}")
@RequiredArgsConstructor
public class ${tableInfo.className}Controller implements ${tableInfo.className}Interface {

    private final ${tableInfo.className}Service ${tableInfo.className?uncap_first}Service;

}