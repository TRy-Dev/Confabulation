=== mother
= start
{~Hi|Hello} {~{player_name}|darling|honey}.
{not ready: School starts in one hour. Are you packed and ready?}
-> options

= options
* [Packed and ready!] -> ready
* [What's for dinner today?] -> dinner
* {dinner} [!FN(has_item, Oregano) Try adding some oregano!] -> oregano
* {CHOICE_COUNT() == 0 and oregano}[{memory_option_string}] -> memory
* _p_ -> start

= ready
!FN(add_item, Apple)
Good. I don't want to hear from {teacher_name} that you were late again. 
Here's your breakfast, now off you go!
-> options

= dinner
Spaghetti. Here, taste it.
(It tastes good, but you have a feeling that something is missing...)
-> options

= oregano
!FN(remove_item, Oregano)
!FN(unlock_a, Oregano)
Yes, that's it! Thank you, dear!
-> options

= memory
!FL(destroy_npc)
( I wish we'd spent more time together. )
* _p_ -> start