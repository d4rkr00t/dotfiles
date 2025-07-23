local config = {
  use_case_id = "avante-nvim",
  atlassian_tenant_id = "a436116f-02ce-4520-8fbb-7301462a1674", -- hello's tenant id
  base_url = "https://ai-gateway.sgw.prod.atl-paas.net/v1/",
}

local get_slauth_token = function()
  local handle = io.popen("atlas slauth token --env=prod --aud=ai-gateway")
  local output = handle:read("*a")
  local token = output:gsub("[\n\r]", " ")
  handle:close()
  return token
end

local get_default_headers = function()
  local token = get_slauth_token()
  local headers = {
    ["Content-Type"] = "application/json",
    ["Accept"] = "text/event-stream",
    ["Authorization"] = "SLAUTH " .. token,
    ["X-Atlassian-UseCaseId"] = config.use_case_id,
    ["X-Atlassian-CloudId"] = config.atlassian_tenant_id,
  }
  return headers
end

local is_env_set = function()
  return true
end

return {
  atlgemini = {
    __inherited_from = "gemini",
    model = "gemini-2.5-flash", -- change me if you'd like
    endpoint = config.base_url .. "google/v1/publishers/google/models/",
    parse_curl_args = function(opts, code_opts)
      local providers = require("avante.providers")
      local utils = require("avante.utils")
      local gemini = require("avante.providers.gemini")
      local provider_conf, request_body = providers.parse_config(code_opts)
      request_body.generationConfig = {
        temperature = 0.75,
      }
      return {
        url = utils.url_join(opts.endpoint, opts.model .. ":streamGenerateContent"),
        headers = get_default_headers(),
        body = gemini:prepare_request_body(code_opts, provider_conf, request_body),
      }
    end,
    -- We don't use a env variable for auth, force avante to not ask for its value
    is_env_set = is_env_set,
  },
  atlopenai = {
    __inherited_from = "openai",
    model = "gpt-4o-mini-2024-07-18", -- change me if you'd like
    endpoint = config.base_url .. "openai/v1/chat/completions",
    parse_curl_args = function(opts, code_opts)
      local openai = require("avante.providers.openai")
      local tools = nil
      tools = {}
      for _, tool in ipairs(code_opts.tools) do
        table.insert(tools, openai:transform_tool(tool))
      end
      return {
        url = opts.endpoint,
        headers = get_default_headers(),
        body = vim.tbl_deep_extend("force", {
          model = opts.model,
          messages = openai:parse_messages(code_opts),
          stream = true,
          tools = tools,
        }, {}),
      }
    end,
    -- We don't use a env variable for auth, force avante to not ask for its value
    is_env_set = is_env_set,
  },
}
