function RequestManager() {
    var _this = this;
    setInterval(function() { _this.tick(); }, 1000);
    this.requests = []
    this.div = document.createElement("div");
    //this.div.classList.add("request_manager");
    document.body.appendChild(this.div);
}

tipos = {
    ["Hospistal"]: { nome: "MÉDICO", hex: "#491cdccf" },
    ["Policia"]: { nome: "POLICIA", hex: "#dc2c1c" },
    ["Mecanico"]: { nome: "MECANICO", hex: "#dcbc1c" },
}

RequestManager.prototype.buildText = function(text, time, type, caller) {
    text = text.replace(/<b>/g, "");
    text = text.replace(/<\/b>/g, "");
    return ` 
    <div class="main-menu-wrapper"> 
    <div class="menu-wrapper"> 
    <style>
    *{font-family: "Roboto Condensed", sans-serif; padding: 0; margin: 0; text-rendering: optimizeLegibility; -webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;}
    .menu-wrapper{width: 340px; height: 100%; position: relative; float: right;}
    .container{width: 300px; margin: 20px 20px 0 0px; color: white; float: right; position: relative;}
    .header{display: flex; width: 300px; opacity: 0.8 !important;}
    .title-left{width: 100px; justify-content: left; opacity: 0.8!important; background: ${tipos[type] ? tipos[type].hex : '#491cdccf' }; font-size: 0.7rem; padding: 4px 10px; color: #ffffffb5; display: flex; flex-direction: column; margin-bottom: 1px; margin-right: 1px;}
    .title-right{width: 180px; justify-content: left; opacity: 0.8!important; background: rgb(0 0 0 / 92%)!important; font-size: 0.7rem; padding: 4px 10px; color: #ffffffb5; display: flex; flex-direction: column; margin-bottom: 1px;}
    .row-center{justify-content: space-between; opacity: 0.8!important; background: rgba(0, 0, 0, 0.6)!important; font-size: 0.7rem; padding: 6px 10px; color: #fff; display: flex; flex-direction: column; margin-bottom: 1px;}
    .row-bottom{opacity: 0.8!important; background: rgb(0 0 0 / 72%)!important; font-size: 0.7rem; padding: 10px 10px 20px; color: #fff; display: flex; flex-direction: column; margin-bottom: 1px;}.sub-menu{width: 100px; float: right;}.acoes{opacity: 0.5!important; background: rgb(0 0 0 / 82%)!important; font-size: 10px; padding: 3px 5px; color: #fff; width: 90px; margin-bottom: 1px;}.row-aceitar{opacity: 0.8 !important; display: flex; justify-content: space-between; margin-bottom: 1px;}.row-aceitar p{padding: 5px;}.button-f7{width: 22px; display: flex; flex-direction: column; opacity: 0.7!important; background: rgba(0, 0, 0, 0.9)!important; font-size: 12px; padding: 6px; color: #fff; text-align: center; margin-left: 1px;}.row-rejeitar{display: flex; justify-content: space-between; opacity: 0.7 !important;}.row-rejeitar p{padding: 5px;}.button-f6{display: flex; flex-direction: column; opacity: 0.7!important; background: rgba(0, 0, 0, 0.9)!important; font-size: 12px; padding: 6px; color: #fff; text-align: center; margin-left: 1px; width: 22px;}.card-title{font-weight: 100; font-size: 10px; opacity: 0.7;}.card-text{font-weight: 400; font-size: 11px;}.rejeitar{opacity: 0.7!important; background: rgba(0, 0, 0, 0.9)!important; font-size: 12px; padding: 6px 12px; color: #fff; width: 43px;}.aceitar{opacity: 0.7!important; background: rgba(0, 0, 0, 0.9)!important; font-size: 12px; padding: 6px 12px; color: #fff; width: 47px;}.time{background: rgb(0 0 0 / 53%)!important; height: 4px; margin-bottom: 1px; width: 83%; float: right; min-height: 4px;}.header-confirmacao{width: 100px; justify-content: left; opacity: 0.8!important; background: #1d9900cf; font-size: 0.7rem; padding: 4px 10px; color: #ffffffb5; display: flex; flex-direction: column; margin-bottom: 1px; margin-right: 1px;}.notify-header{justify-content: left; opacity: 0.8!important; background: rgb(0 0 0 / 81%)!important; font-size: 0.7rem; padding: 4px 10px; color: #ffffffb5; display: flex; flex-direction: column; margin-bottom: 1px; width: 100%;}@-webkit-keyframes pulse{0%{-webkit-box-shadow: 0 0 0 0 rgba(204, 169, 44, 0.4);}70%{-webkit-box-shadow: 0 0 0 10px rgba(204, 169, 44, 0);}100%{-webkit-box-shadow: 0 0 0 0 rgba(204, 169, 44, 0);}}@keyframes pulse{0%{-moz-box-shadow: 0 0 0 0 rgba(204, 169, 44, 0.4); box-shadow: 0 0 0 0 rgba(204, 169, 44, 0.4);}70%{-moz-box-shadow: 0 0 0 10px rgba(204, 169, 44, 0); box-shadow: 0 0 0 10px rgba(204, 169, 44, 0);}100%{-moz-box-shadow: 0 0 0 0 rgba(204, 169, 44, 0); box-shadow: 0 0 0 0 rgba(204, 169, 44, 0);}}</style> 
    <div class="container" id="requestextra"> 
    <div class="time"></div><div class="header "> 
    <p class="title-left">${tipos[type] ? tipos[type].nome : 'SYSTEMA' }</p><p class="title-right">${tipos[type] ? 'CHAMADO' : 'CONFIRMACAO' }</p></div><div class="row-center "> 
    <p class="card-title">TEMPO PARA ACEITAR</p><p class="card-text">${time}</p></div><div class="row-center "> 
    ${tipos[type] ? ' <p class="card-title">QUEM FEZ O CHAMADO</p><p class="card-text">'+ caller + '</p></div><div class="row-bottom">' : '' }
    <p class="card-title">DESCRITIVO</p>
    <p class="card-text">${text}</p>
    </div>
    <div class="sub-menu "> 
    <div class="acoes ">AÇÔES</div>
    <div class="row-aceitar "> 
    <div class="aceitar">ACEITAR</div>
    <div class="button-f7 ">Y</div></div>
    <div class="row-rejeitar"> 
    <div class="rejeitar">REJEITAR</div>
    <div class="button-f6 ">U</div></div></div></div></div></div>`
}

RequestManager.prototype.addRequest = function(id, text, time, type, caller) {
    var request = {}
    request.div = document.createElement("div");
    request.id = id;
    request.time = time - 1;
    request.text = text;
    request.tipo = type;
    request.caller = caller;
    request.div.innerHTML = this.buildText(text, time - 1, type, caller);
    this.requests.push(request);
    this.div.appendChild(request.div);
}

RequestManager.prototype.respond = function(ok) {
    if (this.requests.length > 0) {
        var request = this.requests[0];
        if (this.onResponse)
            this.onResponse(request.id, ok);
        this.div.removeChild(request.div);
        this.requests.splice(0, 1);
    }
}

RequestManager.prototype.tick = function() {
    for (var i = this.requests.length - 1; i >= 0; i--) {
        var request = this.requests[i];
        request.time -= 1;
        request.div.innerHTML = this.buildText(request.text, request.time, request.tipo, request.caller);
        if (request.time <= 0) {
            this.div.removeChild(request.div);
            this.requests.splice(i, 1);
        }
    }
}