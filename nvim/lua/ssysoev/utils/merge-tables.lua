function merge_tables(table1, table2)
	local result = {}

	for k, v in pairs(table1) do
		result[k] = v
	end
	for k, v in pairs(table2) do
		result[k] = v
	end

	return result
end

return merge_tables
