

//Values for antag preferences, event roles, etc. unified here



//These are synced with the Database, if you change the values of the defines
//then you MUST update the database!
#define ROLE_TRAITOR			"traitor"
#define ROLE_OPERATIVE			"operative"
#define ROLE_CHANGELING			"changeling"
#define ROLE_WIZARD				"wizard"
#define ROLE_MALF				"malf AI"
#define ROLE_REV				"revolutionary"
#define ROLE_CULTIST			"cultist"
#define ROLE_BLOB				"blob"
#define ROLE_NINJA				"space ninja"
#define ROLE_MONKEY				"monkey"
#define ROLE_GANG				"gangster"
#define ROLE_ABDUCTOR			"abductor"
#define ROLE_REVENANT			"revenant"
#define ROLE_HOG_GOD			"hand of god: god"
#define ROLE_HOG_CULTIST		"hand of god: cultist"
#define ROLE_DEVIL				"devil"
#define ROLE_SERVANT_OF_RATVAR	"servant of Ratvar"

#define ROLE_ALIEN				"xenomorph"
#define ROLE_PAI				"pAI"
#define ROLE_SURVIVOR			"survivor"
#define ROLE_RESPONDER			"responder"
#define ROLE_PREDATOR			"predator"

//Missing assignment means it's not a gamemode specific role, IT'S NOT A BUG OR ERROR.
//The gamemode specific ones are just so the gamemodes can query whether a player is old enough
//(in game days played) to play that role
var/global/list/special_roles = list(
	ROLE_ALIEN,
	ROLE_PAI,
	ROLE_SURVIVOR,
	ROLE_RESPONDER,
	ROLE_PREDATOR,
)

//Job defines for what happens when you fail to qualify for any job during job selection
#define BEMARINE		1
#define BERANDOMJOB		2
#define RETURNTOLOBBY	3