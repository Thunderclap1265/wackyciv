// If you add a more comprehensive system, just untick this file.
// WARNING: Only works for up to 17 z-levels!
var/z_levels = FALSE // Each bit represents a connection between adjacent levels.  So the first bit means levels TRUE and 2 are connected.
/*
// If the height is more than TRUE, we mark all contained levels as connected.
/obj/effect/landmark/map_data/New()
	ASSERT(height > 1)
	// Due to the offsets of how connections are stored v.s. how z-levels are indexed, some magic number silliness happened.

	for (var/i = (height-1); i--;)
		z_levels |= (1 << (z+i-1))
*/
// The storage of connections between adjacent levels means some bitwise magic is needed.
proc/HasAbove(var/z)
	if (z >= world.maxz || z > 16 || z < 1)
		return FALSE
	return z_levels & (1 << (z - 1))

proc/HasBelow(var/z)
	if (z > world.maxz || z > 17 || z < 2)
		return FALSE
	return z_levels & (1 << (z - 2))

// Thankfully, no bitwise magic is needed here.
proc/GetAbove(var/atom/atom)

	var/turf/turf = get_turf(atom)
	if (!turf)
		return null
	return HasAbove(turf.z) ? get_step(turf, UP) : null


proc/GetBelow(var/atom/atom)

	var/turf/turf = get_turf(atom)
	if (!turf)
		return null
	return HasBelow(turf.z) ? get_step(turf, DOWN) : null


// for in game debugging
/turf/proc/GetBelowMemberFunction()
	return GetBelow(src)

/turf/proc/GetAboveMemberFunction()
	return GetAbove(src)
