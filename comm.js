

function signin(userName,userPass) {
    console.log("========>>>>>>>>>>signin>>>>>>>>>>>>=======")
    var authReq = new XMLHttpRequest;
    var jsonResponse={}
    authReq.open("PUT", "http://127.0.0.1:8087/api/signin",false);
    authReq.setRequestHeader("Content-Type", "text/plain; charset=utf-8");
    authReq.setRequestHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    authReq.onreadystatechange = function() {
       try{
            if (authReq.readyState === XMLHttpRequest.DONE) {
                console.log(authReq.responseText)
                jsonResponse = JSON.parse(authReq.responseText);
                console.log("authReq.responseText",jsonResponse.err_code)
            }
       }catch(err){
            console.log(err)
            jsonResponse.err_code="99999"
       }
    }
    var req={login_name:userName,login_pass:userPass}
    authReq.send(JSON.stringify(req));
    console.log("========<<<<<<<<<<signin<<<<<<<<<<<<=======")
    return  jsonResponse
}


function checkUser(userName) {
    console.log("========>>>>>>>>>>checkUser>>>>>>>>>>>>=======")
    var authReq = new XMLHttpRequest;
    var jsonResponse={}
    authReq.open("PUT", "http://127.0.0.1:8087/api/getaccount",false);
    authReq.setRequestHeader("Content-Type", "text/plain; charset=utf-8");
    authReq.setRequestHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    authReq.onreadystatechange = function() {
       try{
            if (authReq.readyState === XMLHttpRequest.DONE) {
                console.log(authReq.responseText)
                jsonResponse = JSON.parse(authReq.responseText);
                console.log("authReq.responseText",jsonResponse.err_code)
            }
       }catch(err){
            console.log(err)
            jsonResponse.err_code="99999"
       }
    }
    var req={login_name:userName}
    authReq.send(JSON.stringify(req));
    console.log("========<<<<<<<<<<checkUser<<<<<<<<<<<<=======")
    return  jsonResponse
}



function verifyAnswer(userName,problem,answer) {
    console.log("========>>>>>>>>>>verifyAnswer>>>>>>>>>>>>=======")
    var authReq = new XMLHttpRequest;
    var jsonResponse={}
    authReq.open("PUT", "http://127.0.0.1:8087/api/verifyanswer",false);
    authReq.setRequestHeader("Content-Type", "text/plain; charset=utf-8");
    authReq.setRequestHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    authReq.onreadystatechange = function() {
       try{
            if (authReq.readyState === XMLHttpRequest.DONE) {
                console.log(authReq.responseText)
                jsonResponse = JSON.parse(authReq.responseText);
                console.log("authReq.responseText",jsonResponse.err_code)
            }
       }catch(err){
            console.log(err)
            jsonResponse.err_code="99999"
       }
    }
    var req={login_name:userName,pass_problem:problem,pass_answer:answer}
    authReq.send(JSON.stringify(req));
    console.log("========<<<<<<<<<<verifyAnswer<<<<<<<<<<<<=======")
    return  jsonResponse
}



function signup(userName,userPwd,problem,answer,userImage) {
    console.log("========>>>>>>>>>>signup>>>>>>>>>>>>=======")
    var authReq = new XMLHttpRequest;
    var jsonResponse={}
    authReq.open("PUT", "http://127.0.0.1:8087/api/signup",false);
    authReq.setRequestHeader("Content-Type", "text/plain; charset=utf-8");
    authReq.setRequestHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    authReq.onreadystatechange = function() {
       try{
            if (authReq.readyState === XMLHttpRequest.DONE) {
                console.log(authReq.responseText)
                jsonResponse = JSON.parse(authReq.responseText);
                console.log("authReq.responseText",jsonResponse.err_code)
            }
       }catch(err){
            console.log(err)
            jsonResponse.err_code="99999"
       }
    }
    var req={login_name:userName,login_pass:userPwd,pass_problem:problem,pass_answer:answer,head_image:userImage}
    console.log(JSON.stringify(req))
    authReq.send(JSON.stringify(req));

    console.log("========<<<<<<<<<<signup<<<<<<<<<<<<=======")
    return  jsonResponse
}



function reset(userName,userPass) {
    console.log("========>>>>>>>>>>reset>>>>>>>>>>>>=======")
    var authReq = new XMLHttpRequest;
    var jsonResponse={}
    authReq.open("PUT", "http://127.0.0.1:8087/api/resetpwd",false);
    authReq.setRequestHeader("Content-Type", "application/json");
    authReq.onreadystatechange = function() {
       try{
            if (authReq.readyState === XMLHttpRequest.DONE) {
                console.log(authReq.responseText)
                jsonResponse = JSON.parse(authReq.responseText);
                console.log("authReq.responseText",jsonResponse.err_code)
            }
       }catch(err){
            console.log(err)
            jsonResponse.err_code="99999"
       }
    }
    var req={login_name:userName,login_pass:userPass,pass_problem:problem,pass_answer:problemAnswer}
    console.log(JSON.stringify(req))
    authReq.send(JSON.stringify(req));
    return jsonResponse
}

function initDatabase() {
     var db;
    db = Sql.LocalStorage.openDatabaseSync("ArmyFight", "1.0", "A box who remembers its position", 100000);
    db.transaction( function(tx) {
         tx.executeSql('CREATE TABLE IF NOT EXISTS user(name TEXT, value TEXT)');
    });
}

function readData() {
    var db;
    var value
    db = Sql.LocalStorage.openDatabaseSync("ArmyFight", "1.0", "A box who remembers its position", 100000);
    db.transaction( function(tx) {
        var result = tx.executeSql('select * from user where name="loginUser"');
        if(result.rows.length >0) {
            value = result.rows[0].value;
        }
    });
    return value
}

function storeData(userValue) {
    var db;
    db = Sql.LocalStorage.openDatabaseSync("ArmyFight", "1.0", "A box who remembers its position", 100000);
    db.transaction( function(tx) {
        var result = tx.executeSql('SELECT * from user where name ="loginUser"');
        // prepare object to be stored as JSON
        console.log(result.rows.length )
        if(result.rows.length >0) {// use update
            result = tx.executeSql('UPDATE user set value=? where name="loginUser"', [userValue]);
        } else { // use insert
            result = tx.executeSql('INSERT INTO user VALUES (?,?)', ['loginUser', userValue]);
           console.log(userValue,"=======",result)
        }
    });
}




function test() {
   console.log("=========>test")
}


