package org.opensrp.core.service.mapper;

import java.util.ArrayList;
import java.util.List;

import org.opensrp.core.dto.ProjectDTO;
import org.opensrp.core.entity.Project;
import org.springframework.stereotype.Service;

@Service
public class ProjectMapper {

    /**
     * DTO to Entity
     *
     * @param projectDTO
     * @return
     */
    public Project map(ProjectDTO projectDTO) {
        Project project = new Project();
        if (projectDTO.getId() != 0)
            project.setId(projectDTO.getId());
        project.setCode(projectDTO.getCode());
        project.setName(projectDTO.getName());
        project.setDescription(projectDTO.getDescription());
        project.setProjectGroupId(projectDTO.getProjectGroupId());
        return project;
    }

    /**
     * DTO's to Entities
     *
     * @param dtos
     * @return
     */
    public List<Project> map(List<ProjectDTO> dtos) {
        List<Project> entities = new ArrayList<>();

        dtos.forEach(dto -> entities.add(this.map(dto)));

        return entities;
    }

    /**
     * Entity to DTO
     *
     * @param project
     * @return
     */
    public ProjectDTO map(Project project) {
        ProjectDTO projectDTO = new ProjectDTO();
        projectDTO.setId(project.getId());
        projectDTO.setCode(project.getCode());
        projectDTO.setName(project.getName());
        projectDTO.setDescription(projectDTO.getDescription());
        projectDTO.setProjectGroupId(project.getProjectGroupId());
        return projectDTO;
    }
}
