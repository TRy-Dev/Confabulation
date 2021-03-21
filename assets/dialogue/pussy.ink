=== pussy
= start
{fish: Purrr...}
{not fish: Hiss!}
-> options

= options
* [(Hiss back)] -> hiss
+ [Meow] -> meow
+ [(Try to pick her up)] -> pick_up
* [!FN(has_item, Fish) Here, have this fish.] -> fish
* _p_ -> start

= hiss
...
-> options

= meow
{~Meow!|Meow?|...}
-> options

= pick_up
{fish: !FN(add_item, Pussy)}
{fish: !FL(destroy_npc)}
{fish: ( You pick up the cat )}
{not fish: ( {&The cat tries to bite you|As you approach, you can see her claws comming out, better to back off|HISS!!!} )}
-> options

= fish
!FN(add_item, Fishbone)
!FN(remove_item, Fish)
( Cat lunges towards you and, before you have time to react, the fish is no more.
All you are left with is a clean fish skeleton. )
Purrr...
-> options
