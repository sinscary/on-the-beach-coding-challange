module Exceptions
  class SelfDependencyError < StandardError

  end

  class CircularDependencyError < StandardError

  end
end