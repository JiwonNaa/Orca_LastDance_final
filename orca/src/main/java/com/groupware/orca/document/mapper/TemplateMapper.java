package com.groupware.orca.document.mapper;

import com.groupware.orca.document.vo.ApprovalLineVo;
import com.groupware.orca.document.vo.TemplateVo;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TemplateMapper {
    @Select("SELECT TC.CATEGORY_NO, TC.NAME categoryName, T.TEMPLATE_NO, T.TITLE, T.CONTENT, T.ENROLL_DATE FROM  DOC_TEMPLATE T JOIN DOC_TEMPLATE_CATEGORY TC ON T.CATEGORY_NO=TC.CATEGORY_NO WHERE T.DEL_YN='N' ORDER BY ENROLL_DATE DESC")
    List<TemplateVo> getTemplateList();

    @Insert("INSERT INTO DOC_TEMPLATE (TEMPLATE_NO, CATEGORY_NO, TITLE, CONTENT) VALUES (SEQ_DOC_TEMPLATE.NEXTVAL, #{categoryNo}, #{title}, #{content})")
    int addTemplate(TemplateVo vo);

 //   @Select("SELECT TC.CATEGORY_NO, TC.NAME AS categoryName, T.TEMPLATE_NO, T.TITLE, T.CONTENT, T.ENROLL_DATE, AI.APPROVER_NO, PI.NAME AS empName, D.PARTNAME, DT.TEAM_NAME, P.NAME_OF_POSITION FROM DOC_TEMPLATE T JOIN DOC_TEMPLATE_CATEGORY TC ON T.CATEGORY_NO = TC.CATEGORY_NO LEFT JOIN APPR_LINE_TEMPLATE ALT ON T.APPR_LINE_NO = ALT.APPR_LINE_NO LEFT JOIN APPROVER_INFO AI ON AI.APPR_LINE_NO = ALT.APPR_LINE_NO LEFT JOIN PERSONNEL_INFORMATION PI ON AI.APPROVER_NO = PI.EMP_NO LEFT JOIN DEPARTMENT D ON D.DEPT_CODE = PI.DEPT_CODE LEFT JOIN DEPARTMENT_TEAM DT ON DT.TEAM_CODE = PI.TEAM_CODE LEFT JOIN POSITION P ON P.POSITION_CODE = PI.POSITION_CODE WHERE T.DEL_YN='N' AND T.TEMPLATE_NO = #{templateNo}")
 //   TemplateVo TemplateDetail(String templateNo);


    @Select("SELECT TC.CATEGORY_NO, TC.NAME AS categoryName, " +
            "T.TEMPLATE_NO, T.TITLE, T.CONTENT, T.ENROLL_DATE " +
            "FROM DOC_TEMPLATE T " +
            "JOIN DOC_TEMPLATE_CATEGORY TC ON T.CATEGORY_NO = TC.CATEGORY_NO " +
            "WHERE T.DEL_YN = 'N' AND T.TEMPLATE_NO = #{templateNo}")
    TemplateVo templateDetail(String templateNo);

    @Select("SELECT AI.APPROVER_NO, PI.NAME AS approverName, P.NAME_OF_POSITION AS positionName, DT.TEAM_NAME AS deptName, AI.SEQ, AI.APPROVER_CLASSIFICATION_NO FROM APPROVER_INFO AI JOIN PERSONNEL_INFORMATION PI ON AI.APPROVER_NO = PI.EMP_NO LEFT JOIN POSITION P ON PI.POSITION_CODE = P.POSITION_CODE LEFT JOIN DEPARTMENT_TEAM DT ON PI.TEAM_CODE = DT.TEAM_CODE WHERE AI.APPR_LINE_NO = #{apprLineNo} ORDER BY AI.SEQ")
    List<ApprovalLineVo> selectApproverLineVo(int apprLineNo);


    @Update("""
        <script>
        UPDATE DOC_TEMPLATE
        <set>
            <if test="title != null">TITLE = #{title},</if>
            <if test="templateContent != null">CONTENT = #{templateContent},</if>
        </set>
        WHERE TEMPLATE_NO = #{templateNo}
        </script>
    """)
    int editTemplate(TemplateVo vo);


    @Delete("UPDATE DOC_TEMPLATE SET DEL_YN='Y' WHERE TEMPLATE_NO = #{templateNo}")
    int deleteTemplate(int templateNo);


}
