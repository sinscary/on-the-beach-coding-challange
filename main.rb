require './data_reader/input_reader'
require './models/job_processor'

input_reader = InputReader.new("a => b, b => c, c => f, d => a, e => f, f => ")
jobs = input_reader.clean_input()
processor = JobProcessor.new(jobs: jobs)
processor.validate()
puts processor.process()