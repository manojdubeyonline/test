/**
 * 
 */
package com.railtech.po.entity;

import javax.servlet.http.HttpServletRequest;

import com.railtech.po.util.Util;

/**
 * @author Administrator
 * 
 */
public class FlexiBean {
	int page;
	String sortname;
	String sortorder;
	String qtype;
	String query;
	int rp;
	String searchSql;
	String sortSql;
	String limitSql;
	
	public FlexiBean(HttpServletRequest request) {
		page = Integer.parseInt(Util.replaceNull(request.getParameter("page"),	"1"));
		
		sortname = Util.replaceNull(request.getParameter("sortname"), "");
		
		sortorder = Util.replaceNull(request.getParameter("sortorder"), "desc");
		
		qtype = Util.replaceNull(request.getParameter("qtype"));
		
		query = Util.replaceNull(request.getParameter("query"));
		
		rp = Integer.parseInt(Util.replaceNull(request.getParameter("rp"), "1000"));
		
		int pageStart = (page - 1) * rp;
		
		if (!"".equals(Util.replaceNull(sortname.trim())) && !"".equals(Util.replaceNull(sortorder.trim()))) {
			sortSql = " order by " + sortname + " " + sortorder;
		}

		if (!"".equals(Util.replaceNull(qtype.trim())) && !"".equals(Util.replaceNull(query.trim()))) {
			searchSql = " " + Util.replaceNull(qtype) + " = '" + Util.replaceNull(query)+"'";
		}
		limitSql = " ROW_NM between " + pageStart + " AND " + rp;
	}

	/**
	 * @return the page
	 */
	public int getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(int page) {
		this.page = page;
	}
	/**
	 * @return the sortname
	 */
	public String getSortname() {
		return Util.replaceNull(sortname);
	}
	/**
	 * @param sortname the sortname to set
	 */
	public void setSortname(String sortname) {
		this.sortname = sortname;
	}
	/**
	 * @return the sortorder
	 */
	public String getSortorder() {
		return Util.replaceNull(sortorder);
	}
	/**
	 * @param sortorder the sortorder to set
	 */
	public void setSortorder(String sortorder) {
		this.sortorder = sortorder;
	}
	/**
	 * @return the qtype
	 */
	public String getQtype() {
		return Util.replaceNull(qtype);
	}
	/**
	 * @param qtype the qtype to set
	 */
	public void setQtype(String qtype) {
		this.qtype = qtype;
	}
	/**
	 * @return the query
	 */
	public String getQuery() {
		return Util.replaceNull(query);
	}
	/**
	 * @param query the query to set
	 */
	public void setQuery(String query) {
		this.query = query;
	}
	/**
	 * @return the rp
	 */
	public int getRp() {
		return rp;
	}
	/**
	 * @param rp the rp to set
	 */
	public void setRp(int rp) {
		this.rp = rp;
	}
	/**
	 * @return the searchSql
	 */
	public String getSearchSql() {
		return Util.replaceNull(searchSql);
	}
	/**
	 * @param searchSql the searchSql to set
	 */
	public void setSearchSql(String searchSql) {
		this.searchSql = searchSql;
	}
	/**
	 * @return the sortSql
	 */
	public String getSortSql() {
		return Util.replaceNull(sortSql);
	}
	/**
	 * @param sortSql the sortSql to set
	 */
	public void setSortSql(String sortSql) {
		this.sortSql = sortSql;
	}
	/**
	 * @return the limitSql
	 */
	public String getLimitSql() {
		return Util.replaceNull(limitSql);
	}
	/**
	 * @param limitSql the limitSql to set
	 */
	public void setLimitSql(String limitSql) {
		this.limitSql = limitSql;
	}
	

}
