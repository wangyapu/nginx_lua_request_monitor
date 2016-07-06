--
-- yapu.wang@dianping.com
-- Created by wangyapu on 2016/07/05 15:29.
--

local stat_util = {}

function stat_util.incr(dict, key, increment)
    increment = increment or 1
    local new_value, err = dict:incr(key, increment)
    if err then
        dict:set(key, increment)
        new_value = increment
    end
    return new_value
end

function stat_util.empty(dict)
    dict:flush_all()
    dict:flush_expired()
end

function stat_util.show(dict)
    for index, key in pairs(dict:get_keys(10240)) do
        ngx.say(key, " | ", dict:get(key))
    end
end

function stat_util.showByDomainAndType(dict, type, domain)
    ngx.say("Server Name key:", domain)
    local identifier = "site." .. domain
    if type == "all" or not type then
        ngx.say("Request Count:", dict:get(identifier .. "__query_count") or 0)
        ngx.say("Request Time Sum:", dict:get(identifier .. "__request_time_count") or 0)
        ngx.say("Flow Sum:", dict:get(identifier .. "__bytes_sent_count") or 0)
        ngx.say("4xx Code Count:", dict:get(identifier .. "__4xx_code_count") or 0)
        ngx.say("5xx Count Count:", dict:get(identifier .. "__5xx_code_count") or 0)
        ngx.exit(ngx.HTTP_OK)
    elseif type == "reqc" then
        ngx.say("Request Count:", dict:get(identifier .. "__query_count") or 0)
        ngx.exit(ngx.HTTP_OK)
    elseif type == "reqt" then
        ngx.say("Request Time Sum:", dict:get(identifier .. "__request_time_count") or 0)
        ngx.exit(ngx.HTTP_OK)
    elseif type == "flow" then
        ngx.say("Flow Sum:", dict:get(identifier .. "__bytes_sent_count") or 0)
        ngx.exit(ngx.HTTP_OK)
    elseif type == "4xx" then
        ngx.say("4xx Code Count:", dict:get(identifier .. "__4xx_code_count") or 0)
        ngx.exit(ngx.HTTP_OK)
    elseif type == "5xx" then
        ngx.say("5xx Code Count:", dict:get(identifier .. "__5xx_code_count") or 0)
        ngx.exit(ngx.HTTP_OK)
    else
        ngx.say("type is error!")
        ngx.exit(ngx.HTTP_OK)
    end
end

return stat_util