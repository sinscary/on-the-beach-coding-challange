require 'pry'
class InputReader

  def initialize(input)
    @input = input
  end

  def clean_input
    jobs_map = {}
    jobs = @input.split(',').map { |job| job.strip }
    jobs.each do|job|
      current_job_data = job.split(" ")
      current_job = current_job_data[0]
      current_dependency = current_job_data[-1] == "=>" ? nil : current_job_data[-1]
      jobs_map[current_job] = current_dependency
    end
    jobs_map
  end

end