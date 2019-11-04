require 'pry'
require './exceptions.rb'
class Processor
  
  def initialize(jobs: {})
    @jobs = jobs
    @ordered_jobs = []
    @job_queue = []
  end

  def validate
    validate_self_dependency
    validate_circular_dependency
  end

  def process
    @jobs.each do |job, dependency_job|
      order_jobs(job, depe ndency_job)
    end
    (@ordered_jobs |= @job_queue).uniq
    @ordered_jobs.join()
  end

  private

  def validate_self_dependency
    @jobs.each do|job, dependency_job|
      raise Exceptions::SelfDependencyError.new(
        "Job can not depend on itself."
      ) if job == dependency_job
    end
  end

  def validate_circular_dependency
    @jobs.each do|job, dependency|
      next if dependency.nil?
      job_set = Set.new()
      job_set.add(job)
      current_dependency = dependency
      while !@jobs[current_dependency].empty?
        raise Exceptions::CircularDependencyError.new(
          "Circular dependency found"
        ) if job_set.add?(current_dependency).nil?
        job_set.add(current_dependency)
        current_dependency = @jobs[current_dependency]
      end
    end
  end

  def order_jobs(job, dependency_job=nil)
    @job_queue.push(job) if @job_queue.empty?
    unless dependency_job.nil?
      @job_queue.unshift(dependency_job)
      return
    end
    @ordered_jobs |= @job_queue
    @job_queue = []
  end

end