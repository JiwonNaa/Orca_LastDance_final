
function toggleSubMenu(menuId) {
  const menu = document.getElementById(menuId);
  menu.classList.toggle('hidden');  // 서브메뉴 숨김/표시 토글
}

document.addEventListener("DOMContentLoaded", function() {

    // 결재 등록 결재양식 제목 가져오기
    function fetchTemplatesByCategory(categoryNo) {
        $.ajax({
            url: '/orca/document/template/list',
            method: 'GET',
            data: { categoryNo: categoryNo },
            success: function(templates) {
                const templateSelect = document.querySelector('#templateNo');
                templateSelect.innerHTML = '';
                templates.forEach(template => {
                    const option = document.createElement('option');
                    option.value = template.templateNo;
                    option.text = template.title;
                    templateSelect.appendChild(option);
                });

                // 기본 - 첫 번째 템플릿의 내용으로 로드
                if (templates.length > 0) {
                    fetchTemplateContent(templates[0].templateNo);
                }
            },
            error: function(error) {
                console.error('Error fetching templates:', error);
            }
        });
    }

    // 결재 등록 카테고리 가져오기
    function fetchCategories() {
        $.ajax({
            url: '/orca/document/categorie/list',
            method: 'GET',
            success: function(categories) {
                const categorySelect = document.querySelector('#categoryNo');
                categorySelect.innerHTML = '';

                categories.forEach(category => {
                    const option = document.createElement('option');
                    option.value = category.categoryNo;
                    option.text = category.categoryName;
                    categorySelect.appendChild(option);
                });

                if (categories.length > 0) {
                    fetchTemplatesByCategory(categories[0].categoryNo);
                }
            },
            error: function(error) {
                console.error('error:', error);
                console.log(error);
            }
        });
    }

    // 결재 양식 내용, 결재선 불러오기
    function fetchTemplateContent(templateNo) {
        // 결재 양식 내용 불러오기
        $.ajax({
            url: '/orca/document/template/content',
            method: 'GET',
            data: { templateNo: templateNo },
            success: function(data) {
                $('#title').val(data.title); // 템플릿의 제목
                $('#content').val(data.content); // 템플릿의 내용
                $('#templateNo').val(data.templateNo);

                // 결재선 불러오기
                fetchApprovalLine(templateNo);
            },
            error: function() {
                alert('결재 양식 내용 불러오기 오류가 발생했습니다.');
            }
        });
    }

     // 결재선 불러오기
        function fetchApprovalLine(templateNo) {
            $.ajax({
                url: '/orca/document/template/apprline',
                method: 'GET',
                data: { templateNo: templateNo },
                success: function(data) {
                    updateApprovalProcess(data.approverVoList);
                },
                error: function() {
                    alert('결재선 불러오기 오류가 발생했습니다.');
                }
            });
        }

        // 결재선 프로세스 업데이트
        function updateApprovalProcess(approvers) {
            const processContainer = document.querySelector('.approval-process');
            processContainer.innerHTML = '';

            approvers.forEach((approver, index) => {
                const approverDiv = document.createElement('div');
                approverDiv.textContent = `${approver.seq} ${approver.deptName} ${approver.approverName} ${approver.positionName}`;
                processContainer.appendChild(approverDiv);

                if (index < approvers.length - 1) {
                    const arrowDiv = document.createElement('div');
                    arrowDiv.classList.add('arrow');
                    arrowDiv.textContent = '→'; // 화살표 추가
                    processContainer.appendChild(arrowDiv);
                }
            });
        }

    // 카테고리 변경 - 템플릿 목록 업데이트
    $('#categoryNo').change(function() {
        let categoryNo = $(this).val();
        fetchTemplatesByCategory(categoryNo);
    });

    // 결재 양식 선택 - 내용 업데이트
    $('#templateNo').change(function() {
        let templateNo = $(this).val();
        fetchTemplateContent(templateNo);
    });

    fetchCategories(); // 페이지 로드 - 카테고리 가져오기
    fetchVacationCodes();
});

function submitDocument() {
    var formData = $('#documentForm').serialize();
    $.ajax({
        url: '/orca/document/write',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function() {
            alert('결재 작성이 완료되었습니다.');
            window.location.href = '/orca/document/list';
        },
        error: function() {
            alert('결재 작성 중 오류가 발생했습니다.');
        }
    });
}