task :default => :judge

task :judge do
  sh "ruby -Ilib judge laws/*_laws.rb"
end

task :example do
  sh "ruby -Ilib judge example_laws.rb"
end

