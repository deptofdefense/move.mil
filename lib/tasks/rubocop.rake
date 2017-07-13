require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |task|
  options = ['display-cop-names', 'display-style-guide', 'extra-details', 'rails']
  options.each { |option| task.options << "--#{option}" }
end
