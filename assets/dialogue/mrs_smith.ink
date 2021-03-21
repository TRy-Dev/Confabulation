=== mrs_smith
= start
{not found_pussy: Pussy! Pussy! Where are you? Pussyyyy!}
{found_pussy: {You smell terrible! I'll have to give you a bath...|Tell mommy where you've been...}}
-> options

= options
* [Hello mrs. Smith.] -> hello
* {not found_pussy} [What happened to Pussy?] -> what_pussy
* {not found_pussy and what_pussy} [I don't know... I need to go to school.] -> school
* {not found_pussy and school} [If you know where she is why don't you go yourself?] -> go_yourself
* {what_pussy and not found_pussy and pussy.pick_up} [No way! Last time I tried to pet her she bit me!] -> bite
* [!FN(has_item, Pussy) Look who I've found!] -> found_pussy
* {CHOICE_COUNT() == 0 and found_pussy}[{memory_option_string}] -> memory
* _p_ -> start

= hello
Aaaa!! Oh... huh... it's you... 
Don't scare me like that!
I'm old, you know...
-> options

= what_pussy
I don't know... I can't find her anywhere. 
Could you do me a favour and look for her?
-> options

= school
There's plenty of time before school starts!
Besides, she often wanders in this direction, 
so if you see her, just bring her here, ok?
-> options

= go_yourself
And leave my garden unattended?
Last time I went for a walk for 10 minutes 
and someone stole my precious herbs!
-> options

= bite
Haha! She must have been hungry.
Give her something to eat and you won't get rid of her,
even if you'd like to, haha.
-> options

= found_pussy
!FN(remove_item, Pussy)
!FN(unlock_a, pussy)
Pussy! There you are my love, come here!
Where have you been, huh? 
( She seems to have forgotten you are here )
You can't do this to me, I was so worried!
Come, let's have something to eat.
* [Umm...] -> im_still_here
-> options

= im_still_here
Oh! Yes, thank you child.
If you'd like, you can have something from my garden as a reward.
... Come, my dear. Let's take care of you.
-> options

= memory
!FL(destroy_npc)
( There was a rumour that Pussy ate your face 
before someone found you dead on your couch. 
But cats don't really do that, right? )
* _p_ -> start
