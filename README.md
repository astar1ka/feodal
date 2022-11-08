# feodal

getMap

/api?method=getMap&token=XXX

Входные параметры:
token - токен пользователя, если пользователь не авторизован, запрос вернет ошибку.

Ответ:
data: 
    {"map":
        {
            "layer1": "[x,x,x,x]",
            "layer2": "[x,x,x,x]",
            "layer3": "[x,x,x,x]"
        }
    }