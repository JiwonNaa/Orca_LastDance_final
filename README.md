<h1 style="color: #000000;"><b>Groupware_orca🐋</b></h1>

<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>😄본인 역할</b></h2>
<ul style="list-style-type: disc;" data-ke-list-type="disc">
<li><b>DB관리자</b></li>
<li><b>전자결재 기능</b></li>
</ul>


<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>⚙️ 개발 환경</b></h2>
<div style="background-color: #ffffff; color: #1f2328; text-align: start;">
<h4>✨ Back & Front ✨</h4>
<div style="white-space: nowrap;">
    <img src='https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white'>
    <img src='https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white'>
    <img src='https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white'>
 <div style="white-space: nowrap;">
  <img src='https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white'>
  <img src='https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white'>
  <img src='https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white'>
    <img src='https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white'>
      <img src='https://img.shields.io/badge/MyBatis-000000?style=for-the-badge&logo=MyBatis&logoColor=white'>
</div>

<h4>🛠 사용 툴 🛠</h4>
<div style="white-space: nowrap;">
  <img src='https://img.shields.io/badge/intellij_Idea-2C2255?style=for-the-badge&logo=intellij-Idea&logoColor=white'>
  <img src='https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white'>
    <img src='https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white'>
</div>

<h4>Framework & server & library & API</h4>
<div style="white-space: nowrap;">
  <img src='https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=for-the-badge&logo=Apache-Tomcat&logoColor=white'>
  <img src='https://img.shields.io/badge/springboot-6DB33F?style=for-the-badge&logo=spring&logoColor=white'>
  <img src='https://img.shields.io/badge/Spring_Security-6DB33F?style=for-the-badge&logo=Spring-Security&logoColor=white'>
  <img src='https://img.shields.io/badge/Amazon_S3-569A31?style=for-the-badge&logo=Amazon-S3&logoColor=white'>
      <img src='https://img.shields.io/badge/Summer_Note-23cafc?style=for-the-badge'>
      <img src='https://img.shields.io/badge/JS_Tree-deff3b?style=for-the-badge'>
</div>



<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>⌨️ 담당기능</b><b></b></h2>

[화면]
 - 메인(헤더, 사이드)
 - 결재양식 등록, 수정, 목록
 - 결재선 등록, 목록
 - 기안서 작성, 수정, 목록

[경영지원팀 (관리자)]
- 기안서 양식 추가
- 기안서 양식 수정
- 기안서 양식 삭제
- 기안서 양식 전체 목록
- 기안서 양식 검색
    - [ajax] 카테고리, 이름으로 검색
- 기본 결재선 등록
    - [ajax] 결재 카테고리, 양식 호출
    - 양식 1개 당, 기본 결재선 1개
- 기본 결재선 목록
- 기본 결재선 삭제
  
[사원]
- 기안서 작성
    - [ajax] 결재 카테고리, 양식 호출 - 결재 선 호출
    - [ajax] 조직도 호출 - 참조자(여러 명) 등록 구현
    - 파일 등록 구현
    - 임시 저장, 기안 버튼 구현
- 기안서 수정
    - 기안자 - 기안서 상태 변경 (임시 저장 → 기안) 
- 기안서 철회
    - 결재자 중 승인, 반려 처리 1도 없을 때 철회 가능 
- 기안서 목록 (날짜 정렬)
    - 임시 저장 - 결재 이전 문서
    - 기안 - 결재를 올린 후 종결되기 이전의 문서
    - 결재
        - 결재 순서가 되면 보이도록 구현.
        - 승인시 다음 결재자에게 보임.
        - 반려시 기안자의 반려함으로 이동. / 다음 결재자에게 보이지 않음
        - 모든 결재자의 결재가 완료되면 (종결)처리
    - 종결 - 결재가 완료된 문서
    - 반려 - 결재자가 반려한 문서
    - 삭제함 - 결재 이전 기안자가 철회한 문서
    - 공유함 - 참조인으로 등록된 사람 볼 수 있음
    - [화면] 긴급- 최상단에 띄우기, 빨간 버튼
