max_threads = ENV['MAX_THREADS'] || 5

workers Integer(ENV['PUMA_WORKERS'] || 2)
threads_count = Integer(max_threads)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'
