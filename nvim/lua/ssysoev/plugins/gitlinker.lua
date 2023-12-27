local safe_require = require("ssysoev.utils.safe-require")
local split = require("ssysoev.utils.split-str")
safe_require({ "gitlinker" }, function(mods)
  local gitlinker = mods["gitlinker"]

  local function stash_matcher(url_data)
    local url = "https://stash.atlassian.com/projects/"
    local repo = split(url_data.repo, "/")
    url = url .. repo[0] .. "/repos/" .. repo[1]
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
    callbacks = {
      ["bitbucket-mirror-au.internal.atlassian.com"] = stash_matcher,
      ["stash.atlassian.com"] = stash_matcher,
    },
  })
end)
