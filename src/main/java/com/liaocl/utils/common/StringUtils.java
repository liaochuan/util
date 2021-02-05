package com.liaocl.utils.common;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Pattern;

/**
 * 
 * String 工具类
 * 
 * Description: 字符串处理,格式转换等操作
 * 
 */
public class StringUtils {
	
	/**
	 * 判断当前字符串中是否包含汉字 或全角字符 
	 * @param obj
	 * @return
	 */
	public static boolean hasChineseWord(Object obj)
    {
		String s=StringUtils.toString(obj);
        s = s.replaceAll("[^\\x00-\\xff]", "***");
        if (s.length()>StringUtils.toString(obj).length()) {
        	return true;
		}
        return false;
    }

	public static long parseLong(String str) {
		try {
			return Long.parseLong(str);
		} catch (Exception ex) {
			return 0L;
		}
	}

	public static int parseInt(String str) {
		try {

			return Integer.parseInt(str);
		} catch (Exception ex) {
			return 0;
		}
	}

	public static int parseInt(String str, int i) {
		try {
			return Integer.parseInt(str);
		} catch (Exception ex) {
			return i;
		}
	}

	public static double parseDouble(String str) {
		try {
			return Double.parseDouble(str);
		} catch (Exception ex) {
			return 0;
		}
	}

