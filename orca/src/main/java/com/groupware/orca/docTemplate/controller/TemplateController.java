package com.groupware.orca.docTemplate.controller;

import com.groupware.orca.common.vo.DepartmentVo;
import com.groupware.orca.docTemplate.service.TemplateService;
import com.groupware.orca.docTemplate.vo.TemplateVo;
import com.groupware.orca.user.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("orca/template")
@RequiredArgsConstructor
public class TemplateController {

    private final TemplateService service;

    // 관리자(경영지원부서)
    // 결재양식 등록 화면
    @GetMapping("add")
    public String addTemplate() {
        return "template/add";
    }

    @GetMapping("search")
    public String searchTemplateList() {
        return "template/search";
    }

    // 세션으로 관리자인지 확인하고 기능 - 구현
    // 결재양식 등록 기능
    @PostMapping("add")
    public String addTemplate(TemplateVo vo, HttpSession httpSession) {
        int result = service.addTemplate(vo);
        return "redirect:/orca/template/list";
    }
    // 결재양식 목록
    @GetMapping("list")
    public String getTemplateList(Model model, HttpSession httpSession) {
        // 세션에서 로그인 정보 가져오기
        DepartmentVo loginDeptVo = (DepartmentVo) httpSession.getAttribute("loginDeptVo");

        // 로그인 여부 확인
        if (loginDeptVo == null) {
            return "redirect:/orca/user/showDepartmentLogin";
        }

        // 권한 체크
        if (loginDeptVo.getDeptCode() != 3) {
            return "redirect:/orca/home";
        }

        // 권한이 확인되면 결재양식 목록을 모델에 추가
        List<TemplateVo> templateList = service.getTemplateList();
        model.addAttribute("templateList", templateList);

        // 결재양식 목록을 표시할 JSP/Thymeleaf 페이지 이름 반환
        return "template/list";
    }

    // 결재양식 목록
    @GetMapping("getlist")
    @ResponseBody
    public List<TemplateVo> getMainTemplateList(HttpSession httpSession){
        List<TemplateVo> templateList = service.getTemplateList();
        return templateList;
    }

    // 결재양식 검색
    @GetMapping("/search/data")
    @ResponseBody
    public List<TemplateVo> getsearchTemplateList(
            @RequestParam(value = "searchType", required = false) String searchType,
            @RequestParam(value = "searchText", required = false) String searchText) {

            TemplateVo vo = new TemplateVo();

            if ("title".equals(searchType)) {
                vo.setTitle(searchText);
            } else if ("categoryName".equals(searchType)) {
                vo.setCategoryName(searchText);
            }

        List<TemplateVo> templateList = service.getsearchTemplateList(vo);

        return templateList;
    }

    // 결재양식 상세보기
    @GetMapping("detail")
    public String templateDetail( Model model, int templateNo,HttpSession httpSession) {
        TemplateVo vo = service.getTemplateDetail(templateNo);
        model.addAttribute("templateDetail", vo);
        return "template/detail";
    }

    // 결재양식 수정 화면
    @GetMapping("edit")
    public String editTemplate(@RequestParam("templateNo") String templateNo, Model model, HttpSession httpSession) {
        model.addAttribute("templateNo", templateNo);
        return "template/edit";
    }
    // 결재양식 수정 데이터 가져오기
    @GetMapping("getTemplateData")
    @ResponseBody
    public TemplateVo getTemplateData(@RequestParam("templateNo") int templateNo, HttpSession httpSession) {
        TemplateVo vo = service.getTemplateDetail(templateNo);
        return vo;
    }
    // 결재양식 수정 기능
    @PutMapping("edit")
    public ResponseEntity<Void> editTemplate(@RequestBody TemplateVo vo, HttpSession httpSession){

        int loginUserNo = ((UserVo) httpSession.getAttribute("loginUserVo")).getEmpNo();

        int result = service.editTemplate(vo);
        if (result > 0) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 결재양식 삭제
    @PutMapping("delete")
    public ResponseEntity<Map<String, String>> deleteTemplate(@RequestBody Map<String, Integer> requestBody, HttpSession httpSession) {
        int templateNo = requestBody.get("templateNo");

        int result = service.deleteTemplate(templateNo);

        Map<String, String> response = new HashMap<>();
        if (result > 0) {
            response.put("message", "문서양식 삭제에 성공했습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("message", "문서양식 삭제에 실패했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
