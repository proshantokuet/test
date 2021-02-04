package org.opensrp.core.entity;

import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.io.Serializable;

@Service
@Entity
@Table(name = "project_product", schema = "core")
public class ProjectProduct implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_product_id_seq")
    @SequenceGenerator(name = "project_product_id_seq", sequenceName = "product_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "project_id")
    private Long projectId;

    @Column(name = "product_id")
    private Long productId;

    private Double price;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProjectId() {
        return projectId;
    }

    public void setProjectId(Long projectId) {
        this.projectId = projectId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
