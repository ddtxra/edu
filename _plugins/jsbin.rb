# Title: jsbin tag for Jekyll
# Author: Remy Sharp (@rem)
# Description:
#   Given a bin url, generates the embed code for jsbin with defined panels.
#   A bin url is either just the code: `abcefg` or you can include the revision
#   `abcefg/4` or you can point to latest: `abcefg/latest`
#
# Panels: html, js, css, console, output (default: html,css,js,output)
#
# Syntax: {% jsbin bin %}
#
# Examples:
#
# Input: {% jsbin exedab %}
# Output: <a class="jsbin-embed" href="http://jsbin.com/exedab/1/embed?output">JS Bin</a><script src="http://static.jsbin.com/js/embed.js"></script>
#
# Input: {% jsbin exedab js,html %}
# Output: <a class="jsbin-embed" href="http://jsbin.com/exedab/1/embed?js,html">JS Bin</a><script src="http://static.jsbin.com/js/embed.js"></script>
#
module Jekyll
  class JSBin < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      if /(?<jsbin>[^\s\/]+)(\/(?<revision>[\w\/]+))?(?:\s+(?<sequence>[\w,&=]+))?/ =~ markup
        @bin = jsbin
        puts jsbin
        @revision = revision || 'latest'
        puts revision
        @sequence = (sequence unless sequence == 'all') || 'html,css,js,output'
      end
    end

    def render(context)
      if @bin
        if @bin == "gist"
link = <<HTML
<a class="jsbin-embed" href="http://gist.jsbin.com/#{@revision}/embed?#{@sequence}">JS Bin</a>
HTML
        else
link = <<HTML
<a class="jsbin-embed" href="http://jsbin.com/#{@bin}/#{@revision}/embed?#{@sequence}">JS Bin</a>
HTML
      end
      link = link + '<script src="http://static.jsbin.com/js/embed.js"></script> '
      puts link
      return link
      else
        "Error processing input, expected syntax: {% jsbin bin [panels] %}"
      end
    end
  end
end

Liquid::Template.register_tag('jsbin', Jekyll::JSBin)
