return {
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "swift", "objc" },
  root_markers = {
    "buildServer.json",
    "*.xcodeproj",
    "*.xcworkspace",
    "compile_commands.json",
    "Package.swift",
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
  -- settings = {
  --   serverArguments = { "--log-level", "debug" },
  --   trace = { server = "messages" },
  -- },
}
