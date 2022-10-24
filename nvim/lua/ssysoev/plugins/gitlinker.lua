local setup, gitlinker = pcall(require, "gitlinker")

if not setup then
	return
end

gitlinker.setup()
