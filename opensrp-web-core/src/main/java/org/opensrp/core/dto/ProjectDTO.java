package org.opensrp.core.dto;


import com.fasterxml.jackson.annotation.JsonProperty;

public class ProjectDTO {

    private Long id;

    private String name;

    private String code;

    private String description;

    @JsonProperty("project_group_id")
    private Long projectGroupId;

    @JsonProperty("project_group_name")
    private  String projectGroupName;

    @JsonProperty("project_group_code")
    private  String projectGroupCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getProjectGroupId() {
        return projectGroupId;
    }

    public void setProjectGroupId(Long projectGroupId) {
        this.projectGroupId = projectGroupId;
    }
}
