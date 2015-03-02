desc "Runs site on a local preview webserver"
task :preview do
  host = ENV["host"] || CONFIG[:preview_host]
  port = ENV["port"] || CONFIG[:preview_port]
  dest = ENV['dest'] || CONFIG[:build_destination]

  Rake::Task["build_toc"].invoke
  Rake::Task['prepare_assets'].invoke

  #command = "jekyll serve --trace  --host=#{host} --port=#{port} --watch --force_polling --destination=#{dest}"
  command = "jekyll serve --trace  --host=#{host} --port=#{port} --watch --force_polling --destination=_site"
  sh command
end
