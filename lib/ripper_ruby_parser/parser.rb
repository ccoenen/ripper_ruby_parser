require 'ripper_ruby_parser/commenting_sexp_builder'
require 'ripper_ruby_parser/sexp_processor'
require 'ripper-plus'

module RipperRubyParser
  # Main parser class. Brings together Ripper and our
  # RipperRubyParser::SexpProcessor.
  class Parser
    def initialize processor=SexpProcessor.new
      @processor = processor
    end

    def parse source, filename='(string)', lineno=1
      parser = CommentingSexpBuilder.new(source, filename, lineno)
      arr = RipperPlus.for_ripper_ast(parser.parse)
      exp = Sexp.from_array(arr)
      @processor.filename = filename
      @processor.process exp
    end
  end
end

