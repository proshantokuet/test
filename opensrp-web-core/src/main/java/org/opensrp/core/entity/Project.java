package org.opensrp.core.entity;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.util.Date;

@Service
@Entity
@Table(name = "project", schema = "core")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "_project_id_seq")
    @SequenceGenerator(name = "_project_id_seq", sequenceName = "_project_id_seq", allocationSize = 1)
    private Long id;

    private String name;

    private String code;

    private String description;

    @Column(name = "project_group_id")
    private Long projectGroupId;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", updatable = false)
    @CreationTimestamp
    private Date created = new Date();

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_date", insertable = true, updatable = true)
    @UpdateTimestamp
    private Date updated = new Date();

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
