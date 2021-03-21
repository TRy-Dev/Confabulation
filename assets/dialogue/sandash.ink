var 


=== sandash
= start
{silent: Hello {~young Sardine|little Carp| tiny Trout}}
{not silent: {&Ssshhh...|Be quiet...}}
-> options

= options
+ {not silent} [Aren't you cold?] -> cold
+ {not silent} [I don't like fish. It smells bad. Do you like fish?] -> like_fish
* {silent} [Aren't you cold?] -> cold
* {silent} [I don't like fish. It smells bad. Do you like fish?] -> like_fish
* [(Remain silent)] -> silent
* {silent} [!FN(has_item, Worm) I have found this worm. Would you like it?] -> worm
* {worm} [I found it under a tree bark] -> dirt
* {CHOICE_COUNT() == 0 and dirt}[{memory_option_string}] -> memory
* _p_ -> start

= cold
{not silent: ( The man looks at you. You have never seen more disappointed face in your life )}
{silent: Any respectable ice-fisherman knows how to dress properly for cold weather. And I consider myself one.}
-> options

= like_fish
{not silent: ( The man looks at you. You have never seen more disappointed face in your life )}
{silent: Of course I do! And you should eat fish too! Fish is a low-fat high quality protein. Fish is filled with omega-3 fatty acids and vitamins such as D and B2. Fish is rich in calcium and phosphorus and a great source of minerals, such as iron, zinc, iodine, magnesium, and potassium.}
-> options

= silent
{not cold and not like_fish: !FN(unlock_a, patient)}
( After what seems like 10 hours of staring at the water the man looks at you )
I see you have respect for the art of fishing. 
With that, you have gained my respect. 
How can I help you?
-> options

= worm
!FN(remove_item, Worm)
Let me see that... 
Waxworm in the middle of winter? 
And so fresh and meaty... Where did you get that?
-> options

= dirt
!FN(add_item, Fish)
In the middle of winter?! Haha, you are funny, {~young Sardine|little Carp| tiny Trout}. 
All right, keep your secrets...
Here, take this fish as a token of gratitude. 
May it's meat be boneless and keep you healthy this harsh winter.
-> options

= memory
!FL(destroy_npc)
( I always thought you would drown and freeze to death 
when I saw you on the ice.
But you loved fishing and knew what you were doing. 
Seems like you loved it more than your family. )
* _p_ -> start