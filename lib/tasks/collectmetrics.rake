task :collect_metrics, [:libraries, :output] do |t, args|
  Resolver.call(args[:libraries], args[:output])
end

