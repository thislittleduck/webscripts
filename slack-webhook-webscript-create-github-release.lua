local trigger_text = request.form.text
local tag_name = ""
for word in string.gmatch(trigger_text, "%S+") do
  if word ~= 'cut-release' then
		tag_name = word
		break
	end
end

if tag_name ~= "" then
	local data = {
		tag_name=tag_name,
		target_commitish="develop"
	}
	local data_str = json.stringify(data)
	local response = http.request {
		url = 'https://api.github.com/repos/{owner}/{repo}/releases',
		method = 'POST',
		data = data_str,
		params = {
			access_token="{your-token}"
		},
		headers = {
			["User-Agent"] = "Webscript/Cut-Release"
		}
	}
	if response.statuscode == 201 then
		text = "Release " .. tag_name .. " sucessfully created!"
		return {text=text}
	end
	return {text="Could not create the release!"}
end

return {text="No tag name given!"}
