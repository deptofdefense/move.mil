require 'html-proofer'

desc 'Test the site with html-proofer'
task :htmlproofer do
  options = {
    assume_extension: true,
    empty_alt_ignore: true
  }

  HTMLProofer.check_directory('./public', options).run
end
