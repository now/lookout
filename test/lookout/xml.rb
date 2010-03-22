# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::XML.new("<foo>bar</foo>").to.be.==("<foo>bar</foo>")
  expect Lookout::XML.new("<foo>not bar</foo>").not.to.be.==("<foo>bar</foo>")
  expect Lookout::XML.new("<not-foo>bar</not-foo>").not.to.be.==("<foo>bar</foo>")

  expect true do
    Lookout::XML.new("<foo>bar</foo>") == "  <foo>bar</foo>  "
  end

  expect true do
    Lookout::XML.new("  <foo>bar</foo>  ") == "<foo>bar</foo>"
  end

  expect true do
    Lookout::XML.new("<foo>bar</foo>") == "<foo>bar</foo>\n"
  end

  expect true do
    Lookout::XML.new("\n<foo>bar</foo>") == "<foo>bar</foo>"
  end

  expect true do
    Lookout::XML.new("\t<foo>bar</foo>") == "<foo>bar</foo>"
  end

  expect true do
    Lookout::XML.new("<foo>bar</foo>") == "<foo>bar</foo>\t"
  end

  expect true do
    Lookout::XML.new("<a>\n<foo>bar</foo>") == "<a><foo>bar</foo>"
  end

  expect true do
    Lookout::XML.new("<a>\n<foo>\t \n bar</foo>") == "<a><foo>\t \n bar</foo>"
  end

  expect true do
    Lookout::XML.new("<a>\n<foo>\t \n bar</foo>\n \t </a>") == "<a><foo>\t \n bar</foo></a>"
  end

  expect true do
    Lookout::XML.new("<fragment>content</fragment>") == "<container><fragment>content</fragment></container>"
  end

  expect true do
    Lookout::XML.new('<?xml version="1.0"?>') == '<?xml version="1.0"?>'
  end

  expect 'xml(<fragment>content</fragment>)' do
    Lookout::XML.new("  \t<fragment>content</fragment>\n  ").inspect
  end
end
