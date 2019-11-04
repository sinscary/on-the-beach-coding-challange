require './input_reader'
require './processor'

input_reader = InputReader.new("a => b, b => d, c => a, d => a, e => f, f => ")
jobs = input_reader.clean_input()
processor = Processor.new(jobs: jobs)
processor.validate()
puts processor.process()