--
-- yapu.wang@dianping.com
-- Created by wangyapu on 2016/07/05 15:29.
--

local statistics_dict = ngx.shared.statistics_dict
local stat_util = require("stat_util")

local uri_args = ngx.req.get_uri_args()
local server_name = uri_args["domain"]
local type = uri_args["type"]

if server_name then
    stat_util.showByDomainAndType(statistics_dict, type, server_name)
else
    stat_util.show(statistics_dict)
end


