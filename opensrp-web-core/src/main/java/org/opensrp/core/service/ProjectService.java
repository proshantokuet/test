package org.opensrp.core.service;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.AliasToBeanResultTransformer;
import org.hibernate.type.StandardBasicTypes;
import org.opensrp.common.dto.TimestamReportDTO;
import org.opensrp.common.interfaces.DatabaseRepository;
import org.opensrp.core.dto.ProjectDTO;
import org.opensrp.core.entity.Project;
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
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("description", StandardBasicTypes.STRING)
                .addScalar("projectGroupId", StandardBasicTypes.LONG)
                .setResultTransformer(new AliasToBeanResultTransformer(Project.class));
        return query.list();
    }

    @Transactional
    public List<ProjectDTO> getProjectWithByGroups() {
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


}
