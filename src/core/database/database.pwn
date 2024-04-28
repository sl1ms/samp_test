
stock Database:Init()
{
    mysql = mysql_connect_file("mysql.ini");

    mysql_set_charset("cp1251", mysql);

    printf(
        mysql_errno(mysql) ? "[MySQL] Подключение к основной базе данных не прошло (%d)" : "[MySQL] Подключение к основной базе данных прошло успешно",
        mysql_errno(mysql)
    );

    mysql_log(ERROR | INFO | WARNING);

    return 1;
}

public OnGameModeInit()
{
    Database:Init();

    #if defined DB_OnGameModeInit
		return DB_OnGameModeInit();
	#else
		return 1;
	#endif
}


#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit DB_OnGameModeInit
#if defined DB_OnGameModeInit
	forward DB_OnGameModeInit();
#endif

public OnGameModeExit()
{
    mysql_close(mysql);

    #if defined DB_OnGameModeExit
		return DB_OnGameModeExit();
	#else
		return 1;
	#endif
}


#if defined _ALS_OnGameModeExit
	#undef OnGameModeExit
#else
	#define _ALS_OnGameModeExit
#endif
#define OnGameModeExit DB_OnGameModeExit
#if defined DB_OnGameModeExit
	forward DB_OnGameModeExit();
#endif