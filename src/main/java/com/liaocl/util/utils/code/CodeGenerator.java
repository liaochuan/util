package com.liaocl.util.utils.code;

import com.liaocl.util.utils.code.entity.Field;
import com.liaocl.util.utils.code.entity.GenerateInfo;
import com.liaocl.util.utils.code.entity.TableInfo;
import com.liaocl.util.utils.common.StringUtils;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.util.ResourceUtils;
import sun.awt.OSInfo;

import java.io.*;
import java.nio.file.Files;
import java.sql.*;
import java.util.*;

/**
 * @author liaocl
 */
@PropertySource(value = {"classpath:properties/code-generator.properties"})
public class CodeGenerator {

    private static final String CUSTOM_FALSE = "0";

    private static final Logger log = LoggerFactory.getLogger(CodeGenerator.class);
    
    /**
     * 获取表中的相关数据
     * @param projectName 项目名称，根据此名称获取配置文件中配置的数据库信息
     * @param tableName 表名
     */
    public TableInfo initTableInfo(String projectName, String tableName) {
        TableInfo tableInfo = new TableInfo();
        tableInfo.setTableName(tableName);
        List<Field> fieldList = new ArrayList<>();
        Connection connection = null;
        ResultSet columnResultSet = null;
        try {
            Properties properties = PropertiesLoaderUtils.loadAllProperties("properties/code-generator.properties");
            Class.forName(properties.getProperty(projectName + ".driverClassName"));
            connection = DriverManager.getConnection(
                    StringUtils.toString(properties.getProperty(projectName + ".url")),
                    properties.getProperty(projectName + ".username"),
                    properties.getProperty(projectName + ".password"));
            DatabaseMetaData databaseMetaData = connection.getMetaData();
            // 获取表注释
            tableInfo.setTableRemarks(getTableComment(connection, tableName));
            String schema = properties.getProperty(projectName + ".schema");
            columnResultSet = databaseMetaData.getColumns(schema, schema, tableName, null);
            // 排除字段
            String[] excludeFields = StringUtils.toString(properties.getProperty(projectName + ".excludeFields")).split(",");
            ArrayList<String> excludeFieldList = new ArrayList<>(Arrays.asList(excludeFields));
            // 表名前缀
            String tablePrefix = StringUtils.toString(properties.getProperty(projectName + ".tablePrefix"));
            tableName = tableName.toLowerCase();
            if (!"".equals(tablePrefix) && tableName.startsWith(tablePrefix)){
                tableName = tableName.substring(tablePrefix.length());
            }
            // 字段去除字段连接符后是否进行驼峰命名，默认是
            String fieldHump = StringUtils.toString(properties.getProperty(projectName + ".fieldHump"));
            LinkedHashSet<String> typeSet = new LinkedHashSet<>();
            while(columnResultSet.next()){
                String columnName = columnResultSet.getString("COLUMN_NAME");
                if (excludeFieldList.contains(columnName)){
                    continue;
                }
                String columnType = columnResultSet.getString("TYPE_NAME");
                String columnRemarks = columnResultSet.getString("REMARKS");
                String javaType = dbTypeToJavaType(columnType);
                if (StringUtils.isEmpty(javaType)) {
                    throw new RuntimeException("java 类型不匹配：" + columnType);
                }
                String packageName = javaTypeToPackage(javaType);
                if (StringUtils.isNotEmpty(packageName)){
                    typeSet.add(packageName);
                }
                Field field = new Field();
                field.setColumnName(columnName);
                field.setFieldName(handleColumnName(columnName,fieldHump));
                field.setFieldType(javaType);
                field.setFieldRemarks(columnRemarks);
                fieldList.add(field);
            }
            tableInfo.setClassName(tableNameToClassName(tableName));
            tableInfo.setFieldList(fieldList);
            tableInfo.setTypeSet(typeSet);
        } catch (Exception e){
            log.error(e.getMessage());
        } finally {
            if (columnResultSet != null){
                try {
                    columnResultSet.close();
                } catch (SQLException throwables) {
                    log.error(throwables.getMessage());
                }
            }
            if (connection != null){
                try {
                    connection.close();
                } catch (SQLException throwables) {
                    log.error(throwables.getMessage());
                }
            }
        }
        return tableInfo;
    }

