require("packer").init({
  git = {
    clone_timeout = 240, -- Timeout for git clones (seconds)
  },
  max_jobs = 50,
  auto_clean = true,
  compile_on_sync = true,
  auto_reload_compiled = true,
})
