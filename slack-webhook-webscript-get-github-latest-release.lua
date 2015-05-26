-- fetches the latest release from GitHub
local response = http.request {
	url = 'https://api.github.com/repos/{repo-owner}/{repo}/releases/latest',
	method = 'GET',
	params = { access_token="{your-token}" },
	headers = { ["User-Agent"] = "Webscript/Cut-Release" }
}
if response.statuscode == 200 then
	local content_table = json.parse(response.content)
	local text = "The latest release is: " .. content_table.tag_name
	return {text = text}
elseif response.statuscode == 404 then
	return {text = "No release found!"}
end
return {text = "Could not get the latest release"}
