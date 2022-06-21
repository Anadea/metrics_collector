task :collect_metrics => :environment do
  MetricsCollector.full_download
end
