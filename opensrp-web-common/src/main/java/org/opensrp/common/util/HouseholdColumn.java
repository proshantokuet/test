package org.opensrp.common.util;

public enum HouseholdColumn {
	_0(""), _3("number_Of_member"), _2("registration_date"), _4("last_visit_date");
	
	private String value;
	
	HouseholdColumn(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
	
}