=== homeless_man
= start
{give_apple: Hey {~kid|{player_name}|}! {What's up?|What's going on?}}
{not give_apple: {What do yer want?!|Leave me alone!|Go away!}} 
-> options

= options
* {not apple} [Hey! You are mean!] -> mean
* [I'm sorry sir, I just wanted to say 'hi'...] -> say_hi
* [!FN(has_item, Apple) Would you like an apple?] -> apple
* {apple} [!FN(has_item, Apple) It's fine. Here, take it.] -> give_apple
* {CHOICE_COUNT() == 0 and give_apple}[{memory_option_string}] -> memory
* _p_ -> start

= mean
Hey! Who is disturbing who here, huh?! Just leave me alone!
-> options

= say_hi
{not apple: Well, hi. Are you done? Then go!}
{apple: No, no... I should be the one apologizing...}
-> options

= apple
What am I supp... An apple? B-but it's yours. 
Aren't you hungry?
-> options

= give_apple
!FN(remove_item, Apple)
!FN(unlock_a, good_heart)
T-thank you... I'm sorry I yelled at you... 
You have a good heart. It's just that...
...
Tough life makes you hard as a rock, kiddo. 
But sometimes there are people who can crack your shell, hehe...
-> options

= memory
!FL(destroy_npc)
( I have seen you almost every day back then
and I don't even know your name. )
* _p_ -> start