package ${packageName}.controller;

import lombok.RequiredArgsConstructor;
import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}请求控制层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@RestController
@RequestMapping("/${tableInfo.className?uncap_first}")
@Api(tags = "${tableInfo.tableRemarks}管理")
@RequiredArgsConstructor
public class ${tableInfo.className}Controller {

}