return {
  {
    -- "d4rkr00t/execa.nvim",
    dir = "~/Development/execa.nvim",
    cmd = "Execa",
    opts = {
      split = "vsplit",
      verbose = false,
      confirm = true,
      commands = {
        cargo_test = "cargo test $EX_FN",

        afm_integration_test = "yarn test:integration $EX_FILE_PATH_REL --reuse-dev-server --retries=0",
        afm_integration_test_trace = "yarn test:integration $EX_FILE_PATH_REL --reuse-dev-server --trace=on --retries=0",

        afm_unit_test = "yarn test $EX_FILE_PATH_REL",

        afm_gemini_test = "yarn test:vr $EX_FILE_PATH_REL",
        afm_gemini_informational_test = "yarn test:vr-informational $EX_FILE_PATH_REL",

        npm_version = "npm view $EX_STR version",
        npm_all_versions = "npm view $EX_STR versions",
        npm_src_url = "open https://unpkg.com/browse/$EX_STR/",
        npm_url = "open https://npmjs.com/package/$EX_STR/",

        cursor_current_file = "cursor -r $EX_CWD -g $EX_FILE_PATH_REL:$EX_LINE:$EX_COL",

        execa_test = "echo $EX_CWD $EX_FN $EX_FILE_PATH_REL:$EX_LINE:$EX_COL",
      },
    },
  },
}
