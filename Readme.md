#### Thought Process

* First thing I decided to do is get my code working. So whatever Idea I thought of I jump started with that.
* Then I realised for some valid cases circular dependency error was raised.
* So I decided to validate the Input first and then just order them.
* Self dependency validation was straight forward.
* circular dependency error was a little bit tricky. So I decided to put a check for each job, where a loop runs until dependency cycle for a job ends. e.g. a => b => c => d => nil. So at d dependency cycle ends and if any of the jobs gets repeated I will raise an circular dependency error.

* I have added test cases also for all the given scenarios.
* I have added a `main.rb` file which contains the steps to run the project.

#### How to run the project

* Input accepted is an comma separated string, e.g. - "a =>, b => c, c => d"
* go to `main.rb` and update the input string to desired input string.
* Once correct input is given just run `ruby main.rb`
* The above command will raise an error if there is self or circular dependency
* Exceptions raised are `Exceptions::SelfDependencyError`, `Exceptions::CircularDependencyError`

#### How to run test cases
* To run test cases first make sure minitest is installed in your system. To install run `gem install minitest`
* once minitest is installed run `ruby tests/job_processor_test.rb` to run the test cases