return {
  "fidget",
  event = "LspAttach";
  after = function()
    require("fidget").setup {}
  end
}
