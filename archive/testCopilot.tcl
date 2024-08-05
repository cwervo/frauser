package require http
set url "http://example.com"
set token [http::geturl $url]
set html [http::data $token]
puts $html
http::cleanup $token
