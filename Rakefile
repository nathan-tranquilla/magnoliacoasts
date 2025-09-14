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

task :it_rerun => ['ruby/vendor/bundle'] do 
  Dir.chdir('ruby') do
    sh 'bundle exec rspec --only-failures'
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
  sh "npx astro build"
end

task :preview => [:build_prod] do
  sh "npx wrangler dev"
end

task :generate_package do 

  require 'fileutils'

  data_dir = File.expand_path('src/data', Dir.pwd)

  # Prompt for package (folder) name
  print "Enter package folder name (e.g. newbornPackages): "
  package_folder = STDIN.gets.strip
  package_path = File.join(data_dir, package_folder)

  if File.exist?(package_path)
    puts "Folder '#{package_folder}' already exists."
  else
    FileUtils.mkdir_p(package_path)
    puts "Created folder: #{package_path}"
  end

  # Prompt for markdown file name
  print "Enter markdown file name (e.g. miniNewborn.md): "
  md_file = STDIN.gets.strip
  md_path = File.join(package_path, md_file)

  if File.exist?(md_path)
    puts "File '#{md_file}' already exists in '#{package_folder}'. Aborting."
    next
  end

  # Prompt for fields
  print "Title: "
  title = STDIN.gets.strip

  print "Sort order (number): "
  sort_order = STDIN.gets.strip

  print "Price (leave blank if specifying price range): "
  price = STDIN.gets.strip

  print "Price range (e.g. $200-$400, leave blank if not applicable): "
  price_range = STDIN.gets.strip

  print "Image src (relative to src/assets, e.g. miniNewborn.png): "
  image_src = STDIN.gets.strip

  print "Image alt text: "
  image_alt = STDIN.gets.strip

  # Write file
  File.open(md_path, 'w') do |f|
  f.puts "---"
  f.puts "title: #{title}"
  f.puts "sortOrder: #{sort_order}"
  f.puts "price: #{price}" unless price.empty?
  f.puts "priceRange: #{price_range}" unless price_range.empty?
  f.puts "details:"
  f.puts "- ''"
  f.puts "---"
  f.puts "![#{image_alt}](../../assets/#{image_src})"
  end

  puts "Created #{md_path}"
end