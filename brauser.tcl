#! /usr/bin/tclsh
package require tdom
package require http

set url "http://example.com"
set token [http::geturl $url]
set html [http::data $token]

# 1. Parse the HTML into a DOM graph
puts $url
puts "========="
puts $html

# # Step 2: Read HTML content (assuming from a file)
# set htmlFile "path/to/your/file.html"
# set htmlContent [read [open $htmlFile]]

# Step 3: Parse the HTML content into a DOM graph
set dom [dom parse -html $html]

# Step 4: Optionally, print the DOM structure
set dom_xml [$dom asXML]
puts $dom_xml

# New function to print DOM as ASCII graph
proc print_dom_ascii {node {prefix ""}} {
    puts "${prefix}[string tolower [$node nodeName]]"
    foreach child [$node childNodes] {
        if {[$child nodeType] == "ELEMENT_NODE"} {
            print_dom_ascii $child "${prefix}  |--"
        }
    }
}

# Print the DOM as an ASCII graph
puts "\nDOM Structure as ASCII graph:"
print_dom_ascii [$dom documentElement]

# 2. Print it out as an ASCII diagram (valid Dot format probably, to start)

http::cleanup $token