- 기안서 검색
    - 작성한 기안서 - 제목, 내용 검색
    - 받은 결재 - 작성자, 제목, 내용 검색
- 기안서 상세
    - 기안자 - 임시 저장일 경우 철회, 기안 버튼 구현
    - 결재자 및 합의자 - 승인 및 반려, 코멘트 작성
- 나만의 결재선 등록
    - [ajax] 결재 카테고리, 양식 호출
- 나만의 결재선 목록
- 나만의 결재선 삭제



<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>🖼️ 화면</b><b></b></h2>

<img src="/documentImg/temList-delete.jpg">
<img src="/documentImg/temAdd.png">
<img src="/documentImg/appr.png">
<img src="/documentImg/myappr_list.png">

<img src="/documentImg/docList.png">
<img src="/documentImg/docWrite.png">
<img src="/documentImg/docWrite-ref.png">
<img src="/documentImg/doc_detail3.png">
<img src="/documentImg/doc_detail4.png">


<h2 style="color: #000000; text-align: start;" data-ke-size="size26">🎛️플로우 차트</h2>
<img src="/documentImg/전자결재 플로우차트.jpg">

<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>🗃️ERD</b></h2>
<img src="/documentImg/전자결재 DB.jpg">

<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>📅개발 일정</b></h2>
2024-06-25 ~ 2024-07-22

<h2 style="color: #000000; text-align: start;" data-ke-size="size26"><b>🤓느낀점 및 회고</b></h2>
    
<span> CRUD를 정확히 이해하고 익히는 것에 중점을 두었으면 좋겠다는 강사님의 말씀을 듣고 '그룹웨어'라는 주제로 프로젝트를 진행하게 되었습니다.  팀원들과 함께 그룹웨어의 기능을 논의하며 'ecount'라는 사이트를 알게 되어 회계, 인사, 급여, 전자결재 등 다양한 기능을 참고했습니다. 또한, 실무에서 많이 사용하는 그룹웨어 중  'JANDI' UI를 참고하여 구현했습니다.
<br />
 세미 프로젝트 때는 커밋 메시지로 파일을 찾기 어려웠던 기억에 이번에는 커밋 메시지에 [add], [edit], [remove] 태그를 추가해 보는 것을 제안했습니다. 팀원들도 이 제안을 흔쾌히 받아들였고, 덕분에 특정 코드를 찾기가 쉬워지는 등 형상관리의 효율성을 높였습니다. 
<br />
 비동기 통신을 구현할 때에는 주로 AJAX를 사용했습니다. 세미 프로젝트에서는 AJAX를 접하는 시기였다면, 이번 프로젝트에서는 AJAX를 정확히 이해하고 활용하는 데 중점을 두었습니다. 이를 통해 클라이언트와 서버 간의 통신 방법을 명확하게 이해하게 되었습니다.
</span>
<br />
<br />
<span>
이번 프로젝트를 통해 실무에서 사용하는 그룹웨어 프로그램을 접하고, 다양한 기능을 구현하며 그룹웨어의 조작 방법을 익혔습니다. 무엇보다 팀워크의 중요성을 다시 한번 깨닫는 계기가 되었습니다. 
<br />
 특히, 의견을 제안하는 부분에서 서로를 존중하고 의견을 수렴하는 팀원들이 있어서 완성도 높은 프로젝트가 되었습니다. 예를 들면, 기능 구현 시 각자의 조사한 부분에서 다양한 아이디어를 제안하고, 서로의 의견을 경청하며 최적의 요구사항을 도출해냈습니다.
 <br />
 이러한 과정에서 갈등 없이 원활한 소통이 이루어졌고, 팀원 모두가 프로젝트의 성공에 기여할 수 있는 분위기를 만들 수 있었습니다. 팀원 간의 신뢰와 협력 덕분에 예상치 못한 문제들을 효과적으로 해결할 수 있었고, 최종적으로는 높은 완성도를 자랑하는 결과물을 만들어낼 수 있었습니다.
 </span>
