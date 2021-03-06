require File.expand_path('../test_helper.rb', File.dirname(__FILE__))

describe RipperRubyParser::Parser do
  describe "#parse" do
    describe "for calls to super" do
      specify { "super".must_be_parsed_as s(:zsuper) }
      specify { "super foo".must_be_parsed_as s(:super,
                                                s(:call, nil, :foo, s(:arglist))) }
      specify {
        "super foo, bar".must_be_parsed_as s(:super,
                                             s(:call, nil, :foo, s(:arglist)),
                                             s(:call, nil, :bar, s(:arglist))) }
      specify {
        "super foo, *bar".must_be_parsed_as s(:super,
                                              s(:call, nil, :foo, s(:arglist)),
                                              s(:splat,
                                                s(:call, nil, :bar, s(:arglist)))) }
      specify {
        "super foo, *bar, &baz".
          must_be_parsed_as s(:super,
                              s(:call, nil, :foo, s(:arglist)),
                              s(:splat, s(:call, nil, :bar, s(:arglist))),
                              s(:block_pass, s(:call, nil, :baz, s(:arglist)))) }
    end
  end
end