    /**
     * 获取表注释
     * @param connection 数据库连接
     * @param tableName 表名
     * @return 表注释
     */
    private String getTableComment(Connection connection, String tableName){
        String comment = null;
        Statement statement = null;
        ResultSet tableResultSet = null;
        try {
            statement = connection.createStatement();
            // 获取建表语句以得到表注释
            tableResultSet = statement.executeQuery("SHOW CREATE TABLE " + tableName);
            if (tableResultSet != null && tableResultSet.next()) {
                String createDdl = tableResultSet.getString(2);
                int index = createDdl.indexOf("COMMENT='");
                if (index >= 0) {
                    comment = createDdl.substring(index + 9);
                    comment = comment.substring(0, comment.length() - 1);
                    String suffix = "表";
                    if (StringUtils.isNotEmpty(comment) && comment.endsWith(suffix)){
                        comment = comment.substring(0,comment.length()-1);
                    }
                }
            }
        } catch (SQLException throwables) {
            log.error(throwables.getMessage());
        } finally {
            if (tableResultSet != null){
                try {
                    tableResultSet.close();
                } catch (SQLException throwables) {
                    log.error(throwables.getMessage());
                }
            }
            if (statement != null){
                try {
                    statement.close();
                } catch (SQLException throwables) {
                    log.error(throwables.getMessage());
                }
            }
        }
        return comment;
    }

    /**
     * 数据库类型转java类型
     */
    private String dbTypeToJavaType(String dbType){
        String javaType = null;
        switch (dbType.toUpperCase()){
            case "TEXT":
            case "CHAR":
            case "VARCHAR":
            case "JSON":
            case "LONGTEXT":
                javaType = "String";
                break;
            case "INT":
                javaType = "Integer";
                break;
            case "BIGINT":
                javaType = "Long";
                break;
            case "DATE":
            case "DATETIME":
                javaType = "Date";
                break;
            case "TIMESTAMP":
                javaType = "Instant";
                break;
            case "DECIMAL":
                javaType = "BigDecimal";
                break;
            case "TINYINT":
                javaType = "Byte";
                break;
            default:
                break;
        }
        return javaType;
    }

    /**
     * 针对需要进行导入的java类型转包名
     */
    private String javaTypeToPackage(String javaType){
        String packageName = null;
        switch (javaType){
            case "Date":
                packageName = "java.util.Date";
                break;
            case "Instant":
                packageName = "java.time.Instant";
                break;
            case "BigDecimal":
                packageName = "java.math.BigDecimal";
                break;
            default:
                break;
        }
        return packageName;
    }

    /**
     * 首字母变大写
     */
    private String firstLetterToUpperCase(String src){
        return src.substring(0,1).toUpperCase()+src.substring(1);
    }

    /**
     * 表名转类名
     */
    private String tableNameToClassName(String tableName){
        StringBuilder sb = new StringBuilder();
        String[] items = tableName.split("_");
        for (String item : items){
            sb.append(firstLetterToUpperCase(item));
        }
        return sb.toString();
    }

    /**
     * 列名处理
     * @param columnName 字段在数据库中的列名
     * @param fieldHump 字段去除字段连接符后是否进行驼峰命名
     */
    private String handleColumnName(String columnName, String fieldHump){
        if (CUSTOM_FALSE.equals(fieldHump)){
            return columnName.replace("_", "");
        } else {
            StringBuilder sb = new StringBuilder();
            String[] items = columnName.split("_");
            sb.append(items[0]);
            for (int i = 1,len = items.length; i < len; i++) {
                sb.append(firstLetterToUpperCase(items[i]));
            }
            return sb.toString();
        }
    }

