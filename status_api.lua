--
-- Created by IntelliJ IDEA.
-- User: wangyapu
-- Date: 16/7/4
-- Time: 下午4:58
-- To change this template use File | Settings | File Templates.
--

local request_monitor = {}

local function incr(dict, key, increment)
    increment = increment or 1
    local new_value, err = dict.incr()
    if err then
        dict:set(key, increment)
        new_value = increment
    end
    return new_value
end