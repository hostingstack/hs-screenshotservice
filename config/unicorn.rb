worker_processes 4
working_directory "/usr/lib/hs/screenshotservice"
listen "/var/run/hs-screenshotservice.sock", :backlog => 64
timeout 15

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

