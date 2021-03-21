=== benjamin
= start
Woof woof. 
( Hello. My name is Benjamin, but everyone calls me Charlie for some reason. )
-> options

= options
* [!FN(has_item, Bone) I have this bone I thought...] -> give_bone
* [Hey Benjamin!] -> hey_benjamin
* [Can you let me in, please?] -> let_in
* [Who's a good boi?] -> good_boi
* {CHOICE_COUNT() == 0 and give_bone}[{memory_option_string}] -> memory
* _p_ -> start

= hey_benjamin
Woof woof!
( Finally someone who listens to me! How can I help you, little person? )
-> options

= let_in
Woof!
( I'm sorry, but the lady ordered me to protect the garden.
And I'm very diligent. 
There's NOTHING that will make me leave my post.
Also, she gives me food. I LOVE food! ) 
Woof!
-> options

= give_bone
!FN(remove_item, Bone)
!FN(unlock_a, dog_bone)
( Before you have a chance to finish the sentence, 
the dog starts wagging it's tail furiously with excitement.
He catches the bone mid-air and starts gnawing at it.
His tail, still moving, created a thick dust cloud around him )
-> options

= good_boi
( Boi? Who? You? Me? ...
Yes! Me! I'm a good boi! )
Woof! Woof!
-> options

= memory
!FL(destroy_npc)
( I remember playing with you in the summer. 
Thank you for protecting me from that man. 
If only they'd believe me... )
* _p_ -> start