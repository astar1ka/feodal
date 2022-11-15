window.onload = function () {

    let chatInterval;
    const server = new Server;

    function hide(el) {
        el.classList.add("hidden");
    }

    function show(el) {
        el.classList.remove("hidden");
    }

    function goLogin() {
        show(document.getElementById("chatScreen"));
        show(document.getElementById("logoutScreen"));
        hide(document.getElementById("loginScreen"));
        chatInterval = setInterval(getMessages, 1000);
    }

    async function sendLogin() {
        const login = document.getElementById('login').value;
        const password = document.getElementById('password').value;
        const data = await server.login(login, password);
        if (data) {
            goLogin();
        }
    }

    function goLogout() {
        show(document.getElementById("loginScreen"));
        hide(document.getElementById("chatScreen"));
        hide(document.getElementById("logoutScreen"));
        clearInterval(chatInterval);
    }

    async function logout() {
        const data = await server.logout();
        if (data) {
            goLogout();
        }
    }


    async function registration() {
        const login = document.getElementById('newLogin').value;
        const password = document.getElementById('newPassword').value;
        const name = document.getElementById('newName').value;
        if (name && login && password) {
            const data = await server.registration(login, password, name);
            if (data) {
                cancelRegistration();
            }
        }
    }

    function goRegistration() {
        show(document.getElementById("registrationScreen"));
        hide(document.getElementById("loginScreen"));
    }

    function cancelRegistration() {
        hide(document.getElementById("registrationScreen"));
        show(document.getElementById("loginScreen"));
    }

    async function getMessages() {
        const data = await server.getMessages();
        if (data) {
            document.getElementById('chat').value = '';
            data.forEach(el => {
                document.getElementById('chat').value +=el.name + ': ' + el.message+`\n`;
            });
            
        }
    }

    async function sendMessage(){
        const message = document.getElementById('newMessage').value;
        const data = await server.sendMessage(message,0);
        if (data) {
            document.getElementById('newMessage').value = '';
        }
    }

    document.getElementById('buttonLogin').addEventListener('click', sendLogin);
    document.getElementById('buttonLogout').addEventListener('click', logout);
    document.getElementById('buttonRegistration').addEventListener('click', goRegistration);
    document.getElementById('cancelRegistration').addEventListener('click', cancelRegistration);
    document.getElementById('registration').addEventListener('click', registration);
    document.getElementById('sendMessage').addEventListener('click', sendMessage);
}