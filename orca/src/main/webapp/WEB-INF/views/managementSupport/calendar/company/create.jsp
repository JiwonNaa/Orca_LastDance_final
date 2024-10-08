<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <div class="write-calendar-company">
        <h2>사내 캘린더 작성</h2>
        <div class="form-group">
            <label for="eventTitle">일정 제목</label>
            <input type="text" id="title" name="title" required>
        </div>
        <div class="form-group">
            <label for="content">일정 내용</label>
            <textarea id="calendar-content" name="content" rows="4"></textarea>
        </div>
        <div class="form-group">
            <label for="startDate">시작일</label>
            <input type="date" id="startDate" name="startDate" required>
        </div>
        <div class="form-group">
            <label for="endDate">종료일</label>
            <input type="date" id="endDate" name="endDate" required>
        </div>
        <div class="form-footer">
            <button id="submit" type="submit">일정 등록</button>
        </div>
    </div>

    <style>
        main {
            margin-top: 60px;
            margin-left: 220px;
            padding: 20px;
            flex-grow: 1;
            overflow-y: auto;
            transition: margin-left 0.3s ease;
            padding-left: 200px;
            padding-right: 200px;
            word-break: keep-all;
        }
        main.full{
            margin-left: 20px;
        }

        .main {
            display: flex;
            width: 100%;
            height: 100%;
            justify-content: center;
        }

        .write-calendar-company {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 440px;
            height: 550px;
        }

        .write-calendar-company h2 {
            text-align: center;
            color: #333;
            margin-top: 5px;
            margin-bottom: 55px;
        }

        .write-calendar-company .form-group {
            margin-bottom: 15px;
        }

        .write-calendar-company label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 900;
        }

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            margin-top: 8px;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        .write-calendar-company textarea {
            resize: vertical;
            resize: none;
        }

        .write-calendar-company .form-footer {
            display: flex;
            justify-content: end;
        }

        .write-calendar-company button[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 7px 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
            font-weight: 900;
            font-size: 14px;
        }

        .write-calendar-company button[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>