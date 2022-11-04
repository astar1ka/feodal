class Server {
    constructor() {
        this.token;
    }

    async send(params = {}) {
        if (this.token) {
            params.token = this.token;
        }
        const query = Object.keys(params)
            .map(key => `${key}=${params[key]}`).join('&');
        const responce = await fetch(`api/?${query}`);
        const answer = await responce.json();
        return answer?.result === 'ok' ? answer?.data : null;
    }

    async registration(login, password, name) {
        if (login && password && name) {
            const data = await this.send({ method: 'registration', login, password, name });
            if (data) {
                return true;
            }
        }
    }

    async login(login, password) {
        if (login && password) {
            const data = await this.send({ method: 'login', login, password });
            if (data?.token) {
                this.token = data.token;
                delete data.token;
            }
            return data;
        }
    }

    async logout() {
        const data = await this.send({ method: 'logout'});
        if (data) {
            this.token = '';
        }
        return data;
    }

    async sendMessage(message, to) {
        const data = await this.send({ method: 'sendMessage', message, to});
        if (data?.hash) {
            this.hashChat = data.hash;
            delete data.hash;
        }
        return data;
    }

    async getMessages() {
        const data = await this.send({ 
            method: 'getMessages',
            hash : this.hashChat
    });
        return data.messages;
    }
}