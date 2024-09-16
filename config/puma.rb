
# config/puma.rb

# Specifies the number of worker processes.
workers 2

# Specifies the number of threads per worker.
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the port to listen on.
port ENV.fetch("PORT") { 3000 }

# Specifies the environment.
environment ENV.fetch("RAILS_ENV") { "production" }

# Specifies the location of the PID file.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/puma.pid" }

# Specifies the location of the log file.
stdout_redirect ENV.fetch("STDOUT_LOG") { "log/puma.stdout.log" },
                ENV.fetch("STDERR_LOG") { "log/puma.stderr.log" }

# Specifies the location of the socket file.
# Uncomment if using UNIX socket (instead of TCP)
# bind "unix://#{Rails.root}/tmp/sockets/puma.sock"

# Preloads the application before forking workers.
preload_app!

# On worker boot, reconnect to ActiveRecord.
on_worker_boot do
  ActiveRecord::Base.establish_connection
end

