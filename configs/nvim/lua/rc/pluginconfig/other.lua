require("other-nvim").setup({
  mappings = {
    {
      pattern = "/lib/(.*)/(.*).rb",
      target = {
        { target = "/spec/%1/%2_spec.rb", context = "spec" },
      },
    },
    {
      pattern = "/(.*).rb",
      target = {
        target = "/sig/%1.rbs",
        context = "sig",
      },
    },
    {
      pattern = "/sig/(.*).rbs",
      target = {
        target = "/%1.rb",
        context = "sig",
      },
    },
  },
})
