return {
  -- Open GitHub URL of current file, etc. from Vim editor (supported GitHub Enterprise)
  -- https://github.com/tyru/open-browser-github.vim
  {
    "tyru/open-browser-github.vim",
    lazy = true,
    dependencies = {
      "tyru/open-browser.vim",
    },
    cmd = { "OpenGithubFile", "OpenGithubIssue", "OpenGithubPullReq", "OpenGithubProject" },
  },
}
