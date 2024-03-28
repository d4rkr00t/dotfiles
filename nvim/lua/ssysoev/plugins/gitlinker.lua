local safe_require = require("ssysoev.utils.safe-require")
local split = require("ssysoev.utils.split-str")
safe_require({ "gitlinker" }, function(mods)
  local gitlinker = mods["gitlinker"]

  local function stash_matcher(url_data)
    local url = "https://stash.atlassian.com/projects/"
    url = url .. url_data.user .. "/repos/" .. url_data.repo:gsub("%.git", "")
    url = url .. "/browse/" .. url_data.file
    url = url .. "?at=" .. url_data.rev
    if url_data.lend then
      url = url .. "#" .. url_data.lstart .. "-" .. url_data.lend
    else
      url = url .. "#" .. url_data.lstart
    end
    return url
  end

  gitlinker.setup({
    router = {
      browse = {
        ["^bitbucket%-mirror%-au%.internal%.atlassian%.com"] = stash_matcher,
      },
      blame = {
        ["^bitbucket%-mirror%-au%.internal%.atlassian%.com"] = stash_matcher,
      },
      default_branch = {
        ["^bitbucket%-mirror%-au%.internal%.atlassian%.com"] = stash_matcher,
      },
    },
  })
end)
