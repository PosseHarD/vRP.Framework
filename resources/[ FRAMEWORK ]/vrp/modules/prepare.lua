-----------------------------------------------------------------------------------------------------------------------------------------
-- BASE.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/create_user","INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() AS id")
vRP.prepare("vRP/set_steam","UPDATE vrp_users SET steam = @steam WHERE id = @user_id")
vRP.prepare("vRP/add_identifier","INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
vRP.prepare("vRP/userid_byidentifier","SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
vRP.prepare("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
vRP.prepare("vRP/get_banned","SELECT banned FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_banned","UPDATE vrp_users SET banned = @banned WHERE id = @user_id")
vRP.prepare("vRP/get_whitelisted","SELECT whitelisted FROM vrp_users WHERE id = @user_id")
vRP.prepare("vRP/set_whitelisted","UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
vRP.prepare("vRP/add_banned","INSERT INTO vrp_users_banned(user_id,identifier,hacker) VALUES(@user_id,@identifier,@hacker) ON DUPLICATE KEY UPDATE user_id = @user_id, hacker = @hacker")
vRP.prepare("vRP/get_identifiers_by_userid","SELECT identifier FROM vrp_user_ids WHERE user_id = @user_id")
vRP.prepare("vRP/get_banned_identifiers","SELECT identifier FROM vrp_users_banned WHERE identifier = @identifier")
vRP.prepare("vRP/rem_banned_identifiers","DELETE from vrp_users_banned WHERE user_id = @user_id")

-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_priority","SELECT * FROM vrp_priority")

-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_user_identity","SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
vRP.prepare("vRP/init_user_identity","INSERT IGNORE INTO vrp_user_identities(user_id,registration,phone,firstname,name,age) VALUES(@user_id,@registration,@phone,@firstname,@name,@age)")
vRP.prepare("vRP/update_user_identity","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age, registration = @registration, phone = @phone WHERE user_id = @user_id")
vRP.prepare("vRP/get_userbyreg","SELECT user_id FROM vrp_user_identities WHERE registration = @registration")
vRP.prepare("vRP/get_userbyphone","SELECT user_id FROM vrp_user_identities WHERE phone = @phone")
vRP.prepare("vRP/update_registration","UPDATE vrp_user_identities SET registration = @registration WHERE user_id = @user_id")
vRP.prepare("vRP/update_user_first_spawn","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")

-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY.LUA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/money_init_user","INSERT IGNORE INTO vrp_user_moneys(user_id,bank) VALUES(@user_id,@bank)")
vRP.prepare("vRP/get_money","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP.prepare("vRP/set_money","UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id")