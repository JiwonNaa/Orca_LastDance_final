<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.groupware.orca.user.vo.UserVo" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/board/board.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=417c2d6869f3c660f4e0370cf828ba62&libraries=services,places"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

    <style>
        .kakao-share-button {
            width: 50px;
            height: 50px;
            background-color: #FFEB00;
            border: none;
            border-radius: 50%;
            background-image: url('/images/kakao-logo.png');
            background-size: cover;
            background-position: center;
            cursor: pointer;
            display: inline-block;
            margin: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
        }

        .kakao-share-button:hover {
            transform: scale(1.1);
        }

        #map {
            width: 100%;
            height: 400px;
        }

        .comments {
            margin-top: 20px;
        }

        .comment {
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
        }

        .comment-reply {
            margin-left: 30px;
        }
    </style>
</head>
<body>
<main id="content">
    <h2>게시판 목록</h2>
    <select id="categorySelect">
        <option value="1">자유 게시판</option>
        <option value="2">팀 게시판</option>
        <option value="3">익명 게시판</option>
    </select>
    <input type="text" id="searchTitle" placeholder="검색어 입력">
    <button id="searchBtn">검색</button>
    <table id="jqGrid"></table>
    <div id="jqGridPager"></div>
</main>
<div class="modal modal-close">
    <div class="modal-content">
        <button class="closeButton" onclick="closeModal()">닫기</button>
        <button class="updateButton" onclick="redirectToUpdatePage()">수정</button>
        <button class="deleteButton" onclick="deleteModal()">삭제</button>
        <h1 id="modal-title"></h1>
        <div id="enrolldate"></div>
        <div id="insert-name"></div>
        <div id="hit-container">조회수: <span id="hit"></span></div>
        <hr>
        <div id="modal-content"></div>
        <div id="comments-container" class="comments"></div>
        <textarea id="new-comment-content" placeholder="댓글을 입력하세요"></textarea>
        <button onclick="addComment()">댓글 작성</button>
        <div id="map"></div>
        <button id="btn-kakao" class="kakao-share-button">💬</button>
    </div>
</div>

