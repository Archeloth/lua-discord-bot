local discordia = require('discordia')
local client = discordia.Client()
local coro = require('coro-http')
local json = require('json')


function RandomDog()
    local result, body = coro.request('GET', 'https://dog.ceo/api/breeds/image/random')
    body = json.parse(body)
    if body['status'] == 'success' then
        return body['message']
        --local f = assert(io.open('dog.jpg', 'w'))
        --f:write(body['message'])
        --f:close()
    end
end


client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content:lower() == '!ping' then
		message.channel:send('Pong!')
    end
    if message.content:lower() == '!dog' then
        local imageurl = RandomDog()
        message.channel:send {
            content = 'You requested a puppy '..imageurl,
            mention = message.author,
        }
    end
end)

client:run("Bot "..io.open("./login.txt"):read())