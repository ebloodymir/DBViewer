<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>

<head>
    <title>Таблица ${tName}</title>

    <link rel="stylesheet" type="text/css" href=" https://cdn.datatables.net/1.10.16/css/dataTables.semanticui.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.4.2/css/buttons.semanticui.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/select/1.2.3/css/select.semanticui.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/Datatables/editor.semanticui.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.0/css/responsive.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/components/Semantic-UI-Alert.css">

    <link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/Semantic-UI/bootswatch/semantic.cosmo.min.css">

    <script src="//code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.16/js/dataTables.semanticui.min.js"></script>
    <script src="/resources/Datatables/editor.semanticui.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.4.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.semanticui.min.js"></script>
    <script src="cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/select/1.2.3/js/dataTables.select.min.js"></script>
    <script type="text/javascript" language="javascript" src="https://cdn.datatables.net/responsive/2.2.0/js/dataTables.responsive.min.js"></script>
    <script src="/resources/Semantic-UI/components/Semantic-UI-Alert.js"></script>

    <style>

        body {
            background-color: #f4e7d7;
        }

        .menublack {
            color: whitesmoke !important;
            background-color: rgb(51, 51, 51) !important;
        }

        .menuelemblack {
            color: whitesmoke !important;;
            background-color: rgb(51, 51, 51) !important;
        }

        .menuelemblack:hover {
            background-color: rgb(0, 0, 0) !important;
        }

        .tableFooter {
            cursor: default;
        }

        table.dataTable tbody > tr.selected {
            background-color: rgba(51, 51, 51, 0.9);
            color: white;
        }

        .ui.menu .ui.dropdown .menu > .item:hover {
            background-color: rgb(0, 0, 0) !important;
        }

        .ui.selection.dropdown .menu > .item:hover {
            background-color: rgb(51, 51, 51);
            color: white;
        }
        .ui.input input:focus, .ui.input input:active {
            border-color: rgb(51, 51, 51);
        }
        .ui.form input[type="text"]:focus, .ui.form input[type="text"]:active {
            border-color: rgb(51, 51, 51);
        }
    </style>
</head>

<body>

<div class="ui fixed large menu menublack">
    <div class="ui container">
        <a href="#" class="header item menublack">
            <i class="Database icon"></i>
            Работа с БД
        </a>
        <a href="/login" class="item menuelemblack">Сменить БД</a>
        <div class="ui simple dropdown item menuelemblack">
            Таблицы <i class="dropdown icon"></i>
            <div class="menu menublack">
                <c:forEach items="${tables}" var="table">
                    <a class="item menuelemblack" href="/table_${table.name}"
                       style="color: whitesmoke !important;">${table.name}</a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<div class="ui main text container" style="margin-top: 112px">
    <h1 class="ui header" style="text-align: center;">
        <i class="left table icon"></i>${tName}
    </h1>
