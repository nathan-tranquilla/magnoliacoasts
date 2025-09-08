file 'node_modules' do
  sh 'npm install'
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

task :res_clean do
  sh "npx rescript clean"
end

task :clean => [:res_clean, :node_modules_clean, :docs_clean]

task :res_dev => 'node_modules' do
  sh "npx rescript -w"
end

task :dev => ['node_modules', :res_build] do
  sh "npx astro dev"
end

task :build => ['node_modules', :res_build] do
  sh "npx astro build"
end

task :build_prod => [:node_modules_clean, :ci_install, :res_build] do
  sh "npx astro build"
end

task :preview => 'node_modules' do
  sh "npx astro preview"
end