package com.groupware.orca.approvalLine.vo;

import lombok.Data;

import java.net.URL;

@Data
public class ApproverVo {

    private int docNo;                  // 문서 번호
    private int approverInfoNo;         // 결재자 정보 번호
    private int seq;                    // 순서 번호
    private int approverClassificationNo; // 결재자 분류 번호 (1: 결재자, 2: 합의자)
    private int approvalStage;          // 결재 단계 1:대기 2:승인 3:반려
    private String apprStageName;       // 결재 단계 이름

    private int approverNo;             // 결재자 번호
    private String approverName;        // 결재자 이름
    private int deptCode;               // 부서 코드
    private String deptName;            // 부서 이름
    private int positionCode;           // 직위 코드
    private String positionName;        // 직위 이름
    private String approvalDate;        // 결재 날짜
    private String comment;             // 코멘트

    private int apprLineNo;             // 결재선 번호
    private String apprLineName;        // 결재선 이름
    private String createdDate;         // 생성 날짜

}
