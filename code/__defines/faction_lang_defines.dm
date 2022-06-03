//factions only
#define PIRATES "PIRATES"
#define CIVILIAN "CIVILIAN"
#define INDIANS "INDIANS"
#define BRITISH "BRITISH"
#define ROMAN "ROMAN"
#define AMERICAN "AMERICAN"

// used for languages only
#define ENGLISH "ENGLISH"
#define CARIB "CARIB"
#define LATIN "LATIN"
#define UKRAINIAN "UKRAINIAN"
#define CHINESE "CHINESE"
#define HEBREW "HEBREW"
#define SWAHILI "SWAHILI"
#define ZULU "ZULU"
#define AINU "AINU"
#define GAELIC "GAELIC"
#define ITALIAN "ITALIAN"
#define CHEROKEE "CHEROKEE"
#define INUIT "INUIT"
#define OLDNNORSE "OLDNORSE"
#define EGYPTIAN "EGYPTIAN"
#define IROQUOIS "IROQUOIS"

//used for languages & factions
#define SPANISH "SPANISH"
#define PORTUGUESE "PORTUGUESE"
#define FRENCH "FRENCH"
#define DUTCH "DUTCH"
#define JAPANESE "JAPANESE"
#define RUSSIAN "RUSSIAN"
#define CHECHEN "CHECHEN"
#define FINNISH "FINNISH"
#define GREEK "GREEK"
#define ARAB "ARAB"
#define GERMAN "GERMAN"
#define VIETNAMESE "VIETNAMESE"
#define KOREAN "KOREAN"
#define FILIPINO "FILIPINO"
/proc/faction_const2name(constant,age = 0)

	if (constant == PIRATES)
		return "Pirates"

	if (constant == BRITISH)
		if (age >= 6)
			return "United Kingdom"
		else
			return "British Empire"

	if (constant == CIVILIAN)
		if (map.ID == "TSARITSYN")
			return "Red Army"
		if (map.ID == "YELTSIN")
			return "Militia"
		if (map.ID == "AFRICAN_WARLORDS")
			return "United Nations"
		if (map.ID == "WHITERUN")
			return "Stormcloaks"
		if (map.ID == "CAPITOL_HILL")
			return "Rioters"
		if (map.ID == "WACO")
			return "Branch Davidians"
		if (map.ID == "MISSIONARY_RIDGE")
			return "Confederates"
		else if (age >= 6)
			return "Civilians"
		else
			return "Colonists"

	if (constant == INDIANS)
		if (map.ID == "AFRICAN_WARLORDS")
			return "Africans"
		else
			return "Native Tribe"

	if (constant == PORTUGUESE)
		return "Portuguese Empire"

	if (constant == SPANISH)
		return "Spanish Empire"

	if (constant == FRENCH)
		if (age >= 4)
			return "French Republic"
		else
			return "French Empire"


	if (constant == DUTCH)
		return "Dutch Republic"

	if (constant == JAPANESE)
		return "Japanese Empire"

	if (constant == RUSSIAN)
		if (map.ID == "YELTSIN")
			return "Russian Army"
		if (map.ID == "GROZNY")
			return "Russian Federal Forces"
		else if (age >= 6)
			return "Soviet Union"
		if (map.ID == "TSARITSYN")
			return "White Army"
		else
			return "Russian Empire"

	if (constant == ROMAN)
		if (map.ID == "WHITERUN")
			return "Imperial Army"
		else
			return "Roman Republic"

	if (constant == CHECHEN)
		return "Chechen Republic of Ichkeria"

	if (constant == FINNISH)
		return "Republic of Finland"

	if (constant == GERMAN)
		if (age >= 6)
			return "Third Reich"
		else
			return "German Empire"
	if (constant == GREEK)
		return "Greek States"

	if (constant == ARAB)
		if (age >= 6)
			if (map.ID == "ARAB_TOWN")
				return "Hezbollah"
			if (map.ID == "SOVAFGHAN")
				return "Mujahideen"
			else
				return "Insurgents"
		else
			return "Arabic Caliphate"

	if (constant == AMERICAN)
		if (map.ID == "ARAB_TOWN")
			return "IDF"
		if (map.ID == "CAPITOL_HILL")
			return "American Government"
		if (map.ID == "WACO")
			return "ATF"
		else
			return "United States"

	if (constant == VIETNAMESE)
		return "Vietnamese"

	if (constant == CHINESE)
		return "Chinese"

	if (constant == EGYPTIAN)
		return "Egyptian"

	if (constant == KOREAN)
		return "Korean"

	if (constant == IROQUOIS)
		return "Iroquois"

	if (constant == FILIPINO)
		return "Filipino"