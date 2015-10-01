package com.railtech.po.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.railtech.po.entity.FlexiBean;

public class Util {

	public static Date getDate(String strDate, String format) {
		SimpleDateFormat formatter;
		
		try {
			formatter = new SimpleDateFormat(format);
			return formatter.parse(strDate);
			
		} catch (ParseException e) {
			System.out.println("Exception :" + e);
		}
		return null;
	}

	public static String getDateString(Date date, String format){
		SimpleDateFormat formatter = new SimpleDateFormat(format);
			System.out.println(date);
			String dateString  = formatter.format(date);
			System.out.println(dateString);
			return dateString;
		
	}
	public static String getFormattedDate(String sourceFormat, String strDate,
			String targetFormat) {

		if (strDate == null || "".equals(strDate.trim())) {
			return strDate;
		}
		try {
			// create SimpleDateFormat object with source string date format
			if (sourceFormat == null) {
				sourceFormat = "yyyy-MM-dd";
			}
			SimpleDateFormat sdfSource = new SimpleDateFormat(sourceFormat);

			// parse the string into Date object
			Date dtdate = sdfSource.parse(strDate);

			// create SimpleDateFormat object with desired date format
			SimpleDateFormat sdfDestination = new SimpleDateFormat(targetFormat);

			// parse the date into another format
			strDate = sdfDestination.format(dtdate);

			System.out
					.println("Date is converted from dd/MM/yy format to MM-dd-yyyy hh:mm:ss");
			System.out.println("Converted date is : " + strDate);

		} catch (ParseException pe) {
			System.out.println("Parse Exception : " + pe);
		}
		return strDate;

	}

	public static String replaceNull(String str) {
		String returnStr = null;
		if (null == str || "null".equals(str)) {
			returnStr = "";
		} else {
			returnStr = str;
		}
		return returnStr;
	}

	public static Double replaceNull(Double val) {
		Double returnStr = null;
		if (null == val || "null".equals(val)) {
			returnStr = 0.0;
		} else {
			returnStr = val;
		}
		return returnStr;
	}

	public static String replaceNull(String str, String replacmentStr) {
		if (null == str || "".equals(str.trim()) || "null".equals(str.trim())) {
			return replacmentStr;
		} else {
			return str;
		}
	}
	
	public static String replaceNull(Integer val, String replacmentStr) {
		if (null == val ) {
			return replacmentStr;
		} else {
			return val.toString();
		}
	}

	public static String getFlexiQuery(String basicSQL, String whereClause,
			String sortOrder, String limitClause) {
		String sql = basicSQL;
		String clause = " WHERE ";
		if (null != whereClause && whereClause.trim().length() > 0) {
			sql += " WHERE " + whereClause;
			clause = " AND ";
		}
		if (null != limitClause && limitClause.length() > 0) {

			sql += clause + limitClause;
		}
		if (null != sortOrder && sortOrder.length() > 0) {
			sql += " " + sortOrder;
		}
		System.out.println(sql);
		return sql;
	}

	/*
	 * Writes the flexigrid output
	 */
	public static void doWriteFlexi(HttpServletRequest request,
			HttpServletResponse response, Map<String, List<String>> strMap,
			FlexiBean flexi) throws IOException {

		try {
			JSONArray jArray = new JSONArray();
			for (String key : strMap.keySet()) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("id", key);
				jsonObj.put("cell", strMap.get(key));

				jArray.put(jsonObj);
			}
			JSONObject jObj = new JSONObject();
			jObj.put("page", flexi.getPage());
			jObj.put("total", strMap.size());
			jObj.put("rows", jArray);

			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			out.println(jObj);
			out.close();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static Boolean returnBoolean(String parameter, boolean defaultValue) {
		parameter = Util.replaceNull(parameter);
		if("".equals(parameter)){
			return defaultValue;
		}else if("Y".equalsIgnoreCase(parameter) || "Yes".equalsIgnoreCase(parameter) 
				|| "T".equalsIgnoreCase(parameter)|| "True".equalsIgnoreCase(parameter)  ){
			return true;
		}
		return false;
	
	}
	
	public static void writeAjaxOutput(HttpServletResponse response, String result) throws IOException{
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-store, no-cache");
		response.getWriter().write(result);
	}
	
	/*public static OutputStream writePDF(String pdfString, OutputStream os){
		try {
            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocumentFromString(pdfString);
            renderer.layout();
            renderer.createPDF(os);
            return os;
            //os.flush();
            //os.close();
            //os = null;
        } catch (DocumentException e) {
			e.printStackTrace();
		} finally {
            if (os != null) {
                try {
                    os.close();
                } catch (IOException e) {
                    // ignore
                }
            }
        }
		return os;
		
	}
	public static String getCurrencyInWords(Double num){
		 AmountInWords obj=new AmountInWords();
	     String val = StringUtils.replace(num.toString(),".00","");
	     val = StringUtils.replace(num.toString(),".0","");
	     if(val.indexOf(".")!=-1){
	    	 String decimalNum[]=val.split(".");
	    	val= obj.convertToWords(Integer.parseInt(decimalNum[0]));
	    	val+=" and ";
	    	val+= obj.convertToWords(Integer.parseInt(decimalNum[1]));
	    	val+=" Paise";
	    	 
	     }
	     else {
	    	 val= obj.convertToWords(Integer.parseInt(val));
	     }
	     return "Rupees "+val+ " Only";
	}*/
}
