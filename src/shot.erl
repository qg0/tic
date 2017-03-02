-module(shot).
-behaviour(rest).
-include("core.hrl").
-compile({parse_transform, rest}).
-compile(export_all).
-export([post/1]).
-rest_record(shot).

get() ->
    ret(httpc:request(get,
        {"https://api.gdax.com/products/BTC-USD/book?level=3",
        [{"User-Agent","ticker"}]},[],[])).

post({D}) -> from_json(D,#shot{}).

ret({ok,{{_,C,_},_,A}}) when C>=200, C<300 -> post(jsone:decode(list_to_binary(A)));
ret({ok,{S,_,B}})                          -> #shot{};
ret(Error)                                 -> #shot{}.