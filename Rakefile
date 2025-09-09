ENV["BROWSER_PATH"] = `which google-chrome-stable`.chomp
ENV["RUBYOPT"] = "-W0"

file 'node_modules' do
  sh 'npm install'
end

file 'ruby/vendor/bundle' do 
  Dir.chdir('ruby') do
    sh 'bundle install --path vendor/bundle'
  end
end 

task :it => ['ruby/vendor/bundle'] do 
  Dir.chdir('ruby') do
    sh 'bundle exec rspec'
  end 
end 

task :ci_install do 
  sh "npm ci"
end 

task :res_build => 'node_modules' do
  sh "npx rescript"
end

task :node_modules_clean do 
  sh "rm -rf node_modules"
end

task :docs_clean do 
  sh "rm -rf docs"
end 

task :ruby_clean do 
  sh "rm -rf ruby/vendor/bundle"
end 

task :res_clean do
  sh "npx rescript clean"
end

task :clean => [:res_clean, :node_modules_clean, :docs_clean, :ruby_clean]

task :res_dev => 'node_modules' do
  sh "npx rescript -w"
end

task :dev => ['node_modules', :res_build] do
  sh "npx astro dev --host"
end

task :test => ['node_modules'] do 
  sh "echo \"not implemented\""
end 

task :build => ['node_modules', :res_build] do
  sh "npx astro build"
end

task :build_prod => [:node_modules_clean, :ci_install, :res_build] do
  base_url = "/magnoliacoasts"
  ENV["BASE_URL"] = base_url
  sh "npx astro build --base #{base_url}"
end

task :preview => 'node_modules' do
  sh "npx astro preview --host"
end