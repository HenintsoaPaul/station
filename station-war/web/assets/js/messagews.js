var mySound;
soundManager.setup({
    onready: function () {
        mySound = soundManager.createSound({
            id: 'notify',
            url: '../assets/audio/notify.mp3'
        });
    },
    ontimeout: function () {
    }
});
function messageSound() {
    mySound.play();
}

var wsUri = location.protocol+'://'+location.hostname+':'+location.port+'?iduser=';
var socket;
function runWScommunication(iduser) {
    socket = io.connect(wsUri + iduser);
    socket.on('connect', function () {
    });

    socket.on('chatevent', function (data) {
        onMessage(data);
    });

    socket.on('disconnect', function () {
    });
}

function sendDisconnect() {
    socket.disconnect();
}

function sendMessage(idreceiver, msg) {
    var requete;
    var url = '../ChatServlet?receiver=' + idreceiver + '&message=' + msg;
    if (window.XMLHttpRequest) {
        requete = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        requete = new ActiveXObject("Microsoft.XMLHTTP");
    }
    requete.open("POST", url, true);
    requete.onreadystatechange = function () {
        if (requete.readyState === 4) {
            if (requete.status === 200) {
                var jsonObject = {idreceiver: idreceiver, idsender: '', room: '', type: 'msg', username: '', message: msg};
                socket.emit('chatevent', jsonObject);

                if ($('#modalSendMessage').css('display') === 'block' && $('#message-chat-content').attr('data-user') === idreceiver) {
                    var element = '<div class="message-element right">'
                            + '<div class="message-text right">' + msg + '</div>'
                            + '</div>';
                    $(element).appendTo("#message-chat-content");
                }
            }
        }
    };
    requete.send(null);
}
function autrui() {
    var autre = document.getElementById('autrui').value;    
    document.getElementById('senderReceiver').value = autre;
}
function onMessage(data) {
    messageSound();
    if (data.type === 'msg') {
        var news = (parseInt(document.getElementById('nb-inbox').innerHTML) + 1) ? (parseInt(document.getElementById('nb-inbox').innerHTML) + 1) : 1;
        var newsinbox = (parseInt(document.getElementById('inbox').innerHTML) + 1) ? (parseInt(document.getElementById('inbox').innerHTML) + 1) : 1;
        document.getElementById('nb-inbox').innerHTML = news.toString();
        document.getElementById('inbox').innerHTML = newsinbox.toString();
        if ($('#message-listcontent-header').css('display') === 'block') {
            loadMessageHeader();
        }
        if ($('#modalSendMessage').css('display') === 'block' && $('#message-chat-content').attr('data-user') === data.idsender) {
            var element = '<div class="message-element left">'
                    + '<div class="message-text left">' + data.message + '</div>'
                    + '</div>';
            $(element).appendTo("#message-chat-content");
        }
    }
}
function loadMessageHeader() {
    if ($('#message-listcontent-header').is(':visible'))
        return;
    var loading = '<div class="background-loading loadermsg-header" style="margin-top: 50px;"></div>';
    $("#message-list-header").html(loading);
    var requete;

    var url = '../Message?categoriemsg=all&limit=10&offset=0';
    if (window.XMLHttpRequest) {
        requete = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        requete = new ActiveXObject("Microsoft.XMLHTTP");
    }
    requete.open("POST", url, true);
    requete.onreadystatechange = function () {
        if (requete.readyState === 4) {
            if (requete.status === 200) {
                var data = JSON.parse(requete.responseText);
                $('#message-list-header').html('');
                $.each(data, function (index, message) {
                    var statut = (message.statut === 'nonlu') ? 'nonlu' : '';
                    var comefrom = (message.comefrom === '1') ? '<i class="fa fa-mail-reply"></i>' : '';
                    var element = '';
                    element += '<li>'
                            + '<a href="#" class="message-list ' + statut + '" data-toggle="modal" data-target="#modalSendMessage" onclick="loadMessage(\'' + message.idconversation + '\')">'
                            + '<div class="pull-left">'
                            + '<img src="../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image" />'
                            + '</div>'
                            + '<h4>'
                            + message.todisplayname
                            + ((message.comefrom === 1) ? " <strong>reponse</strong> " : "")
                            + '</h4>'
                            + '<small><i class="fa fa-clock-o"></i> 5 mins</small> ' + comefrom
                            + '<p>' + message.message + '</p>'
                            + '</a>'
                            + '</li>';

                    $(element).appendTo('#message-list-header').hide().fadeIn(300);
                });
                if (document.getElementsByClassName('.loadermsg-header')) {
                    $('.loadermsg-header').fadeOut(1000).remove();
                }
            }
        }
    };
    requete.send(null);
}

