
rand = {}
math.randomseed(minetest.get_mapgen_setting("seed"))

function rand.dy(y)
	return math.random(y)
end

function rand.xdy(x, y)
	local out = 0
	for i = 1, x do
		out = out + math.random(y)
	end
	return out
end

function rand.seq(a, z)
	if not z then
		z = a
		a = 1
	end
	local seq = {}
	for i = a, z do
		table.insert(seq, i)
	end
	return function()
		return #seq > 0 and table.remove(seq, math.random(#seq)) or nil
	end
end

function rand.pick(parts, vals, count, max)
	count = count or 1
	if #parts < 1 or #vals < 1 then 
		return 
	elseif count >= #vals then
		return vals
	end

	local sum
	if not max then
		sum = parts[1]
		for i = 2, #parts do
			sum = sum + parts[i]
		end
		max = sum
	end

	local random = {}
	for i = 1, count do
		table.insert(random, math.random(max))
	end

	sum = parts[1]
	local out = {}
	local last = 1
	for i = 2, #parts do
		sum = sum + parts[i]
		for j = last, #random do
			if random[j] <= sum then
				table.insert(out, vals[j])
				last = last + 1
			end
		end
	end
	return out
end

