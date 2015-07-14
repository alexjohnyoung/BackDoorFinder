local Enable = true --Make false to disable


	if Enable then
		local BackDoorFinder = {} --make a table for our uses
		local ply = FindMetaTable("Player") --get the playertable 
		BackDoorFinder.Found = {} --found table
		BackDoorFinder.ID = ply.SteamID --the player steamID function
		BackDoorFinder.TI = table.insert --incase backdoor developers detour table.insert :p
		BackDoorFinder.d = debug.getinfo --debug.getinfo detour (same reason as above)
		BackDoorFinder.cD = file.CreateDir --file.CreateDir detour 
		BackDoorFinder.Ap = file.Append --file.Append detour yo
		BackDoorFinder.fE = file.Exists --file exists detour :))
		BackDoorFinder.hA = hook.Add --hook.Add detourrr
		BackDoorFinder.fW = file.Write --file write bruv
		BackDoorFinder.mR = math.Rand 
		BackDoorFinder.tS = tostring
		BackDoorFinder.pr = function(col, str)  --printing function, yolo
			MsgC(color_white, "\n // ", col, str, color_white, " //\n")
		end

		BackDoorFinder.cD("backdoorfinder")

		local reCop = 
		{
			["RunConsoleCommand"] = "severe",
			["CompileString"] = "severe",
			["CompileFile"] = "severe",
			["pcall"] = "severe",
			["xpcall"] = "severe",
			["RunStringEx"] = "severe",
			["getfenv"] = "severe",
			["setfenv"] = "severe",
			["debug.getregistry"] = "severe",
			["RunString"] = "severe",
			["ConCommand"] = "severe",
			["SetUserGroup"] = "severe",
			["Kick"] = "medium",
			["Ban"] = "high"
		}

		BackDoorFinder.hA("Think", BackDoorFinder.tS(BackDoorFinder.mR(1, 500000)), function() 
			BackDoorFinder.bad = reCop
			for k,v in pairs(reCop) do 
				if type(_G[k]) == "function" then
					_G[k] = _G[k]
				end
			end
		end )

		BackDoorFinder.bad = reCop 


		BackDoorFinder.pr(Color(255, 255, 255, 255), "loaded backdoor finder") --load msg

		function ply.SteamID(...) --detouring steamid func
			local source = BackDoorFinder.d(2).short_src --source of file
			local func = BackDoorFinder.d(2).func --func of file
			local currentline = BackDoorFinder.d(2).currentline
			local before = "" 
			BackDoorFinder.pr(Color(255, 0, 0, 255), "steamID function ran: "..source)
				if !BackDoorFinder.fE("backdoorfinder/"..source:gsub("/", "_")..".txt", "DATA") then 
					BackDoorFinder.fW("backdoorfinder/"..source:gsub("/", "_")..".txt", "___________")
				end 
			BackDoorFinder.TI(BackDoorFinder.Found, source)
			local fileRead = file.Read(source, "GAME")

			local explode = string.Explode("\n", fileRead)
			MsgC(Color(255, 255, 255, 255), explode[currentline])
			BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n"..explode[currentline])
			for k,v in pairs(explode) do
				if k > currentline then 
					if string.find(v, "end") then 
						local ifEnd = k
						for i=currentline+1, ifEnd-1 do 
							local text = explode[i]
							for e,r in pairs(BackDoorFinder.bad) do
								
								if string.find(text, e) then 
									local col = Color(100, 100, 100, 255)
									local severity = BackDoorFinder.bad[text] 
									if r == "severe" then 
										col = Color(200, 0, 0, 255)
									elseif r == "high" then 
										col = Color(255, 115, 100, 255)
									elseif r == "medium" then 
										col = Color(255, 100, 247, 255) 
									end
									MsgC(col, "\n"..text.." - "..string.upper(r))
									BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n"..text.." - "..string.upper(r).."\n")
									col = Color(100, 100, 100, 255)
								end
							end
						end
						MsgC(Color(255, 255, 255), "\n"..v)
						BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n"..v)
						BackDoorFinder.pr(Color(255, 0, 0, 255), "end of log")
						BackDoorFinder.Ap("backdoorfinder/"..source:gsub("/", "_")..".txt", "\r\n // end of log //")
						break
					end
				end
			end
			if before != "" then 
			end
		end
	else 
		MsgC(Color(255, 255, 255), "\n You have disabled the BackDoorFinder addon, so I will not run.\n")
	end

	--Thanks for using ;)
	--enjoy
