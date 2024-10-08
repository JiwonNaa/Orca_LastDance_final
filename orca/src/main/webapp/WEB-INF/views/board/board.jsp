<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.groupware.orca.user.vo.UserVo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록</title>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=417c2d6869f3c660f4e0370cf828ba62&libraries=services,places"></script>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <script defer src="/js/board/board.js"></script>
    <style>
/* JqGrid의 배경색을 페이지 배경색과 일치시키기 */
.ui-jqgrid {
   // background-color: #87CEFA; /* 이미지의 배경색과 일치 */
}

/* 테이블 헤더 스타일 변경 */
.ui-jqgrid .ui-jqgrid-htable th {
    background-color: #1e90ff; /* 헤더 배경색 변경 */
    color: #ffffff; /* 헤더 글자색 변경 */
    font-weight: bold;
}

/* 테이블 바디 스타일 변경 */
.ui-jqgrid .ui-jqgrid-btable td {
    //background-color: #ffffff; /* 바디 배경색 변경 */
    color: #333333; /* 바디 글자색 변경 */
}

/* 페이저 스타일 변경 */
.ui-jqgrid .ui-jqgrid-pager {
    background-color: #1e90ff; /* 페이저 배경색 변경 */
    color: #ffffff; /* 페이저 글자색 변경 */
}

/* 페이저 버튼 스타일 변경 */
.ui-jqgrid .ui-pg-button {
    background-color: #1e90ff; /* 버튼 배경색 변경 */
    color: #ffffff; /* 버튼 글자색 변경 */
}

/* JqGrid 테두리 스타일 수정 */
.ui-jqgrid, .ui-jqgrid-view, .ui-jqgrid-hdiv, .ui-jqgrid-bdiv, .ui-jqgrid-pager {
    border: 1px solid #1e90ff;
}

/* JqGrid 테이블 행 hover 스타일 수정 */
.ui-jqgrid .ui-jqgrid-btable tr.jqgrow:hover {
    background-color: #d3e9ff; /* hover 배경색 변경 */
    cursor: pointer;
}

/* 클릭된 행의 스타일 수정 */
.ui-jqgrid .ui-jqgrid-btable tr.jqgrow:active {
    background-color: #a8d8ff; /* 클릭된 행 배경색 변경 */
}

button{
background-color: #d3e9ff; /* hover 배경색 변경 */
 border: 2px solid white; /* 테두리 두께와 색상 설정 */
  border-radius: 15px; /* 둥근 모서리 설정 */
      padding: 10px 20px; /* 안쪽 여백 설정 */
}

    </style>
     <link rel="stylesheet" type="text/css" href="/css/board/board.css">
