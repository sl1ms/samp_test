#define Barrier:%0(%1)                    BRR__%0(%1)

enum BarrierDialog {
    D_BARRIER_LIST
};

new const barrier_info[] = {
    ""
}


stock Barrier:List(playerid) 
{
    ShowPlayerDialog
    (
        playerid, 
        BarrierDialog: D_BARRIER_LIST, 
        DIALOG_STYLE_TABLIST_HEADERS, 
        "Список ограждений", 
        "", 
        button1[], 
        button2[]
    );
    return 1;
}


#if defined PAWNCMD_INC_

public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/bort create")) {
        Barrier:List(playerid);
        return 1;
    }
    #if defined Barrier_OnPlayerCommandText
        return Barrier_OnPlayerCommandText(playerid, cmdtext);
    #else
        return 1;
    #endif
}
#if defined _ALS_OnPlayerCommandText
    #undef OnPlayerCommandText
#else
    #define _ALS_OnPlayerCommandText
#endif

#define OnPlayerCommandText Barrier_OnPlayerCommandText
#if defined Barrier_OnPlayerCommandText
    forward Barrier_OnPlayerCommandText(playerid, cmdtext[]);
#endif

#endif