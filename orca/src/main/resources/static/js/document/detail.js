 function deleteDocument(element) {
        var docNo = $(element).data('doc-no');
        if (confirm('문서를 삭제하시겠습니까?')) {
            $.ajax({
                url: `/orca/document/delete`,
                type: 'DELETE',
                contentType: 'application/json',
                data: JSON.stringify({ docNo: docNo }),
                success: function(response) {
                    // 요청이 성공했을 경우, 문서 목록 페이지로 이동
                    alert(response.message);
                    window.location.href = '/orca/document/list';
                },
                error: function(xhr) {
                    // 요청이 실패했을 경우, 오류 메시지를 표시
                    alert(xhr.responseJSON.message);
                }
            });
        }
    }