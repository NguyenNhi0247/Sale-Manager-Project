import Vue from 'vue'
import { axiosConfig } from './utils'
import { eventBus } from './event'

let emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

Vue.mixin({
    filters: {
        toPrettyJSON(val) {
            return JSON.stringify(val, null, 2)
        },
        toFixedFPs(val, floatingPoints) {
            return +parseFloat(val).toFixed(floatingPoints)
        },
        upperFirstChar(val) {
            return val.charAt(0).toUpperCase() + val.slice(1)
        }
    },
    methods: {
        cloneObject(obj) {
            return JSON.parse(JSON.stringify(obj))
        },
        isValidEmail(email) {
            return emailRegex.test(email)
        },
        setCookie(name, value) {
            let expires = "";
            let date = new Date();
            date.setTime(date.getTime() + (7 * 24 * 60 * 60 * 1000)); // Default 7 days 
            expires = "; expires=" + date.toUTCString();
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        },
        getCookie(name) {
            let value = '; ' + document.cookie
            let parts = value.split('; ' + name + '=')
            if (parts.length === 2) {
                return parts.pop().split(';').shift()
            }
        },
        deleteCookie(name, domain, path) {
            if (!domain) {
                domain = window.location.hostname
            }
            if (!path) {
                path = '/'
            }
            document.cookie = `${name}=; Max-Age=0`
            document.cookie = `${name}=; Path=${path}; Domain=${domain}; Max-Age=0`
        },
        getAuthHeader() {
            let token = this.getCookie("beanies_token")
            let cfg = this.cloneObject(axiosConfig)
            cfg.headers["Authorization"] = `Bearer ${token}`
            return cfg
        },
        showError(err, msg) {
            console.log(err);
            let em = err.message;
            if (err.response) {
                em = err.response.data.message;
            }
            if (!em) {
                msg = msg + " " + em
            }
            eventBus.snackbarShown({
                type: "error",
                msg: msg
            });
        }
    }
})