<script type="text/javascript">
    var map;
    var currentUserNo = '<%= ((UserVo) session.getAttribute("loginUserVo")).getEmpNo() %>';

    $(document).ready(function () {
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level: 3
            };
        map = new kakao.maps.Map(mapContainer, mapOption);
        kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
            var latlng = mouseEvent.latLng;
            marker.setPosition(latlng);
            var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, 경도는 ' + latlng.getLng() + ' 입니다';
            alert(message);
        });

        var categoryNo = $("#categorySelect").val();
        loadGrid(categoryNo);

        $("#categorySelect").on("change", function () {
            categoryNo = $(this).val();
            $("#jqGrid").jqGrid('setGridParam', {
                url: '/board/list/' + categoryNo,
                page: 1
            }).trigger('reloadGrid');
        });

        $("#searchBtn").on("click", function () {
            var title = $("#searchTitle").val();
            var categoryNo = parseInt($("#categorySelect").val(), 10);
            if (isNaN(categoryNo)) {
                alert("카테고리 번호가 잘못되었습니다.");
                return;
            }
            $("#jqGrid").jqGrid('setGridParam', {
                url: '/search',
                postData: {
                    title: encodeURIComponent(title),
                    categoryNo: categoryNo
                },
                page: 1
            }).trigger('reloadGrid');
        });
    });

    function loadGrid(categoryNo) {
        $("#jqGrid").jqGrid({
            url: '/board/list/' + categoryNo,
            mtype: "GET",
            styleUI: 'jQueryUI',
            datatype: "json",
            colModel: [
                {label: 'No', name: 'boardNo', width: 30},
                {label: 'Title', name: 'title', key: true, width: 75, formatter: titleFormatter},
                {label: 'Views', name: 'hit', width: 50},
            ],
            viewrecords: true,
            width: 900,
            height: 300,
            rowNum: 20,
            pager: "#jqGridPager"
        });
    }

    function titleFormatter(cellvalue, options, rowObject) {
        return "<a href='javascript:;' onclick='showModal(" + rowObject.boardNo + ")'>" + cellvalue + "</a>";
    }

    function showModal(boardNo) {
        $.ajax({
            url: "/board/" + boardNo,
            method: "GET",
            dataType: "json",
            success: function (response) {
                kakao.maps.load();
                $('#modal-title').text(response.title);
                $('#hit').text(response.hit);
                $('#modal-content').html(response.content ? response.content : '내용이 없습니다.');
                $('#modal-title').data('boardNo', boardNo);
                $('#enrolldate').text(response.enrollDate);
                $('#insert-name').text(response.employeeName);
                $('.modal').removeClass('modal-close');
                const lat = parseFloat(response.latitude);
                const lng = parseFloat(response.longitude);
                if (!isNaN(lat) && !isNaN(lng)) {
                    $('#map').show();
                    map.relayout();
                    var moveLatLon = new kakao.maps.LatLng(lat, lng);
                    map.setCenter(moveLatLon);
                    var marker = new kakao.maps.Marker({
                        position: new kakao.maps.LatLng(lat, lng)
                    });
                    marker.setMap(map);
                } else {
                    $('#map').hide();
                }
                showComments(boardNo);
            },
            error: function () {
                alert("게시물 상세 정보를 불러오는데 실패했습니다.");
            }
        });
    }

    function showComments(boardNo) {
        $.ajax({
            url: "/board/comment/list?boardNo=" + boardNo,
            method: "GET",
            dataType: "json",
            success: function (response) {
                var commentsHtml = '';
                response.forEach(function (comment) {
                    commentsHtml += getCommentHtml(comment);
                });
                $('#comments-container').html(commentsHtml);
            },
            error: function () {
                alert("댓글을 불러오는데 실패했습니다.");
            }
        });
    }

    function getCommentHtml(comment) {
        var html = '<div class="comment" data-comment-no="' + comment.boardChatNo + '">';
        html += '<div>작성자: ' + (comment.employeeName ? comment.employeeName : '알 수 없음') + '</div>';
        html += '<div>' + comment.enrollDate + '</div>';
        html += '<div>' + comment.content + '</div>';
        if (comment.insertUserNo == currentUserNo) {
            html += '<button onclick="editComment(' + comment.boardChatNo + ')">수정</button>';
            html += '<button onclick="deleteComment(' + comment.boardChatNo + ')">삭제</button>';
        }
        html += '<button onclick="replyComment(' + comment.boardChatNo + ')">답글</button>';
        html += '</div>';
        if (comment.replies && comment.replies.length > 0) {
            html += '<div class="comment-replies">';
            comment.replies.forEach(function (reply) {
                html += getCommentHtml(reply);
            });
            html += '</div>';
        }
        return html;
    }

    function addComment() {
        var content = $('#new-comment-content').val();
        if (!content.trim()) {
            alert("댓글 내용을 입력하세요.");
            return;
        }
        var boardNo = $('#modal-title').data('boardNo');
        var comment = {
            boardNo: boardNo,
            content: content
        };
        $.ajax({
            url: "/board/comment/add",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(comment),
            success: function () {
                $('#new-comment-content').val('');
                showComments(boardNo);
            },
            error: function () {
                alert("댓글 작성에 실패했습니다.");
            }
        });
    }

    function editComment(boardChatNo) {
        var currentContent = $('[data-comment-no="' + boardChatNo + '"]').find('div:nth-child(3)').text();
        var newContent = prompt("댓글 내용을 수정하세요:", currentContent);
        if (newContent !== null) {
            $.ajax({
                url: "/board/comment/edit",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify({boardChatNo: boardChatNo, content: newContent}),
                success: function () {
                    showComments($('#modal-title').data('boardNo'));
                },
                error: function () {
                    alert("댓글 수정에 실패했습니다.");
                }
            });
        }
    }

    function deleteComment(boardChatNo) {
        if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
            $.ajax({
                url: "/board/comment/delete",
                method: "POST",
                data: {boardChatNo: boardChatNo},
                success: function () {
                    showComments($('#modal-title').data('boardNo'));
                },
                error: function () {
                    alert("댓글 삭제에 실패했습니다.");
                }
            });
        }
    }

    function replyComment(parentCommentNo) {
        var content = prompt("답글 내용을 입력하세요:");
        if (content) {
            var boardNo = $('#modal-title').data('boardNo');
            var comment = {
                boardNo: boardNo,
                content: content,
                previousCommentNo: parentCommentNo
            };
            $.ajax({
                url: "/board/comment/add",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify(comment),
                success: function () {
                    showComments(boardNo);
                },
                error: function () {
                    alert("답글 작성에 실패했습니다.");
                }
            });
        }
    }

    function closeModal() {
        $('.modal').addClass('modal-close');
    }

    function redirectToUpdatePage() {
        var boardNo = $('#modal-title').data('boardNo');
        window.location.href = '/board/updatePage?boardNo=' + boardNo;
    }

    function deleteModal() {
        if (confirm("정말로 이 게시물을 삭제하시겠습니까?")) {
            var boardNo = $('#modal-title').data('boardNo');
            $.ajax({
                url: "/board/" + boardNo,
                method: "DELETE",
                success: function () {
                    closeModal();
                    $("#jqGrid").trigger("reloadGrid");
                },
                error: function () {
                    alert("게시물 삭제에 실패했습니다.");
                }
            });
        }
    }

    Kakao.init('417c2d6869f3c660f4e0370cf828ba62');
    document.getElementById('btn-kakao').addEventListener('click', function () {
        Kakao.Share.sendDefault({
            objectType: 'feed',
            content: {
                title: '게시물 제목',
                description: '게시물 내용',
                imageUrl: 'https://example.com/thumbnail.jpg',
                link: {
                    mobileWebUrl: 'https://example.com',
                    webUrl: 'https://example.com'
                }
            },
            buttons: [
                {
                    title: '웹으로 보기',
                    link: {
                        mobileWebUrl: 'https://example.com',
                        webUrl: 'https://example.com'
                    }
                }
            ]
        });
    });
</script>
</body>
</html>
