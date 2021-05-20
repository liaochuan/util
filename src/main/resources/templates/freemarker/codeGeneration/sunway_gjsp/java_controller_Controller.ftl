package ${packageName}.controller;

import com.sunwayworld.iframework.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import ${packageName}.service.${tableInfo.className}Service;
import ${packageName}.valueobject.${tableInfo.className};

import java.util.List;

/**
 *
 * <p>Title: ${tableInfo.tableRemarks}controller</p>
 *
 * <p>Description: ${tableInfo.tableRemarks}controller</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * <p>Company: www.sunwayworld.com</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Controller
@RequestMapping("${packageName[15..]?replace(".", "/")}")
public class ${tableInfo.className}Controller extends BaseController{

    @Autowired
    public ${tableInfo.className}Service ${tableInfo.className?uncap_first}Service;

    /**
     * 查询详细数据
     * 根据主键查询${tableInfo.tableRemarks}
     * @return detail
     */
    @ResponseBody
    @RequestMapping(value = "/select${tableInfo.className}ById", produces = "application/json;charset=UTF-8")
    public String select${tableInfo.className}ById() {
        ${tableInfo.className} ${tableInfo.className?uncap_first} = this.getParameterBean("${tableInfo.className?uncap_first}", new ${tableInfo.className}());
        return toJSON("${tableInfo.className?uncap_first}", ${tableInfo.className?uncap_first}Service.selectEntityInfoById(${tableInfo.className?uncap_first}));
    }

    /**
     * 查询列表数据
     * @return list
     */
    @ResponseBody
    @RequestMapping(value = "/select${tableInfo.className}ByCond", produces = "application/json;charset=UTF-8")
    public String select${tableInfo.className}ByCond() {
        return toJSON("${tableInfo.className?uncap_first}s", ${tableInfo.className?uncap_first}Service.select${tableInfo.className}ByCond(cond(), page()));
    }

    /**
     * 新增数据
     * @return detail
     */
    @ResponseBody
    @RequestMapping(value = "/insert${tableInfo.className}", produces = "application/json;charset=UTF-8")
    public String insert${tableInfo.className}() {
        ${tableInfo.className} ${tableInfo.className?uncap_first} = this.getParameterBean("${tableInfo.className?uncap_first}", new ${tableInfo.className}());
        return toJSON("${tableInfo.className?uncap_first}", ${tableInfo.className?uncap_first}Service.insertEntityInfo(${tableInfo.className?uncap_first}));
    }

    /**
     * 更新数据
     * @return list
     */
    @ResponseBody
    @RequestMapping(value = "/update${tableInfo.className}s", produces = "application/json;charset=UTF-8")
    public String update${tableInfo.className}s() {
        List<${tableInfo.className}> ${tableInfo.className?uncap_first}s = this.getParameterList("${tableInfo.className?uncap_first}s", new ${tableInfo.className}());
        ${tableInfo.className?uncap_first}Service.updateEntityInfoList(${tableInfo.className?uncap_first}s);
        return toJSON("${tableInfo.className?uncap_first}s", ${tableInfo.className?uncap_first}s);
    }

    /**
     * 保存数据
     * @return list
     */
    @ResponseBody
    @RequestMapping(value = "/save${tableInfo.className}s", produces = "application/json;charset=UTF-8")
    public String saveInnercalibrationInfos() {
        List<${tableInfo.className}> ${tableInfo.className?uncap_first}s = this.getParameterList("${tableInfo.className?uncap_first}s", new ${tableInfo.className}());
        ${tableInfo.className?uncap_first}Service.saveEntityInfoList(${tableInfo.className?uncap_first}s);
        return toJSON("${tableInfo.className?uncap_first}s", ${tableInfo.className?uncap_first}s);
    }

    /**
     * 删除数据
     */
    @ResponseBody
    @RequestMapping(value = "/delete${tableInfo.className}s", produces = "application/json;charset=UTF-8")
    public String delete${tableInfo.className}s() {
        List<${tableInfo.className}> ${tableInfo.className?uncap_first}s = this.getParameterList("${tableInfo.className?uncap_first}s", new ${tableInfo.className}());
        ${tableInfo.className?uncap_first}Service.deleteEntityInfoList(${tableInfo.className?uncap_first}s);
        return success();
    }
}