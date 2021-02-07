package org.opensrp.core.service;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToBeanResultTransformer;
import org.hibernate.type.StandardBasicTypes;
import org.opensrp.common.dto.TimestamReportDTO;
import org.opensrp.common.interfaces.DatabaseRepository;
import org.opensrp.core.dto.ProductDTO;
import org.opensrp.core.dto.ProjectDTO;
import org.opensrp.core.entity.Product;
import org.opensrp.core.entity.Project;
import org.opensrp.core.entity.ProjectProduct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class ProjectService extends CommonService{

    private static final Logger logger = Logger.getLogger(TargetService.class);

    @Autowired
    private DatabaseRepository repository;


    public ProjectService() {
    }

    @Transactional
    public <T> T findByKey(String value, String fieldName, Class<?> className) {
        return repository.findByKey(value, fieldName, className);
    }

    @Transactional
    public <T> long saveOb(T t) throws Exception {
        return repository.save(t);
    }

    @Transactional
    public <T> List<T> findAll(String tableClass) {
        return repository.findAll(tableClass);
    }

    @Transactional
    public List<Project> getProjectListByGroupId(Integer projectGroupId ) {
        Session session = getSessionFactory();

        String hql = "select p.*, p.project_group_id projectGroupId from core.project p where p.project_group_id = " + projectGroupId ;
        Query query = session.createSQLQuery(hql)
                .addScalar("id", StandardBasicTypes.LONG)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("description", StandardBasicTypes.STRING)
                .addScalar("projectGroupId", StandardBasicTypes.LONG)
                .setResultTransformer(new AliasToBeanResultTransformer(Project.class));
        return query.list();
    }

    @Transactional
    public List<ProjectDTO> getProjectWithGroups() {
        Session session = getSessionFactory();

        String hql = "select p.*, p.project_group_id projectGroupId, pg.name projectGroupName, pg.code projectGroupCode from core.project p join core.project_group pg on pg.id = p.project_group_id" ;
        Query query = session.createSQLQuery(hql)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("description", StandardBasicTypes.STRING)
                .addScalar("projectGroupName", StandardBasicTypes.STRING)
                .addScalar("projectGroupCode", StandardBasicTypes.STRING)
                .addScalar("projectGroupId", StandardBasicTypes.LONG)
                .addScalar("id", StandardBasicTypes.LONG)
                .setResultTransformer(new AliasToBeanResultTransformer(ProjectDTO.class));
        return query.list();
    }

    @Transactional
    public List<ProductDTO> getGroupWiseProduct(Long projectGroupId) {
        Session session = getSessionFactory();

        String hql = "select * from core.product p where p.projectgroupid = "+projectGroupId ;
        Query query = session.createSQLQuery(hql)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("genericName", StandardBasicTypes.STRING)
                .addScalar("projectGroupId", StandardBasicTypes.LONG)
                .addScalar("id", StandardBasicTypes.LONG)
                .setResultTransformer(new AliasToBeanResultTransformer(ProductDTO.class));
        return query.list();
    }

    @Transactional
    public List<ProjectProduct> getProductsByProject(Long projectId) {
        Session session = getSessionFactory();

        String hql = "select id, product_id productId, project_id projectId, price, product_code productCode from core.project_product p where p.project_id = "+projectId ;
        Query query = session.createSQLQuery(hql)
                .addScalar("productId", StandardBasicTypes.LONG)
                .addScalar("projectId", StandardBasicTypes.LONG)
                .addScalar("price", StandardBasicTypes.DOUBLE)
                .addScalar("productCode", StandardBasicTypes.STRING)
                .addScalar("id", StandardBasicTypes.LONG)
                .setResultTransformer(new AliasToBeanResultTransformer(ProjectProduct.class));
        return query.list();
    }

    @Transactional
    public void saveProjectProducts(List<ProjectProduct> projectProduct) throws Exception {
        if(projectProduct.size() == 0) return;
        Long projectId = projectProduct.get(0).getProjectId();
        System.out.println("project products =====> ");
        System.out.println(projectProduct.get(0));
        Session session = getSessionFactory();
        String hql = "delete from core.project_product where project_id = :projectId ";
        Query query = session.createSQLQuery(hql).setLong("projectId", projectId);
        query.executeUpdate();
        repository.saveAll(projectProduct);
    }


}
