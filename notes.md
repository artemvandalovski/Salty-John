# Notes

TODO (kenta) Documentation comments

## Changes

- made `Hitbox`es apply to `hurtbox`es instead of hurtboxes listening for hitboxes

- added `Hitbox::deal_damage()`, which deals damage *and knockback* (if configured to; see `hitbox.knockback_func: Callable`)

    you won't have to fiddle with enabling and disabling collisions at specific timings anymore
    Tip: you can call methods from inside Tweens via `tween_callback()` or AnimationPlayers via [call method tracks](https://docs.godotengine.org/en/stable/tutorials/animation/animation_track_types.html#call-method-track)

- added `Hitbox::deal_knockback()` that deals only knockback and no damage

- oh yeah and you probably wont need `knockbackComponent` anymore, i merged that stuff with Hitboxes

btw, the "## " comments different from normal "# " comments

it's a new feature where you can create your own documentation comments

See [the official docs](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html)


## Additional suggestions

- Have Item (item on the floor) and Weapon (that the palyer is holding) be two separate things
    reasoning:
    pickup-able items and held weapons have very different logic. you *could* switch between them at runtime
    but that's not very modular, you'll end up with a lot of intertwined code


## Less important notes

- `fist.gd`: move `handle_charge()` and `handle_punch()` inside `func update(delta)`

    reasoning:
    those functions don't really have any special logic to them.
    expanding them out in `update()` will allow for greater flow control e.g. making guard clauses.
    if it starts to get big and clunky, then it would be worth refactoring tho.
    but like, `handle_punch()` is literally just 2 lines.


