DialogCreate:D_REGISTER(playerid)
{
    Dialog_Open
    (
        playerid, 
        Dialog: D_REGISTER, DIALOG_STYLE_INPUT,
        "Регистрация",
        "Введите пароль:",
        "Создать", "Закрыть"
    );
    return 1;
}

DialogResponse:D_REGISTER(playerid, response, listitem, inputtext[])
{
    if(!response) 
    {
        Kick(playerid);
        return 1;
    }

    if(!(6 <= strlen(inputtext) <= 64)) return Dialog_Show(playerid, Dialog:D_REGISTER);

    format(GetPlayerData(playerid, PLAYER_PASSWORD), MAX_LENGTH_PASSWORD, inputtext);

    Database:CreateAccount(playerid);
    return 1;
}

DialogCreate:D_LOGIN(playerid)
{
    new dialog_string[150];

    format
    (
        dialog_string, sizeof dialog_string,"\
        "c_white"Добро пожаловать, %s!\n\
        Ваш аккаунт зарегистрирован,\n\
        авторизуйтесь для начала игры\n\n\
        Введите ваш пароль:",
        GetPlayerData(playerid, PLAYER_NAME)
    );

    Dialog_Open(playerid, Dialog: D_LOGIN, DIALOG_STYLE_INPUT, "Авторизация", dialog_string, "Принять", "Выход");
    return 1;
}

DialogResponse:D_LOGIN(playerid, response, listitem, inputtext[])
{
    if(!response) return Kick(playerid);

    if(!(6 <= strlen(inputtext) <= 64)) return Dialog_Show(playerid, Dialog: D_LOGIN);

    if(Auth:IsValidPassword(inputtext)) return Dialog_Show(playerid, Dialog: D_LOGIN);

    new 
        c_account_query[128]
    ;

    mysql_format
    (
        mysql, c_account_query, sizeof c_account_query, 
        "SELECT * FROM "#DB_ACCOUNT" WHERE `name` = '%e' AND `password` = '%e'", 
        GetPlayerData(playerid, PLAYER_NAME),
        inputtext
    );

    mysql_tquery(mysql, c_account_query, DatabaseText(Database:LoadPlayerData), "d", playerid);

    return 1;
}

public: Database:LoadPlayerData(playerid)
{
    new 
        rows = cache_num_rows();

    if(!rows) return Dialog_Show(playerid, Dialog: D_LOGIN);

    cache_get_value_name_int(0, "id", GetPlayerData(playerid, PLAYER_ID));
 
    Accessories:LoadPlayerData(playerid);

    Auth:LoadPlayerDataDone(playerid);

    return 1;
}

public: Database:CreateAccount(playerid)
{
    new c_account_query[128];

    mysql_format
    (
        mysql,
        c_account_query,
        128,
        "INSERT INTO "DB_ACCOUNT" (`name`, `password`) VALUES ('%e', '%e')",
        GetPlayerData(playerid, PLAYER_NAME),
        GetPlayerData(playerid, PLAYER_PASSWORD)
    );

    mysql_tquery(mysql, c_account_query, DatabaseText(Database:CreateAccountDone), "d", playerid);

    return 1;
}

public: Database:CreateAccountDone(playerid)
{
    SetPlayerData(playerid, PLAYER_ID, cache_insert_id());

    Auth:LoadPlayerDataDone(playerid);

    return 1;
}

stock Auth:CheckAccount(playerid)
{
    g_player_data[playerid] = g_player_data_default;

    GetPlayerName(playerid, GetPlayerData(playerid, PLAYER_NAME), MAX_PLAYER_NAME);

    TogglePlayerSpectating(playerid, 1);

    SetTimerEx(AuthText(Auth:OnPlayerJoin), 1500, false, "d", playerid);
    return 1;
}

public: Auth:OnPlayerJoin(playerid)
{
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);

    new check_account_query[128];

    mysql_format
    (
        mysql, check_account_query, sizeof check_account_query, 
        "SELECT `id` FROM "#DB_ACCOUNT" WHERE `name` = '%e'", 
        GetPlayerData(playerid, PLAYER_NAME)
    );

    mysql_tquery(mysql, check_account_query, DatabaseText(Database:IsCheckAccount), "d", playerid);

    return 1;
}

public: Database:IsCheckAccount(playerid)
{
    Dialog_Show(playerid, cache_num_rows() ? (Dialog:D_LOGIN) : (Dialog:D_REGISTER));

    return 1;
}

stock Auth:LoadPlayerDataDone(playerid)
{
    SetPlayerData(playerid, PLAYER_AUTHORIZED, true);

    TogglePlayerSpectating(playerid, 0);

    SetSpawnInfo(playerid, 1, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);

    SpawnPlayer(playerid);
    return 1;
}

stock Auth:IsValidPassword(const password[])
{
    for(new i; password[i] != '\0'; i++)
    {
        switch(password[i])
        {
            case 'А'..'Я', 'а'..'я', ' ': return 1;
        }
    }
    return 0;
}
