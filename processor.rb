require 'pry'
require './exceptions.rb'
class Processor
  
  def initialize(jobs: {})
    @jobs = jobs
    @ordered_jobs = []
    @job_queue = []
  end

  def process
    @jobs.each do |job, dependency_job|
      raise Exceptions::SelfDependencyError.new(
        "Job can not depend on itself."
      ) if job == dependency_job
      raise Exceptions::CircularDependencyError.new(
        "Circular dependency found"
      ) if @job_queue.include?(dependency_job)
      order_jobs(job, dependency_job)
    end
    (@ordered_jobs |= @job_queue).uniq
    @ordered_jobs.join()
  end

  private
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