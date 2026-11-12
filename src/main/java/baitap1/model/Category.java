package baitap1.model;

import java.io.Serializable;

public class Category implements Serializable {
	private static final long serialVersionUID = 1L;

	private int cateid;
	private String catename;
	private String icon;

	public Category() {
	}

	public Category(int cateid, String catename, String icon) {
		this.cateid = cateid;
		this.catename = catename;
		this.icon = icon;
	}

	public Category(String catename, String icon) {
		this.catename = catename;
		this.icon = icon;
	}

	public int getCateid() {
		return cateid;
	}

	public void setCateid(int cateid) {
		this.cateid = cateid;
	}

	public int getCateId() {
		return cateid;
	}

	public void setCateId(int cateid) {
		this.cateid = cateid;
	}

	public int getId() {
		return cateid;
	}

	public void setId(int id) {
		this.cateid = id;
	}

	public String getCatename() {
		return catename;
	}

	public void setCatename(String catename) {
		this.catename = catename;
	}

	public String getCateName() {
		return catename;
	}

	public void setCateName(String catename) {
		this.catename = catename;
	}

	public String getName() {
		return catename;
	}

	public void setName(String name) {
		this.catename = name;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getIcons() {
		return icon;
	}

	public void setIcons(String icons) {
		this.icon = icons;
	}

	@Override
	public String toString() {
		return "Category [cateid=" + cateid + ", catename=" + catename + ", icon=" + icon + "]";
	}
}