    /**
     * 生成代码
     * @param generateInfo 代码生成信息
     */
    public void execute(GenerateInfo generateInfo){
        String projectName = generateInfo.getProjectName();
        Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        try {
            log.debug("代码生成开始");
            String path = ResourceUtils.getFile("classpath:templates/freemarker/codeGeneration/"+projectName).getPath();
            configuration.setDirectoryForTemplateLoading(new File(path));
            File templateFiles = new File(path);
            File[] templateFileList = templateFiles.listFiles();
            if (templateFileList == null) {
                return;
            }
            path = StringUtils.isEmpty(generateInfo.getFilePath()) ?
                    Objects.requireNonNull(this.getClass().getResource("/")).getPath().substring(1) + "CodeGenerator"
                    : generateInfo.getFilePath();
            String fileSeparator = File.separator;
            if (generateInfo.isPathByPackage()){
                path += fileSeparator + generateInfo.getPackageName().replace(".", fileSeparator);
            }
            File dir = new File(path);
            if (!dir.exists() && dir.mkdirs()) {
                log.debug("创建目录： [{}]", path);
            } else if (generateInfo.isDeleteOld()) {
                Scanner scanner = new Scanner(System.in);
                System.out.println("===========输入Y以进行确认删除原文件目录===========");
                String in = scanner.nextLine().toUpperCase();
                if ("Y".equals(in)) {
                    System.out.println("===========已确认===========");
                    FileUtils.deleteDirectory(dir);
                    log.debug("删除原有目录： [{}]", path);
                    if (dir.mkdirs()){
                        log.debug("创建目录： [{}]", path);
                    }
                } else {
                    System.out.println("===========未确认，程序退出===========");
                    return;
                }
            }
            //数据
            Map<String,Object> data = new HashMap<>(1);
            TableInfo tableInfo = initTableInfo(projectName,generateInfo.getTableName());
            data.put("tableInfo",tableInfo);
            data.put("author",generateInfo.getAuthor());
            data.put("packageName",generateInfo.getPackageName());
            for (File templateFile : templateFileList) {
                String fileName = templateFile.getName();
                // 模板文件命名规则：文件类型_子包名（多层级以.分割）_文件名补充
                String[] fileInfos = fileName.substring(0, fileName.indexOf(".ftl")).split("_");
                if (fileInfos.length > 1){
                    Template template = configuration.getTemplate(fileName);
                    String name = fileInfos.length > 2 ? tableInfo.getClassName()+fileInfos[2] : tableInfo.getClassName();
                    String newPath = path;
                    if (generateInfo.isPathByPackage()){
                        newPath += fileSeparator + fileInfos[1].replace(".", fileSeparator);
                    }
                    File tempDir = new File(newPath);
                    if (!tempDir.exists() && tempDir.mkdirs()) {
                        log.debug("创建目录： [{}]", newPath);
                    }
                    File targetFile = new File(newPath + fileSeparator + name + "." + fileInfos[0]);
                    if (!targetFile.exists() && targetFile.createNewFile()) {
                        log.debug("创建文件： [{}]", targetFile.getAbsolutePath());
                    } else if (targetFile.delete() && targetFile.createNewFile()) {
                        log.debug("替换文件： [{}]", targetFile.getAbsolutePath());
                    }
                    Writer writer = new OutputStreamWriter(Files.newOutputStream(targetFile.toPath()));
                    template.process(data,writer);
                }
            }
            log.debug("代码生成结束");
            // 打开文件夹
            if (OSInfo.OSType.WINDOWS.equals(OSInfo.getOSType())){
                Runtime.getRuntime().exec("explorer.exe /select," + path.replace("/", "\\"));
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("===========输入Y以进行确认生成===========");
        String in = scanner.nextLine().toUpperCase();
        if ("Y".equals(in)) {
            System.out.println("===========已确认，正在生成中===========");
            String tables = "user";
            GenerateInfo generateInfo = new GenerateInfo();
            generateInfo.setProjectName("xy_ad");
            generateInfo.setAuthor("mozhu");
            generateInfo.setPackageName("com.xy.ad.alliance");
            generateInfo.setPathByPackage(true);
            generateInfo.setDeleteOld(false);
            generateInfo.setFilePath("./code");
//            generateInfo.setDeleteOld(false);
//            generateInfo.setFilePath("/Users/mozhu/IdeaProjects/baron/baron-plate/baron-plate-modules/baron-plate-account/src/main/java");
            CodeGenerator codeGenerator = new CodeGenerator();
            for (String table : tables.split(",")) {
                generateInfo.setTableName(table);
                codeGenerator.execute(generateInfo);
            }
        } else {
            System.out.println("===========未确认，程序退出===========");
        }
    }
}