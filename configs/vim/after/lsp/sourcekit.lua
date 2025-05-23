return {
  cmd = { "sourcekit-lsp" },
  filetypes = { "swift", "objc" },
  root_markers = {
    "buildServer.json",
    "*.xcodeproj",
    "*.xcworkspace",
    "compile_commands.json",
    "Package.swift",
  },
  get_language_id = function(_, ftype)
    local t = { objc = "objective-c" }
    return t[ftype] or ftype
  end,
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
}