</head>
<body>
    <header>
      <div class="header-left">
                 <a href="/orca/home"><img src="/img/header/logo.png" alt="Logo" class="logo"></a>
                 <a href="/orca/home" style="text-decoration: none; color:black;">
                     <h2>ORCA</h2>
                 </a>
             </div>
             <div class="header-right">
                 <span class="icon"><img src="/img/header/bell.png" alt="bell" class="icon"></span>
                 <span class="icon"><img src="/img/header/organization-chart.png" alt="organization-chart" class="icon"></span>
                 <span class="icon"><img src="/img/header/settings.png" alt="settings" class="icon"></span>
             </div>
    </header>
    <button id="toggleSidebar" onclick="toggleSidebar()">메뉴</button>
    <% UserVo loginUserVo=(UserVo) session.getAttribute("loginUserVo"); String
                        imgChangeName=(loginUserVo.getImgChangeName() !=null) ? loginUserVo.getImgChangeName()
                        : "profile.png" ; %>
    <aside id="sidebar">
        <div class="profile" onclick="toggleProfile()">
            <img src="/upload/user/<%= imgChangeName %>" alt="Profile Picture" class="profile-pic">

                                        <p class="profile-info">
                                            <%= loginUserVo.getTeamName() %> | <span>
                                                    <%= loginUserVo.getName() %>
                                                </span>
                                        </p>
        </div>
        <hr>
        <div id="profileDetail" class="profile-detail hidden">
            <p>상태 설정</p>
            <p>상태 메시지</p>
            <p>@멘션 확인하기</p>
            <p>파일 리스트</p>
            <p>직책</p>
            <p>생년월일</p>
            <p>휴대전화</p>
            <p>raji1004@naver.com</p>
            <button onclick="logout()">로그아웃</button>
        </div>
        <nav>
            <ul>
                <li><a href="#" onclick="loadPage('home.jsp')">홈</a></li>
                <li><a href="#" onclick="loadPage('chat.jsp')">채팅</a></li>
                <li><a href="#" onclick="loadPage('calendar.jsp')">캘린더/할일</a></li>
                <li><a href="#" onclick="loadPage('documents.jsp')">문서관리</a></li>
                <li><a href="#" onclick="loadPage('attendance.jsp')">근태</a></li>
                <li><a href="#" onclick="loadPage('vote.jsp')">투표</a></li>
                <li><a href="#" onclick="loadPage('drive.jsp')">드라이브</a></li>
                <li><a href="#" onclick="loadPage('mail.jsp')">메일</a></li>
                <li><a href="#" onclick="loadPage('settings.jsp')">설정</a></li>
                <li><a href="/orca/board/statistics">통계</a></li>
                <li><a href="#" onclick="loadBookmarks()">북마크 목록</a></li>
            </ul>
        </nav>
    </aside>
    <main id="content">

           <a href="/orca/board/insert">📝</a>

            <div></div>
        <select id="categorySelect">
            <option value="1">자유 게시판</option>
            <option value="2">팀 게시판</option>
            <option value="3">익명 게시판</option>
            <option value="bookmark">북마크</option>
        </select>
        <input type="text" id="searchTitle" placeholder="제목으로 검색">
        <button id="searchBtn">검색</button>
 <a href="/orca/board/statistics">📊</a>
        <table id="jqGrid"></table>
        <div id="jqGridPager"></div>
    </main>

    <div class="modal modal-close" id="boardModal">
        <div class="modal-content">
            <button class="closeButton" onclick="closeModal()">닫기</button>
            <button class="updateButton" onclick="redirectToUpdatePage()">수정</button>
            <button class="deleteButton" onclick="deleteModal()">삭제</button>
            <h1 id="modal-title" data-board-no=""></h1>
            <div id="enrolldate"></div>
            <div id="insert-name"></div>
            <div id="teamName"></div>
            <div class="post-actions">
                <i class="far fa-heart like-button" id="like-button" onclick="toggleLike()"></i>
                <i class="far fa-bookmark bookmark-button" data-board-no="" onclick="toggleBookmark(this)"></i>
                <button class="btn btn-warning" onclick="openReportModal($('#modal-title').data('board-no'))">신고</button>
            </div>
            <div class="post-likes">
                <span id="like-count">0</span> 좋아요
            </div>
            <div id="hit-container">조회수: <span id="hit"></span></div>
            <hr>
            <div id="modal-content"></div>
            <div id="comments-container" class="comment-container"></div>
            <textarea id="new-comment-content" placeholder="댓글을 입력하세요"></textarea>
            <input type="hidden" id="reply-comment-no">
                 <div></div>
            <button onclick="addComment()">댓글 작성</button>
            <div id="map"></div>
            <div></div>
            <button id="btn-kakao" class="kakao-share-button">💬</button>
        </div>
    </div>

    <!-- 신고 모달 -->
    <div class="modal" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="reportModalLabel">게시물 신고</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeReportModal()">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="reportForm">
                        <div class="form-group">
                            <label for="reportCategory">신고 카테고리</label>
                            <select id="reportCategory" class="form-control" name="penaltyCategoryNo">
                                <option value="1">스팸 또는 광고</option>
                                <option value="2">혐오 발언 또는 폭력</option>
                                <option value="3">개인 정보 침해</option>
                                <option value="4">저작권 침해</option>
                                <option value="5">기타</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="reportContent">신고 내용</label>
                            <textarea id="reportContent" name="penaltyContent" class="form-control" rows="4"></textarea>
                        </div>
                        <input type="hidden" id="reportBoardNo" name="boardNo">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeReportModal()">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="submitReport()">신고하기</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var map;
        var currentUserNo = '<%= ((UserVo) session.getAttribute("loginUserVo")) != null ? ((UserVo) session.getAttribute("loginUserVo")).getEmpNo() : "" %>';

        $(document).ready(function () {
            var mapContainer = document.getElementById('map'),
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667),
                    level: 2
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
                if (categoryNo === 'bookmark') {
                    loadBookmarks();
                } else {
                    $("#jqGrid").jqGrid('setGridParam', {
                        url: '/orca/board/list/' + categoryNo,
                        page: 1
                    }).trigger('reloadGrid');
                }
            });

            $("#searchBtn").on("click", function () {
                var title = $("#searchTitle").val();
                var categoryNo = $("#categorySelect").val();
                if (isNaN(categoryNo)) {
                    alert("카테고리 번호가 잘못되었습니다.");
                    return;
                }
                $("#jqGrid").jqGrid('setGridParam', {
                    url: '/orca/board/search',
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
                url: '/orca/board/list/' + categoryNo,
                mtype: "GET",
                styleUI: 'jQueryUI',
                datatype: "json",
                colModel: [
                    {label: '게시판 번호', name: 'boardNo', width: 30},
                    {label: '제목', name: 'title', key: true, width: 75, formatter: titleFormatter},
                    {label: '조회수', name: 'hit', width: 50},
                    {label: '썸네일', name: 'content', width: 50, formatter: extractImage},
                    {
                        label: '작성 시간',
                        name: 'enrollDate',
                        width: 50,
                        formatter: function (cellValue, options, rowObject) {
                            const enrollDate = new Date(cellValue);
                            const formattedDate = enrollDate.toLocaleDateString('ko-KR', {
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit',
                                second: '2-digit',
                                hour12: true
                            });
                            return formattedDate;
                        }
                    },
                    {label: '신고', name: 'boardNo', width: 50, formatter: function (cellValue, options, rowObject) {
                        return '<button onclick="openReportModal(' + cellValue + ')">신고</button>';
                    }}
                ],
                viewrecords: true,
                width: 1400,
                height: 600,
                rowNum: 20,
                pager: "#jqGridPager"
            });
        }

        function titleFormatter(cellvalue, options, rowObject) {
            // 숨겨진 게시물인지 확인
            if (rowObject.isHidden === 'Y') {
                return "<span class='hidden-post'>숨겨진 게시물</span>";
            } else {
                return "<a href='javascript:;' onclick='showModal(" + rowObject.boardNo + ")'>" + cellvalue + "</a>";
            }
        }

        function extractImage(cellValue, options, rowObject) {
            var imgTag = $(cellValue).find('img').prop('outerHTML');
            return imgTag ? imgTag : '';
        }

        function showModal(boardNo) {
            $.ajax({
                url: "/orca/board/" + boardNo,
                method: "GET",
                dataType: "json",
                success: function (response) {
                    $('#modal-title').text(response.title);
                    $('#modal-title').attr('data-board-no', response.boardNo);
                    $('#hit').text(response.hit);
                    $('#teamName').text(response.teamName);
                    $('#modal-content').html(response.content ? response.content : '내용이 없습니다.');
                    $('#insert-name').text(response.employeeName);

                    const enrollDate = new Date(response.enrollDate);
                    const formattedDate = enrollDate.toLocaleString('ko-KR', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit',
                        second: '2-digit',
                        hour12: true
                    });
                    $('#enrolldate').text(formattedDate);

                    const bookmarkButton = document.querySelector('.bookmark-button');
                    bookmarkButton.setAttribute('data-board-no', boardNo);

                    // 로그인한 사용자와 작성자가 같을 경우에만 수정, 삭제 버튼 표시
                    const currentUserNo = '<%= ((UserVo) session.getAttribute("loginUserVo")) != null ? ((UserVo) session.getAttribute("loginUserVo")).getEmpNo() : "" %>';
                    if (currentUserNo == response.insertUserNo) {
                        $('.updateButton').show();
                        $('.deleteButton').show();
                    } else {
                        $('.updateButton').hide();
                        $('.deleteButton').hide();
                    }

                    $('#boardModal').show();
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
                    showComments(boardNo, response.categoryNo); // Pass the category number
                    checkLikeStatus(boardNo);
                    checkBookmarkStatus(boardNo);
                },
                error: function () {
                    alert("게시물 상세 정보를 불러오는데 실패했습니다.");
                }
            });
        }

        function checkLikeStatus(boardNo) {
            $.ajax({
                url: "/orca/board/like/" + boardNo,
                method: "GET",
                success: function (isLiked) {
                    const likeButton = document.getElementById('like-button');
                    if (isLiked) {
                        likeButton.classList.add('liked');
                    } else {
                        likeButton.classList.remove('liked');
                    }
                }
            });

            $.ajax({
                url: "/orca/board/likes/count/" + boardNo,
                method: "GET",
                success: function (likeCount) {
                    document.getElementById('like-count').innerText = likeCount;
                }
            });
        }

        function toggleLike() {
            const boardNo = document.getElementById('modal-title').dataset.boardNo;
            const likeButton = document.getElementById('like-button');

            if (likeButton.classList.contains('liked')) {
                $.ajax({
                    url: "/orca/board/like/" + boardNo,
                    method: "DELETE",
                    success: function () {
                        likeButton.classList.remove('liked');


                        updateLikeCount(boardNo, -1);
                    }
                });
            } else {
                $.ajax({
                    url: "/orca/board/like/" + boardNo,
                    method: "POST",
                    success: function () {
                        likeButton.classList.add('liked');
                        updateLikeCount(boardNo, 1);
                    }
                });
            }
        }

        function updateLikeCount(boardNo, change) {
            const likeCountElement = document.getElementById('like-count');
            let likeCount = parseInt(likeCountElement.innerText.split(' ')[0]);
            likeCount += change;
            likeCountElement.innerText = likeCount;
        }

        function getCommentHtml(comment, categoryNo) {
            var isReply = comment.replyCommentNo !== null;
            var commentClass = isReply ? 'comment reply' : 'comment';

            var html = '<div class="' + commentClass + '" data-comment-no="' + comment.boardChatNo + '">';
            var employeeName = comment.employeeName;
            var teamName = comment.teamName;

            if (categoryNo == 3 && comment.isAnonymous === "Y") {
                employeeName = '***';
                teamName = '***';
            } else if (!employeeName) {
                employeeName = '알 수 없음';
            }

            html += '<div class="author">작성자: ' + employeeName + '</div>';
            html += '<div class="team">팀: ' + teamName + '</div>';
            html += '<div class="date">' + comment.enrollDate + '</div>';
            html += '<div class="content">' + comment.content + '</div>';

            const currentUserNo = '<%= ((UserVo) session.getAttribute("loginUserVo")) != null ? ((UserVo) session.getAttribute("loginUserVo")).getEmpNo() : "" %>';
            if (currentUserNo == comment.insertUserNo) {
                html += '<div class="actions">';
                html += '<button onclick="editComment(' + comment.boardChatNo + ')">수정</button>';
                html += '<button onclick="deleteComment(' + comment.boardChatNo + ')">삭제</button>';
                html += '</div>';
            }

            html += '<button onclick="replyComment(' + comment.boardChatNo + ')">답글</button>';
            html += '</div>';

            if (comment.replies && comment.replies.length > 0) {
                html += '<div class="reply-container">';
                comment.replies.forEach(function (reply) {
                    html += getCommentHtml(reply, categoryNo); // Pass category number to replies
                });
                html += '</div>';
            }

            return html;
        }

        function showComments(boardNo, categoryNo) {
            $.ajax({
                url: "/orca/board/comment/list?boardNo=" + boardNo,
                method: "GET",
                dataType: "json",
                success: function (response) {
                    var comments = response.filter(comment => comment.boardNo == boardNo);
                    var commentMap = {};

                    comments.forEach(function (comment) {
                        commentMap[comment.boardChatNo] = comment;
                        commentMap[comment.boardChatNo].replies = [];
                    });

                    comments.forEach(function (comment) {
                        if (comment.replyCommentNo !== null) {
                            commentMap[comment.replyCommentNo].replies.push(comment);
                        }
                    });

                    var commentsHtml = '';
                    comments.forEach(function (comment) {
                        if (comment.replyCommentNo === null) {
                            commentsHtml += getCommentHtml(comment, categoryNo); // Pass category number
                        }
                    });

                    $('#comments-container').html(commentsHtml);
                },
                error: function () {
                    alert("댓글을 불러오는데 실패했습니다.");
                }
            });
        }

        function addComment() {
            var content = $('#new-comment-content').val();
            if (!content.trim()) {
                alert("댓글 내용을 입력하세요.");
                return;
            }
            var boardNo = $('#modal-title').data('boardNo');
            var categoryNo = $("#categorySelect").val(); // 현재 카테고리 번호 가져오기
            var comment = {
                boardNo: boardNo,
                content: content,
                isAnonymous: 'N', // 기본값 설정
                categoryNo: categoryNo // 카테고리 번호 추가
            };

            if (categoryNo == '3') {
                comment.isAnonymous = 'Y';
            }

            $.ajax({
                url: "/orca/board/comment/add",
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify(comment),
                success: function () {
                    $('#new-comment-content').val('');
                    showComments(boardNo, categoryNo); // 댓글 갱신 시 카테고리 번호 전달
                },
                error: function () {
                    alert("댓글 작성에 실패했습니다.");
                }
            });
        }

        function replyComment(replyCommentNo) {
            var content = prompt("답글 내용을 입력하세요:");
            if (content) {
                var boardNo = $('#modal-title').data('boardNo');
                var isAnonymous = $("#categorySelect").val() === '3' ? "Y" : "N";
                var categoryNo = $("#categorySelect").val(); // 카테고리 번호 가져오기

                var comment = {
                    boardNo: boardNo,
                    content: content,
                    isAnonymous: isAnonymous,
                    replyCommentNo: replyCommentNo,
                    categoryNo: categoryNo // 카테고리 번호 추가
                };

                $.ajax({
                    url: "/orca/board/comment/add",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(comment),
                    success: function () {
                        showComments(boardNo, categoryNo); // 댓글 갱신 시 카테고리 번호 전달
                    },
                    error: function () {
                        alert("답글 작성에 실패했습니다.");
                    }
                });
            }
        }

        function editComment(boardChatNo) {
            var currentContent = $('[data-comment-no="' + boardChatNo + '"]').find('div:nth-child(4)').text();
            var newContent = prompt("댓글 내용을 수정하세요:", currentContent);
            if (newContent !== null) {
                $.ajax({
                    url: "/orca/board/comment/edit",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({boardChatNo: boardChatNo, content: newContent}),
                    success: function () {
                        showComments($('#modal-title').data('boardNo'), $("#categorySelect").val()); // 댓글 갱신 시 카테고리 번호 전달
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
                    url: "/orca/board/comment/delete",
                    method: "POST",
                    data: {boardChatNo: boardChatNo},
                    success: function () {
                        showComments($('#modal-title').data('boardNo'), $("#categorySelect").val()); // 댓글 갱신 시 카테고리 번호 전달
                    },
                    error: function () {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                });
            }
        }

        function closeModal() {
            $('#boardModal').hide();
        }

        function redirectToUpdatePage() {
            var boardNo = $('#modal-title').data('boardNo');
            window.location.href = '/orca/board/updatePage?boardNo=' + boardNo;
        }

        Kakao.init('417c2d6869f3c660f4e0370cf828ba62');

        function deleteModal() {
            if (confirm("정말로 이 게시물을 삭제하시겠습니까?")) {
                var boardNo = $('#modal-title').data('boardNo');
                $.ajax({
                    url: "/orca/board/" + boardNo,
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

        document.getElementById('btn-kakao').addEventListener('click', function() {
            var boardNo = $('#modal-title').data('boardNo');
            var title = $('#modal-title').text();
            var description = $('#modal-content').text().substring(0, 100);
            var linkUrl = 'http://127.0.0.1:8080/orca/board';
            var imageUrl = 'https://via.placeholder.com/300';

            Kakao.Link.sendDefault({
                objectType: 'feed',
                content: {
                    title: title,
                    description: description,
                    imageUrl: imageUrl,
                    link: {
                        mobileWebUrl: linkUrl,
                        webUrl: linkUrl
                    }
                },
                buttons: [
                    {
                        title: '웹으로 보기',
                        link: {
                            mobileWebUrl: linkUrl,
                            webUrl: linkUrl
                        }
                    }
                ]
            });
        });

        function checkBookmarkStatus(boardNo) {
            $.ajax({
                url: "/orca/bookmark/list",
                method: "GET",
                success: function (response) {
                    const bookmarkButton = $('.bookmark-button[data-board-no="' + boardNo + '"]');
                    if (response.some(bookmark => bookmark.boardNo == boardNo)) {
                        bookmarkButton.addClass('bookmarked');
                    } else {
                        bookmarkButton.removeClass('bookmarked');
                    }
                },
                error: function () {
                    console.error("북마크 상태를 확인하는데 실패했습니다.");
                }
            });
        }

        function toggleBookmark(element) {
            const boardNo = $(element).data('boardNo');
            const isBookmarked = $(element).hasClass('bookmarked');

            if (isBookmarked) {
                $.ajax({
                    url: "/orca/bookmark/deleteByBoardNo/" + boardNo,
                    method: "DELETE",
                    success: function () {
                        $(element).removeClass('bookmarked');
                    },
                    error: function () {
                        alert("북마크 삭제에 실패했습니다.");
                    }
                });
            } else {
                $.ajax({
                    url: "/orca/bookmark/add",
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({ boardNo: boardNo }),
                    success: function () {
                        $(element).addClass('bookmarked');
                    },
                    error: function () {
                        alert("북마크 추가에 실패했습니다.");
                    }
                });
            }
        }

        function loadBookmarks() {
            $("#jqGrid").jqGrid('setGridParam', {
                url: '/orca/bookmark/list',
                mtype: "GET",
                datatype: "json",
                colModel: [
                    {label: 'No', name: 'boardNo', width: 30},
                    {label: 'Title', name: 'title', key: true, width: 75, formatter: titleFormatter}
                ],
                viewrecords: true,
                width: 1400,
                height: 600,
                rowNum: 50,
                pager: "#jqGridPager"
            }).trigger('reloadGrid');
        }

        function deleteBookmark(bookmarkNo) {
            $.ajax({
                url: "/orca/bookmark/delete/" + bookmarkNo,
                method: "DELETE",
                success: function () {
                    loadBookmarks();
                },
                error: function () {
                    alert("북마크 삭제에 실패했습니다.");
                }
            });
        }

        function openReportModal(boardNo) {
            $('#reportBoardNo').val(boardNo);
            $('#reportModal').show();
        }

        function closeReportModal() {
            $('#reportModal').hide();
        }

        function submitReport() {
            var boardNo = $('#reportBoardNo').val();
            var category = $('#reportCategory').val();
            var content = $('#reportContent').val();

            console.log("boardNo: ", boardNo);
            console.log("category: ", category);
            console.log("content: ", content);

            if (!boardNo || !category || !content) {
                alert("모든 필드를 채워주세요.");
                return;
            }

            $.ajax({
                url: "/orca/board/penalty",
                method: "POST",
                data: {
                    penaltyCategoryNo: category,
                    penaltyContent: content,
                    boardNo: boardNo
                },
                success: function (response) {
                    alert(response);
                    closeReportModal();

                    if (response === "신고가 누적되어 게시물이 숨겨졌습니다.") {
                        $("#jqGrid").trigger("reloadGrid");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    alert("신고 접수에 실패했습니다.");
                }
            });
        }

    </script>
</body>
</html>
