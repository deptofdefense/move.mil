require 'html-proofer'

desc 'Test the site with html-proofer'
task :htmlproofer do
  HTMLProofer.check_directory('./public', { assume_extension: true }).run
end
