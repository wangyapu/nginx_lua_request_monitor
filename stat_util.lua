--
-- yapu.wang@dianping.com
-- Created by wangyapu on 2016/07/05 15:29.
--

function incr(dict, key, increment)
    increment = increment or 1
    local new_value, err = dict.incr()
    if err then
        dict:set(key, increment)
        new_value = increment
    end
    return new_value
end

function empty(dict)
    dict:flush_all()
    dict:flush_expired()
end

function show(dict)
    for index, key in pairs(dict:get_keys(10240)) do
        ngx.say(key, " | ", dict:get(key))
    end
end
