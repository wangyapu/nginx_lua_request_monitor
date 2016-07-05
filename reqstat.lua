--
-- yapu.wang@dianping.com
-- Created by wangyapu on 2016/07/05 15:29.
--

-- 共享内存statistics_dict记录所有监控数据
statistics_dict = ngx.ngx.shared.statistics_dict
local stat_util = require("stat_util")

-- query conut
function query_count(identifier)
    local query_count_key = identifier .. "query_counter"

    local new_value, err = stat_util.incr(statistics_dict, query_count_key, 1)
    if not new_value and err == "not found" then
        statistics_dict:add(query_count_key, 0, 86400)
        stat_util.incr(statistics_dict, query_count_key, 1)
    end
end

-- request time count
function request_time_count(identifier)
    local request_time_count_key = identifier .. "request_time_counter"
    local current_request_time = tonumber(ngx.var.request_time) or 0
    local pre_sum = statistics_dict:get(request_time_count_key) or 0
    local sum = pre_sum + current_request_time
    statistics_dict:set(request_time_count_key, sum, 86400)
end

-- request 4xx code count
function request_4xx_code_count(identifier)
    local status_code = tonumber(ngx.var.status)
    local request_4xx_count_key = identifier .. "4xx_code_count"

    if status_code >= 400 and status_code < 500 then
        local new_value, err = statistics_dict:incr(request_4xx_count_key, 1)
        if not new_value and err == "not found" then
            statistics_dict:add(request_4xx_count_key, 0, 86400)
            stat_util.incr(statistics_dict, request_4xx_count_key, 1)
        end
    end
end

-- request 5xx code count
function request_4xx_code_count(identifier)
    local status_code = tonumber(ngx.var.status)
    local request_5xx_count_key = identifier .. "5xx_code_count"

    if status_code >= 500 then
        local new_value, err = statistics_dict:incr(request_5xx_count_key, 1)
        if not new_value and err == "not found" then
            statistics_dict:add(request_5xx_count_key, 0, 86400)
            stat_util.incr(statistics_dict, request_5xx_count_key, 1)
        end
    end
end

