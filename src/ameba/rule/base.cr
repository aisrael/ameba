module Ameba::Rule
  abstract struct Base
    include Config::Rule

    abstract def test(source : Source)

    prop enabled? = true

    def test(source : Source, node : Crystal::ASTNode)
      # can't be abstract
    end

    def catch(source : Source)
      source.tap { |s| test s }
    end

    def name
      self.class.name.gsub("Ameba::Rule::", "")
    end

    protected def self.subclasses
      {{ @type.subclasses }}
    end
  end

  def self.rules
    Base.subclasses
  end
end
