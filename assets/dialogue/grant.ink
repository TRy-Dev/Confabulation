=== grant
= start
{not options: {player_name}! You won't believe what I've found! Look! A dinosaur bone!}
{options: {~Hi|Hey|} {player_name}!}
-> options

= options
* {not give_bone} [Wow! Let me see it!] -> see_bone
* [Where did you find it?] -> where_bone
* {not give_bone} [!FN(has_item, Fishbone) I have this RARE WHOLE fishbonesaurus skeleton here.<br>Would you like to trade your bone for it?] -> trade_bone 
+ {(see_bone or where_bone) and not give_bone and not quiz_wrong and not tomorrow_bone} [Can I have it? I LOVE dinosaurs too!] -> have_bone
* {tomorrow_bone and not give_bone} [All right, time's up. Give me the bone] -> give_bone
* {CHOICE_COUNT() == 0 and give_bone}[{memory_option_string}] -> memory
* _p_ -> start

= see_bone
( The boy proudly displays what seems to be an old chicken thigh bone. 
You can smell the stench as he comes closer, grinning )
-> options

= where_bone
I have discovered this priceless fossil 
during excavation in the sandpit on school playground.
-> options

= trade_bone
!FN(remove_item, Fishbone)
!FN(unlock_a, trader)
Fishbonesaurus? Hmm... I think I've read about it somewhere...
Sure, I'll trade you.
-> give_bone

= have_bone
{not quiz_later: Oh really...? Then you must know a lot about dinosaurs... Let me ask you three simple questions that every aspiring paleontologist should have no problem answering.}
{quiz_later: Answer three questions and I'll give it to you.}
* [Ask away.] -> quiz
+ [Maybe later...] -> quiz_later

= quiz_later
Sure...
-> options

= quiz
All right... Let's see... <>
-> quiz_q1

= quiz_q1
!FL(noExit)
First question...
As you probably know dinosaurs went extinct during Cretaceous–Paleogene extinction event. 
When did this event occur?
* [2000 years ago] -> quiz_wrong
* [last friday] -> quiz_wrong
* [221 million years ago] -> quiz_wrong
* [66 million years ago] That's correct! -> quiz_q2

= quiz_q2
!FL(noExit)
All right, next question...
Which currently living animals are the descendants of dinosaurs?
* [Lizards] -> quiz_wrong
* [Birds] Correct again! -> quiz_q3
* [Humans] -> quiz_wrong
* [Mosquitoes] -> quiz_wrong

= quiz_q3
!FL(noExit)
And the last question is...
What is the largest known dinosaur?
* [Argentinosaurus] -> quiz_won
* [Tyrannosaurus rex] -> quiz_wrong
* [Megazord] -> quiz_wrong
* [Stegosaurus] -> quiz_wrong

= quiz_wrong
Haha, that's so WRONG! How could you not know that?!
Sorry, I can't let you have the bone.
->options

= quiz_won
!FN(unlock_a, quiz_won)
Wow, you really know this stuff... 
Um... Listen... I know I promised, but can I give you this bone tomorrow? 
I just found it and I would like to study it a bit more...
* [No way! A deal's a deal. Now give me my reward.] -> give_bone
* [Ehh... ok, fine. But I need this bone tomorrow!] -> tomorrow_bone

= give_bone
!FN(add_item, Bone)
Ok... But PLEASE be careful... it's a very rare fossil...
-> options

= tomorrow_bone
Thank you, thank you, thank you! 
Come back tomorrow and it's yours, I promise!
-> options

= memory
!FL(destroy_npc)
( I always admired your passion and hard work. 
Unfortunately, you were also trusting and kind. 
Many people took advantage of that. )
* _p_ -> start
