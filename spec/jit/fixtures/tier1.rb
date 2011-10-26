module JITSpecs
  class Tier1Specs
    def none
      nil
    end

    def one(arg)
      arg
    end

    def strlit
      "hello"
    end

    def str_build(obj)
      "-#{obj}-"
    end

    dynamic_method :check_frozen do |g|
      g.push :self
      g.check_frozen
      g.pop
      g.push :nil
      g.ret
    end

    def equal_compare(a, b)
      a == b
    end
  end
end
