require "minitest/autorun"
require './input_reader'
require './job_processor'

describe JobProcessor do

  it "return single job when only one job is given as input" do
    input_reader = InputReader.new("a => ")
    jobs = input_reader.clean_input()
    processor = JobProcessor.new(jobs: jobs)
    processor.validate()
    ordered_jobs = processor.process()
    assert_equal ordered_jobs, "a"
  end

  it "return job in same order when no dependency is given" do
    # {a =>, b => , c => } returns abc
    input_reader = InputReader.new("a =>, b => , c => ")
    jobs = input_reader.clean_input()
    processor = JobProcessor.new(jobs: jobs)
    processor.validate()
    ordered_jobs = processor.process()
    assert_equal ordered_jobs, "abc"
  end

  it "must put dependency job before" do
    # {a =>, b => c , c => } returns acb
    input_reader = InputReader.new("a =>, b => c, c => ")
    jobs = input_reader.clean_input()
    processor = JobProcessor.new(jobs: jobs)
    processor.validate()
    ordered_jobs = processor.process()
    assert_equal ordered_jobs, "acb"
  end

  it "must put dependency job before when multiple jobs have dependency" do
    input_reader = InputReader.new("a => , b => c, c => f, d => a, e => b, f => ")
    jobs = input_reader.clean_input()
    processor = JobProcessor.new(jobs: jobs)
    processor.validate()
    ordered_jobs = processor.process()
    assert_equal ordered_jobs, "afcbde"
  end

  it "must raise an error when job is self dependent" do
    input_reader = InputReader.new("a => , b => , c => c")
    jobs = input_reader.clean_input()
    processor = JobProcessor.new(jobs: jobs)
    error = assert_raises Exceptions::SelfDependencyError do
      processor.validate()
    end
    assert_equal error.message, "A Job can not depend on itself."
  end

  it "must raise an error when there is a circular dependency" do
    input_reader = InputReader.new("a => b, b => c, c => a")
    jobs = input_reader.clean_input()
    processor = JobProcessor.new(jobs: jobs)
    error = assert_raises Exceptions::CircularDependencyError do
      processor.validate()
    end
    assert_equal error.message, "Circular dependency found"
  end

end