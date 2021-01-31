package org.opensrp.core.entity;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.util.Date;

@Service
@Entity
@Table(name = "branch_projects", schema = "core")
public class BranchProjects {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "branch_projects_id_seq")
    @SequenceGenerator(name = "branch_projects_id_seq", sequenceName = "branch_projects_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "branch_id")
    private Long branchId;

    @Column(name = "project_id")
    private Long projectId;

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

    public Long getBranchId() {
        return branchId;
    }

    public void setBranchId(Long branchId) {
        this.branchId = branchId;
    }

    public Long getProjectId() {
        return projectId;
    }

    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    public Date getCreated() {
        return created;
    }

    public void setCreated(Date created) {
        this.created = created;
    }

    public Date getUpdated() {
        return updated;
    }

    public void setUpdated(Date updated) {
        this.updated = updated;
    }
}
