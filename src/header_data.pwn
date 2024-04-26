#define public:%0(%1)   forward%0(%1); public%0(%1)

#define c_white             "{FFFFFF}"

new FormatData_2048[2048];

#define MAX_ELEMENTS_ON_PAGE 			16
#define MAX_PLAYER_LISTITEMS			25

new g_player_listitem[MAX_PLAYERS][MAX_PLAYER_LISTITEMS];

#define SetPlayerListItem(%0,%1,%2)			    g_player_listitem[%0][%1] = %2
#define GetPlayerListItem(%0,%1)			    g_player_listitem[%0][%1]

#define GetPlayerPage(%0)						GetPVarInt(%0, #DIALOG_PAGE)
#define SetPlayerPage(%0,%1)					SetPVarInt(%0, #DIALOG_PAGE, %1)
#define DeletePlayerPage(%0)					DeletePVar(%0, #DIALOG_PAGE)

#define DIALOG_NEXT_PAGE_TEXT        			">>> Следующая страница"
#define DIALOG_PREVIOUS_PAGE_TEXT    			"<<< Предыдущая страница"