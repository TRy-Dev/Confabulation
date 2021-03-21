=== death
= start
{player_name}.
-> options

= options
* [Who are you?] -> who_is
* [What is this place?] -> this_place
* [What's behind you?] -> behind
+ [Can I go now?] -> go_now
* _p_ -> start

= who_is
I'm just a creation of your imagination.
-> options

= this_place
It's just a creation of your imagination.
-> options

= behind
It's your destination.
Speak to me when you are ready to go.
-> options

= go_now
{achievement_count < 1: -> achi_0}
{achievement_count > 0: -> achi_1_7}

= achi_0
I'm sorry. I can't let you pass yet. 
Speak with creatures in the village and help them. 
Only then you can continue.
-> options

= achi_1_7
{npc_count > 1: I can let you pass if that's your wish. However there are still some things for you to do here.}
{npc_count <= 1: This place is empty. It's time to go.}
* [I'd like to go now] -> proceed
+ [I'd like to stay a bit longer] -> stay

= proceed
!FL(destroy_npc)
As you wish. Farewell.
* _p_ -> start

= stay
{npc_count > 1: As you wish. There's no rush.}
{npc_count <= 1: You should hurry.}
-> options

