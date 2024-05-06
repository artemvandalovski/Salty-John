# Notes & changes

- [x] Breadcrumbs
- [x] ContextSteering is now no longer dependant on the Player alone


i did everything in a new branch: `contextsteering`
dont forget to check `git diff main` too just in case

## Breadcrumbs

- made new script: `BreadcrumbComponent extends RayCast2D`
    yes, i put it in `res://enemies`. wasn't sure where to put it so i decided only enemies could ever use it
    Whatever.
- Collision mask is set in `BreadcrumbComponent::_enter_tree()`

How does it work?

Basically, it keeps track of where the player was last visible via raycasting and places
a marker there (Marker2D node)
then, it tells the ContextSteering node to go follow that marker instead of the player

- top_level
    `top_level` makes it so that the node (in this case, `marker`) behaves as if it was always global no matter what
    so its unaffected by its parents
    it would be functionally the same as writing `current_scene.add_child(marker)`
    but using `top_level` saves us some fiddling with the scene tree and positions
    otherwise, you'd have to also delete the marker when the enemy gets freed, and maybe put all markers in their
    own containers in the scene tree like
        Level
        L whatever...
        L MarkerContainer: Node
          L markers ...
    but that's stupid and ugly
    with markers we can do
        Enemy
        L whatever...
        L Breadcrumbs: Raycast2d
        | L Marker
        L ContextSteering that follows Marker

- marker visualization
    comment / uncomment the block at the end of `_enter_tree()` to see where the marker is

- There was an issue where enemies would get stuck at their markers if they couldnt find the player
    ideally, you'd have enemies enter a wander state or something if that happens
    I just left a print() spam where you would implement that logic
    i think...
    maybe i fucked it up and i'll totally find a better approach to this when i wake up next morning


## Less important changes / tips

you could totally ignore everything down from here if you want, they dont really matter too much

- @export num_rays for a little more flexibility

Tip:
you probably don't need `global.gd::curr_level`, there's now `get_tree().current_scene` but erh who cares


