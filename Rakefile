CONFIG = {
  :source_dir => __dir__,
  :tmp_dir => "#{__dir__}/_tmp",
  :build_destination => "_site/",
  :preview_host => "0.0.0.0",
  :preview_port => 4000,
  :default_env => 'dev'
}

task :default do
  system('rake -T')
end

desc 'Build docs'
task :build => [:prepare_assets] do
  dest = ENV['dest'] || CONFIG[:build_destination]

  sh "jekyll build --trace --destination=#{dest}"
end

desc 'Preparing assets'
task :prepare_assets do
  RakeFileUtils.mkdir_p '_includes'
  RakeFileUtils.cp 'webhelp-template/app/templates/page.html', '_includes/page.html'
end

desc "Runs site on a local preview webserver"
task :preview => [:prepare_assets] do
  host = ENV["host"] || CONFIG[:preview_host]
  port = ENV["port"] || CONFIG[:preview_port]
  dest = ENV['dest'] || CONFIG[:build_destination]

  sh "jekyll serve --trace  --host=#{host} --port=#{port} --watch --force_polling --destination=#{dest}"
end
