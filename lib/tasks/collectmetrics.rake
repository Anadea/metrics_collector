task :collect_metrics, [:libraries, :output] do |_t, args|
  Resolver.call(args[:libraries], args[:output])
end
