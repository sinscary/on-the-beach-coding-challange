require './input_reader'
require './job_processor'

input_reader = InputReader.new("a => b, b => d, c => a, d => a, e => f, f => ")
jobs = input_reader.clean_input()
processor = JobProcessor.new(jobs: jobs)
processor.validate()
puts processor.process()