	public static String toString(Object obj) {
		if (obj == null) {
			return "";
		}
		if (obj.getClass().getName().equals("java.lang.String")) {
			return toString((String) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Integer")) {
			return toString((Integer) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Long")) {
			return toString((Long) obj).trim();
		}
		if (obj.getClass().getName().equals("java.sql.Date")) {
			return toString((Date) obj).trim();
		}
		if (obj.getClass().getName().equals("java.util.Date")) {
			return toString((java.util.Date) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Float")) {
			return toString((Float) obj).trim();
		}
		if (obj.getClass().getName().equals("java.sql.Timestamp")) {
			return toString((Timestamp) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Double")) {
			return toString((Double) obj).trim();
		}
		return obj.toString().trim();
	}

	// 字符串 不启用trim
	public static String toString_alias(Object obj) {
		if (obj == null) {
			return "";
		}
		if (obj.getClass().getName().equals("java.lang.String")) {
			return toString((String) obj);
		}
		if (obj.getClass().getName().equals("java.lang.Integer")) {
			return toString((Integer) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Long")) {
			return toString((Long) obj).trim();
		}
		if (obj.getClass().getName().equals("java.sql.Date")) {
			return toString((Date) obj).trim();
		}
		if (obj.getClass().getName().equals("java.util.Date")) {
			return toString((java.util.Date) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Float")) {
			return toString((Float) obj).trim();
		}
		if (obj.getClass().getName().equals("java.sql.Timestamp")) {
			return toString((Timestamp) obj).trim();
		}
		if (obj.getClass().getName().equals("java.lang.Double")) {
			return toString((Double) obj).trim();
		}
		return obj.toString();
	}

	public static String toCSV(Object obj) {
		String str = toString(obj);
		return str.replaceAll("\"", "\"\"").replaceAll("\n", "")
				.replaceAll("\r", "");
	}

	public static String toString(int obj) {
		return String.valueOf(obj);
	}

	public static String toString(long obj) {
		return String.valueOf(obj);
	}

	public static String toString(double obj) {
		return String.valueOf(obj);
	}

	public static String toString(float obj) {
		return String.valueOf(obj);
	}

	public static String toString(boolean obj) {
		return String.valueOf(obj);
	}

	public static String toString(char obj) {
		return String.valueOf(obj);
	}

	private static String toString(String obj) {
		if (obj == null) {
			return "";
		}
		return obj;
	}

	private static String toString(Integer obj) {
		if (obj == null) {
			return "";
		}
		return obj.toString();
	}

	private static String toString(Long obj) {
		if (obj == null) {
			return "";
		}
		return obj.toString();
	}

	private static String toString(Date obj) {
		if (obj == null) {
			return "";
		}
		DateFormat dftime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		String str = dftime.format(obj);
		if (str.indexOf("00:00:00") < 0) {
			return str;
		} else {
			DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
			return df.format(obj);
		}
	}

	private static String toString(Double obj) {
		if (obj == null) {
			return "";
		}
		return obj.doubleValue() + "";
	}

	private static String toString(Float obj) {
		if (obj == null) {
			return "";
		}
		return obj.toString();
	}

	private static String toString(Timestamp obj) {
		if (obj == null) {
			return "";
		}
		return obj.toString();
	}

	private static String toString(java.util.Date obj) {
		if (obj == null) {
			return "";
		}
		return getDateString(obj);
	}

	private static String getDateString(java.util.Date adate) {
		if (adate == null) {
			return "";
		}
		DateFormat dftime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		String str = dftime.format(adate);
		if (str.indexOf("00:00:00") < 0) {
			return str;
		} else {
			DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
			return df.format(adate);
		}
	}

	/**
	 * 在 source 后边填充 target 总长len (target 单字符)
	 * 
	 * @param source
	 * @param target
	 * @param len
	 * @return
	 */
	public static String fillAfter(String source, String target, int len) {
		StringBuffer bf = new StringBuffer(len);
		for (int i = 0; i < len; i++) {
			bf.append(target);
		}
		String temp = bf.toString();
		temp = temp.substring(source.length(), len);
		return source + temp;
	}

	/**
	 * 在 source 前边填充 target (target 单字符),填充完后总长度为len
	 * 
	 * @param source
	 * @param target
	 * @param len
	 * @return
	 */
	public static String fillBefore(String source, String target, int len) {
		StringBuffer bf = new StringBuffer(len);
		for (int i = 0; i < len; i++) {
			bf.append(target);
		}
		String temp = bf.toString();
		temp = temp.substring(0, len - source.length());
		return temp + source;
	}

	public static String tofirstUpperCase(String source, int index) {
		String temp = source.substring(0, index);
		source = temp.toUpperCase() + source.substring(index, source.length());
		return source;
	}

	public static String toOnlyfirstUpperCase(String source, int index) {
		String temp = source.substring(0, index);
		source = temp.toUpperCase()
				+ source.substring(index, source.length()).toLowerCase();
		return source;
	}

	public static String tofirstLowerCase(String source, int index) {
		String temp = source.substring(0, index);
		source = temp.toLowerCase() + source.substring(index, source.length());
		return source;
	}

	public static boolean isEmpty(String str) {
		return "".equals(StringUtils.toString(str));
	}

	public static boolean isNotEmpty(String str) {
		return !"".equals(StringUtils.toString(str));
	}

	public static boolean isNumber(String str) {
		if (str == null) {
			return true;
		}
		String regExp = "^(-|\\+)?\\d+(\\.\\d+)?$";
		Pattern pattern = Pattern.compile(regExp);
		return pattern.matcher(str).matches();
	}

	/**
	 * 去除字符串数组中重复的值
	 * 
	 * @param String
	 * @return String [] str 例如：source: a,b,c,d,a String [] str: [a,b,c,d]
	 */
	public static String[] removeRepeatString(String source) {
		String[] target = source.split(",");
		Set<String> set = new TreeSet<String>();
		for (int i = 0; i < target.length; i++) {
			set.add(target[i]);
		}
		target = (String[]) set.toArray(new String[0]);
		return target;
	}

	/**
	 * 判断Key是否存在与数组中
	 * 
	 * @param htmlStr
	 * @return
	 */
	public static boolean isInclude(String[] keys, String key) {
		for (String _key : keys) {
			if (_key.equals(key)) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 将list按照一个分割符拼接到字符串后面
	 * @param data
	 * @param list
	 * @param splite
	 * @return
	 */
	public static String appendString(String data,List<String> list, String splite){
		StringBuffer sbBuffer = new StringBuffer(2048);
		sbBuffer.append(data);
		if(list != null){
			for (String str : list) {
				if(StringUtils.isNotEmpty(str)){
					sbBuffer.append(str + splite);
				}
			}
		}
		return sbBuffer.toString();
	}

	/**
	 * 使用分隔符连接字符串列表
	 * @param list 字符列表
	 * @param split 分隔符，默认逗号
	 */
	public static String join(List<String> list, String split) {
		split = (split == null) ? "," : split;
		String result = "";
		boolean flag = false;
		if (list != null && list.size() > 0) {
			java.util.Collections.sort(list);
			String last = "";
			for (String str : list) {
				if(isNotEmpty(str) && !last.equals(str)) {
					flag = true;
					last = str;
					result = result + split + str;
				}
			}
			if(flag) {
				return result.substring(split.length());
			}
		}
		return result;
	}
    
    /**
     * 扩展{@link String#trim()}方法，删除开头和结尾的空格、回车、水平制表符、换行等都要去掉
     *
     * @param target 目标{@link String}
     * @return 替换后新的字符串
     */
    public static final String trim(final String target) {
        if (target == null)
            return null;

        char[] chars = target.toCharArray();

        int start = 0;
        int end = chars.length;

        for (char c : chars) {
            if (Character.isWhitespace(c)) {
                start++;
            } else {
                break;
            }
        }

        for (int i = chars.length - 1; i > 0; i--) {
            if (Character.isWhitespace(chars[i])) {
                end--;
            } else {
                break;
            }
        }

        if (end > start) {
            return String.copyValueOf(chars, start, end - start);
        } else {
            return "";
        }
    }

}
