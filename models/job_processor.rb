require 'set'
require './exceptions/exceptions.rb'
class JobProcessor
  
  def initialize(jobs: {})
    @jobs = jobs
    @ordered_jobs = []
  end

  def validate
    validate_self_dependency
    validate_circular_dependency
  end

  def process
    @jobs.each do |job, dependency_job|
      order_jobs(job, dependency_job)
    end
    @ordered_jobs.join()
  end

  private

  def validate_self_dependency
    @jobs.each do|job, dependency_job|
      raise Exceptions::SelfDependencyError.new(
        "A Job can not depend on itself."
      ) if job == dependency_job
    end
  end

  def validate_circular_dependency
    @jobs.each do|job, dependency|
      next if dependency.nil?
      job_set = Set.new()
      job_set.add(job)
      current_dependency = dependency
      while !@jobs[current_dependency].nil?
        raise Exceptions::CircularDependencyError.new(
          "Circular dependency found"
        ) if job_set.add?(current_dependency).nil?
        job_set.add(current_dependency)
        current_dependency = @jobs[current_dependency]
      end
    end
  end

  def order_jobs(job, dependency_job=nil)
    @ordered_jobs.push(job) unless @ordered_jobs.include?(job)
    job_index = @ordered_jobs.index(job)
    unless @ordered_jobs.include?(dependency_job) && @ordered_jobs.index(dependency_job) < job_index
      @ordered_jobs.insert(job_index, dependency_job).uniq!
    end
  end

end