</div>
<div class="ui main text container" style="padding-bottom: 3rem;max-width: 100% !important;display: table;">
    <div class="ui segment" style="border: 6px solid rgb(59, 55, 56);">
        <div class="ui three item menu">
            <a class="teal item " id="addButton">
                <i class="left add circle icon"></i>
                Добавить
            </a>
            <a class="orange item" id="changeButton">
                <i class="left edit icon"></i>
                Изменить
            </a>
            <a class="red item" id="deleteButton">
                <i class="left minus circle icon"></i>
                Удалить
            </a>
        </div>
        <table id="dTable" class="ui celled table" width="100%" cellspacing="0" style="cursor: pointer;">
            <thead>
            <tr>
                <c:forEach items="${fields}" var="field">
                    <th style="cursor: default;">${field.name}</th>
                </c:forEach>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${records}" var="record" varStatus="theCount">
                <tr id="row_${theCount.index}" role="row">
                    <c:forEach items="${record}" var="field">
                        <td>${field}</td>
                    </c:forEach>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <c:forEach items="${fields}" var="field">
                    <th class="tableFooter">${field.name}</th>
                </c:forEach>
            </tr>
            </tfoot>
        </table>
    </div>
    <!--MODAL-->
    <div class="ui small modal" id="modalWindow">
        <div class="header" id="modalTitle">Добавить</div>
        <div class="scrolling content">
            <form class="ui form" action="/" method="post" name="someBODY" id="addChangeForm">
                <c:forEach items="${fields}" var="field">
                    <div class="field">
                        <label>${field.name}</label>
                        <input name="${field.name}" type="text" class="modalInputField">
                    </div>
                </c:forEach>
            </form>
        </div>
        <div class="actions">
            <div class="ui black deny button" style="background-color: #87918a;"
                 onclick="$('#modalWindow').modal('hide');">
                Отмена
            </div>
            <div class="ui positive right button" style="background-color: #d4461e;" id="addChangeButton">
                <div id="modalAddChangeLabel">
                    Добавить
                </div>
            </div>
        </div>
    </div>
    <!--MODAL DELETE-->
    <div class="ui mini modal" id="modalDelete">
        <div class="header">
            Подтвердите удаление
        </div>
        <div class="content" id="modalDeleteQuestionLable">
            Удалить 7 элементов?
        </div>
        <div class="actions">
            <div class="ui black deny button" style="background-color: #87918a;"
                 onclick="$('#modalDelete').modal('hide');">
                Нет
            </div>
            <div class="ui positive right button" style="background-color: #d4461e;">
                <div id="modalDeleteOK">
                    Да
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var table = $('#dTable').DataTable({
            select: true,
            responsive: true,
            columns: [
                <c:forEach items="${fields}" var="field">
                {name: '${field.name}'},
                </c:forEach>
            ],
            language: {
                "processing": "Подождите...",
                "search": "Поиск:",
                "lengthMenu": "Показать _MENU_ записей",
                "info": "Записи  _START_ - _END_ из _TOTAL_",
                "infoEmpty": "нет записей",
                "infoFiltered": "(отфильтровано из _MAX_ записей)",
                "infoPostFix": "",
                "loadingRecords": "Загрузка записей...",
                "zeroRecords": "Записи отсутствуют.",
                "emptyTable": "В таблице отсутствуют данные",
                "paginate": {
                    "first": "Первая",
                    "previous": "Предыдущая",
                    "next": "Следующая",
                    "last": "Последняя"
                },
                "aria": {
                    "sortAscending": ": активировать для сортировки столбца по возрастанию",
                    "sortDescending": ": активировать для сортировки столбца по убыванию"
                },
                select: {
                    rows: "Выбрано строк: %d"
                }
            }

        });
        table
            .on('select', function (e, dt, type, indexes) {
                var count = table.rows({selected: true}).count();
                if (count > 1 || count == 0) {
                    $("#addButton").prop('disabled', true);
                }
                else {
                    $("#addButton").prop('disabled', false);
                }
            })
            .on('deselect', function (e, dt, type, indexes) {
                var count = table.rows({selected: true}).count();
                if (count > 1 || count == 0) {
                    $("#addButton").prop('disabled', true);
                }
                else {
                    $("#addButton").prop('disabled', false);
                }
            });

        function fillModal() {
            var elements = document.getElementsByClassName('modalInputField');
            for (var i = 0; i < elements.length; i++) {
                elements[i].value = "HUEHUEHEUEHUEEHUEHEU";
            }
            $('#modalWindow').modal('show');
        }

        function clearModal() {
            var elements = document.getElementsByClassName('modalInputField');
            for (var i = 0; i < elements.length; i++) {
                elements[i].value = "";
            }
        }

        // Кнопка добавить
        // ID выдает кривой, нужна перезагрузка страницы
        $("#addButton").click(function () {
            $("#modalTitle").html("Добавить");
            $("#modalAddChangeLabel").html("Добавить")
            clearModal();
            var data = table.rows().data()[0]; // data.0, data.1 ... data.n - array fields (n = count)
            var field;
            var elements = document.getElementsByClassName('modalInputField');
            for (var j = 0; j < elements.length; j++) {
                elements[j].placeholder = data[j];
            }
            $('#modalWindow').modal('show');
        });

        // Кнопка изменить
        $("#changeButton").click(function () {
            var count = table.rows({selected: true}).count();
            if (count == 1) {
                $("#modalTitle").html("Изменить");
                $("#modalAddChangeLabel").html("Изменить")
                clearModal();
                var data = table.rows({selected: true}).data()[0]; // data.0, data.1 ... data.n - array fields (n = count)
                var field;
                var elements = document.getElementsByClassName('modalInputField');
                for (var j = 0; j < elements.length; j++) {
                    elements[j].value = data[j];
                }
                $('#modalWindow').modal('show');
            } else if (count > 1) {
                showWarning("Нельзя изменить больше одной записи");
            } else {
                showWarning("Выберите данные для изменения");
            }
        });

        // Сохранить изменения
        function changeData() {
            var stas = JSON.stringify(getFormData($("form[id=addChangeForm]")));
            $.ajax({
                url: '/updateRecord${tName}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'values': stas
                },
                success: function (data) {
                    if (data.status == "OK") {
                        var stass = $("form[id=addChangeForm]").serializeArray();
                        var sass = mapToArray(stass);
                        table.row({selected: true}).data(sass);
                        showSuccess("Запись изменена");
                    } else
                        showError("Не удалось изменить запись");
                }
            });
        }

        // Кнопка удалить
        $("#deleteButton").click(function () {
            var count = table.rows({selected: true}).count();
            if (count > 0) {
                $('#modalDelete').modal('show');
                var qString = "Вы действительно хотите удалить " + declOfNum(count, ['запись?', 'записи?', 'записей?']);
                $('#modalDeleteQuestionLable').html(qString);
            } else {
                showWarning("Выберите данные для удаления");
            }
        });
        // Подтвердить удаление
        $("#modalDeleteOK").click(function () {
            $('#modalDelete').modal('hide');
            var rows = table.rows({selected: true}).data();
            var indexList = []; // IDs for delete
            for (var i = 0; i < rows.length; i++) {
                indexList.push(rows[i][${pkFieldIndex}]);
            }
            var jsonArray = JSON.stringify(indexList);
            $.ajax({
                url: '/deleteRecord${tName}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'values': jsonArray
                },
                success: function (data) {
                    switch (data.status) {
                        case "OK":
                            table.rows({selected: true}).remove().draw(false);
                            showSuccess("Запись удалена!");
                            break;
                        case "ConstraintError":
                            showError("Невозможно удалить выбранные записи: нарушение ограничений БД");
                            break;
                        default:
                            showError("Что то пошло не так");
                            break;
                    }
                }
            });
        });

        $('#addChangeButton').click(function () {
            if ($("#modalTitle").html() == "Добавить")
                sendData();
            else if ($("#modalTitle").html() == "Изменить")
                changeData();
        });
        // Склонение существительных после числительных
        function declOfNum(number, titles) {
            cases = [2, 0, 1, 1, 1, 2];
            return number + ' ' + titles[(number % 100 > 4 && number % 100 < 20) ? 2 : cases[(number % 10 < 5) ? number % 10 : 5]];
        }

        function getFormData($form) {
            var unindexed_array = $form.serializeArray();
            var indexed_array = {};

            $.map(unindexed_array, function (n, i) {
                indexed_array[n['name']] = n['value'];
            });

            return indexed_array;
        }

        function mapToArray(array) {
            var retArray = [];
            for (var i = 0; i < array.length; i++)
                retArray.push(array[i].value);
            return retArray;
        }

        // Отправка данных для добавления записи
        function sendData() {
            var stas = JSON.stringify(getFormData($("form[id=addChangeForm]")));
            $.ajax({
                url: '/addRecord${tName}',
                type: 'POST',
                dataType: 'json',
                data: {
                    'values': stas
                },
                success: function (data) {
                    if (data.status == "OK") {
                        var stass = $("form[id=addChangeForm]").serializeArray();
                        var sass = mapToArray(stass);
                        sass[0] = data.id;
                        table.row.add(sass).draw(false);
                        showSuccess("Запись добавлена!");
                    } else
                        showError("Не удалось добавить запись");
                }
            });
        }
    });
    function showError(message) {
        $.uiAlert({
            textHead: 'Ошибка', // header
            text: message, // Text
            bgcolor: '#b22323', // background-color
            textcolor: '#fff', // color
            position: 'bottom-right',// position . top And bottom ||  left / center / right
            icon: 'remove circle', // icon in semantic-UI
            time: 3, // time
        });
    }
    function showWarning(message) {
        $.uiAlert({
            textHead: 'Предупреждение', // header
            text: message, // Text
            bgcolor: '#d5761a', // background-color
            textcolor: '#fff', // color
            position: 'bottom-right',// position . top And bottom ||  left / center / right
            icon: 'warning sign', // icon in semantic-UI
            time: 3, // time
        });
    }
    function showSuccess(message) {
        $.uiAlert({
            textHead: 'Успешно', // header
            text: message, // Text
            bgcolor: '#2898c4', // background-color
            textcolor: '#fff', // color
            position: 'bottom-right',// position . top And bottom ||  left / center / right
            icon: 'checkmark box', // icon in semantic-UI
            time: 3, // time
        });
    }
</script>
<script src="/resources/Semantic-UI/semantic.js"></script>
</body>
</html>

