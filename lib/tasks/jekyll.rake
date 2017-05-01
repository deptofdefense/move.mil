namespace :jekyll do
  desc 'Build the site to `./public`'
  task :build do
    sh 'bundle exec jekyll build --config config/jekyll.yml --trace'
  end

  desc 'Serve the site at `http://localhost:4000`'
  task :serve do
    sh 'bundle exec jekyll serve --config config/jekyll.yml --trace'
  end
end
