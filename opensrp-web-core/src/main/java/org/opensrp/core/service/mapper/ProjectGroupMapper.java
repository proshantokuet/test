package org.opensrp.core.service.mapper;

import java.util.ArrayList;
import java.util.List;

import org.opensrp.core.dto.ProjectDTO;
import org.opensrp.core.dto.ProjectGroupDTO;
import org.opensrp.core.entity.Project;
import org.opensrp.core.entity.ProjectGroup;
import org.springframework.stereotype.Service;

@Service
public class ProjectGroupMapper {

    /**
     * DTO to Entity
     *
     * @param projectGroupDTO
     * @return
     */
    public ProjectGroup map(ProjectGroupDTO projectGroupDTO) {
        ProjectGroup projectGroup = new ProjectGroup();
        if (projectGroupDTO.getId() != 0)
            projectGroup.setId(projectGroupDTO.getId());
        projectGroup.setCode(projectGroupDTO.getCode());
        projectGroup.setName(projectGroupDTO.getName());
        projectGroup.setDescription(projectGroupDTO.getDescription());
        return projectGroup;
    }

    /**
     * DTO's to Entities
     *
     * @param dtos
     * @return
     */
    public List<ProjectGroup> map(List<ProjectGroupDTO> dtos) {
        List<ProjectGroup> entities = new ArrayList<>();

        dtos.forEach(dto -> entities.add(this.map(dto)));

        return entities;
    }

    /**
     * Entity to DTO
     *
     * @param projectGroup
     * @return
     */
    public ProjectGroupDTO map(ProjectGroup projectGroup) {
        ProjectGroupDTO projectGroupDTO = new ProjectGroupDTO();
        projectGroupDTO.setId(projectGroup.getId());
        projectGroupDTO.setCode(projectGroup.getCode());
        projectGroupDTO.setName(projectGroup.getName());
        projectGroupDTO.setDescription(projectGroupDTO.getDescription());
        return projectGroupDTO;
    }
}