function loadMessage(obj) {
    var test = false;
    $("#message-chat-content").html('');
    var requete;
    var url = '../LoadMessage?id=' + obj;
    if (window.XMLHttpRequest) {
        requete = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        requete = new ActiveXObject("Microsoft.XMLHTTP");
    }
    requete.open("POST", url, true);
    requete.onreadystatechange = function () {
        if (requete.readyState === 4) {
            if (requete.status === 200) {
                var data = JSON.parse(requete.responseText);

                $.each(data, function (index, message) {
                    if (test === false) {
                        $("#message-chat-content").attr('data-user', data[0].todisplayid);
                        $("#message-chat-title").html(data[0].todisplayname);
                    }
                    var element = '';
                    if (message.comefrom === 1) {
                        element = '<div class="message-element right">'
                                + '<div class="message-text right">' + message.message + '</div>'
                                + '</div>';
                    } else {
                        element = '<div class="message-element left">'
                                + '<div class="message-text left">' + message.message + '</div>'
                                + '</div>';
                    }
                    $(element).appendTo("#message-chat-content");
                });
            }
        }
    };
    requete.send(null);
}

function keypressedsendMessage(event, val) {
    if (val === 1) {
        var keyCode = ('which' in event) ? event.which : event.keyCode;
        if (keyCode === 13) {
            if (!event.shiftKey && !event.ctrlKey && !event.altKey) {
                event.preventDefault();
                var message = $('#messagefrom').val();
                var receiver = $('#message-chat-content').attr('data-user');
                alert('send message <<' + message + '>> ' + receiver);
//            var datauser = $(obj).attr("data-user");
//            if ($.trim($('#message' + datauser).val())) {
//                sendMessage(datauser);
//            }
            }
        }
    }
    if (val === 2) {
        var message = $('#messagefrom').val();
        var receiver = $('#message-chat-content').attr('data-user');
        $('#messagefrom').val('');
        if ($.trim(message)) {
            sendMessage(receiver, message);
        }
    }
    if (val === 3) {
        var receiver = "";
        var selected = $("input[type='radio'][name='optionsRadios']:checked");
        var message = $('#msgelement').val();
        if (selected.length > 0) {
            receiver = selected.val();
            if ($.trim(message)) {
                sendMessage(receiver, message);
                $('#modalSendMessageTo').modal('hide');
            }
        }
    }
}
function keypressedsendMessage2(event, val) {
    if (val === 1) {
        var keyCode = ('which' in event) ? event.which : event.keyCode;
        if (keyCode === 13) {
            if (!event.shiftKey && !event.ctrlKey && !event.altKey) {
                event.preventDefault();
                var message = $('#messagefrom').val();
                var receiver = $('#message-chat-content').attr('data-user');
                alert('send message <<' + message + '>> ' + receiver);
//            var datauser = $(obj).attr("data-user");
//            if ($.trim($('#message' + datauser).val())) {
//                sendMessage(datauser);
//            }
            }
        }
    }
    if (val === 2) {
        var message = $('#messagefrom').val();
        var receiver = $('#message-chat-content').attr('data-user');
        $('#messagefrom').val('');
        if ($.trim(message)) {
            sendMessage(receiver, message);
        }
    }
    if (val === 3) {
        var receiver = "";
        var selected = $("input[type='radio'][name='optionsRadios']:checked");
        var message = $('#msgelement').val();
        if (selected.length > 0) {
            receiver = selected.val();
            if ($.trim(message)) {
                sendMessage(receiver, message);
                $('#modalSendMessageTo').modal('hide');
            }
        }
    }
    if (val === 4) {
        var message = $('#messageSent').val();
        var receiver = $('#receiver').val();
        $('#messageSent').val('');
        if ($.trim(message)) {
            sendMessage(receiver, message);
        }
    }
}