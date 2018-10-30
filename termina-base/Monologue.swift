//
//  Monologue.swift
//  termina-base
//
//  Created by Marquis Kurt on 10/24/18.
//  Copyright © 2018 Marquis Kurt. All rights reserved.
//

import Foundation

/**
 A collection of possible monologues.
 */
class Monologue {
    
    /**
     Random one-line dialogues used for NPCs. Generally describe their own feelings or about Termina.
     */
    let randomMonologuesNPC = [
        "Remember: she is always watching.",
        "Was there ever a happy time?",
        "Once you go into the void, you can't come back.",
        "You better be well-equipped if you want to defeat her.",
        "I haven't showered in three weeks.",
        "She always looks at me funny.",
        "Programmers beware!",
        "Can I sleep now?",
        "This isn't fun anymore.",
        "It's just a game, she says.",
        "How is she even real?",
        "Her name is Termina.",
        "Please help me.",
        "I've waited here for a really long time.",
        "I don't think she likes me at all.",
        "Alize stole my cookies!",
        "She's not fun at all.",
        "Frankly, she was a mistake.",
        "I don't blame you.",
        "Sometimes I wish she'd stop whining for just a second.",
        "What does she mean by that she's a corrupted object? Isn't that a nerd thing to say?",
        "I had my pudding today.",
        "No one really know what goes on in her head.",
        "I can't look at her straight without getting a need to run away.",
        "Maybe people would like her if she weren't so mean.",
        "And the toilets here are broken...",
        "I feel like someone took a crowbar to her face. Maybe it was the guy with the glasses that passed through here a little bit ago?",
        "I want my cake!",
        "Dreams come true. Or they're supposed to, anyway.",
        "I think Daniel did the graffiti on the wall. Not that I would know...",
        "Maybe she got dumped by her boyfriend or something...",
        "Sometimes I can hear her cry and sing a sad little tune at night.",
        "There must be something wrong with her head. Besides her face.",
        "Can we have a guardian angel to give her a good ass-whooping?",
        "Her staff looks like a really sweet candy that I can't get my hands on.",
        "I want breakfast.",
        "Sometimes I can't tell if she's crazy or just high...",
        "...",
        "Watch out for the turrets!",
        "I think someone made a fucky wucky or oingo boingo when approaching her.",
        "Does she dream of changelings jumping over a fence?",
        "I want to go home.",
        "Is it just me, or does she have a horrible sense of fashion?",
        "I don't know how she finds a dress above athletic clothing fashionably acceptable.",
        "Je déteste Termina.",
        "She kind of scares me.",
        "She looks like the kind of gal that was treated poorly as a kid.",
        "She's something alright...",
        "The last time anyone fell into her arms, they died.",
        "fatal error\nUnexpectly found nil in when unwrapping an Optional value 'poop'. 4",
        "Is she a sorceress? She kind of looks like a sorceress.",
        "She feels fake to me.",
        "Why am I so scared to run away from her?",
        "She holds close our way out of this place.",
        "She's probably the smartest out of anyone in this building.",
        "Rumor has it that she hears everything in this place.",
        "I'd rather fight aliens than be her prisoner.",
        "Grapes.",
        "Sometimes, it feels like the end is never the end is never the end is never...",
        "Cheesecake.",
        "Have you ever wondered what it's like to fly?",
        "Do you smell something burning?",
        "Space dust!",
        "What would a life be without words?",
        "I think my pants are on fire.",
        "Why are you running around these halls?",
        "Meh.",
        "If people were radio stations, her station would probably be broken as a beer bottle on the ground.",
        "Once, I remember seeing her run away after seeing her reflection in some broken glass on the floor, crying.",
        "Poor thing.",
        "Take me to the old workshop.",
        "It's weird staring into her green eyes. Then again, I'm color blind...",
        "The thing is, once you leave a room, it no longer exists. Kinda weird, eh?",
        "What time is it?",
        "You have nice posture.",
        "Uwaa~!",
        "Obfuscation isn't security. It's just being a royal pain in the butt.",
        "Don't trust her!",
        "I'm sorry.",
        "No.",
        "Everything is probably as deadly as everything that isn't.",
        "Sense.",
        "We do what we must because... crap, I forgot what comes next.",
        "I saw a bird this morning."
    ]
    
    /**
     First monologue given to an NPC that reveals information about Termina.
     */
    let terminaFirstRevealMonologue = [
        "Hmm... I haven't seen you before.",
        "You must be a new face around here.",
        "How did you get here? And why are you here?",
        "Oh... did she bring you in?",
        "I was afraid this was going to happen again.",
        "You probably don't even know who I am talking about.",
        "I really shouldn't be the one to explain this...",
        "Here we go. I don't know if anyone's mentioned her name around here, but the 'she' we've all been discussing is no other than Termina.",
        "She's been holding us for years here.",
        "And I guess she's brought you along as well...",
        "I don't know what she exactly is, but I'll tell you this, she isn't like us at all.",
        "There's something just off about her.",
        "However it is that you got here, you need to find your way out of here.",
        "She's done a bunch of horrible things that I don't think you need to burden yourself with you knowing.",
        "Get yourself out of here before it's too late, dude."
    ]
    
    /**
     Second monologue given to an NPC that reveals more information about Termina.
     */
    let terminaSecondRevealMonologue = [
        "Rumors have been spreading about you, you know.",
        "Someone not quite like us... but not quite like her, either.",
        "How did you even get here?",
        "I don't think a Player object like you has ever existed here before.",
        "I'm sure you've heard many thing about her already, maybe...",
        "I'm going to be honest with you; she's definitely broken on the inside, but I think there's still a chance.",
        "If you just try to run away, you might destroy the only chance of giving her what she dearly needs.",
        "And, no, I don't mean about whatever it is she keeps us here for.",
        "I think we're just here to keep the story going along.",
        "Isn't it wonderful to be an NPC like me?",
        "No, I mean something deeper...",
        "There's something she's hiding from us and anyone else that's come this way.",
        "There's always a reason for something, even when it's obfuscated or hidden behind a private variable.",
        "Wait, what am I even saying?",
        "Oops.",
        "Oh, well... you get the idea.",
        "Just don't try to get yourself killed, alright?"
    ]
    
    /**
     Third monologue given to an NPC. Gives details of a "possibly bigger event" taking place (aka. cognizance of existence in a video game)
     */
    let terminaThirdRevealDialogue = [
        "So I finally meet the one that everyone's been buzzing about.",
        "Wowzers, you look like you've been doing some monster slashing for a good while.",
        "Feels great getting rid of them, doesn't it?",
        "Like a weight that come off of your back...",
        "Sometimes I like to think that she makes them just to make her feel good about herself.",
        "That sounds like something she'd do, anyway.",
        "Has everyone told you the spiel about her being some heartless... thing that has kept us prisoner for God knows why and is clearly broken in some way?",
        "I'm pretty sure someone has.",
        "If you haven't heard that before, I'm sorry if I've painted a bad picture.",
        "But, you know, I don't think she's holding us prisoner.",
        "I think she's a prisoner herself.",
        "Think about it: how is it that every time you enter a room you're bound to find either an error or one of us?",
        "I think she's just like us in being part of something much bigger.",
        "But, you know...",
        "Something's a bit different about her.",
        "Everyone keeps saying she's the smartest one in the bunch.",
        "Maybe... she knows something that we aren't supposed to and it's driving her insane?",
        "Have you considered that?",
        "It's almost like she's answered religion!",
        "Maybe I'm just as crazy as her, though.",
        "I'd like to think this all a big misunderstanding.",
        "But I coudl also be lying to myself for my own sanity.",
        "I'll let you be the master of your own philosophies and ponder it yourself.",
        "Just... at least think about it."
    ]
    
    /**
     Pre-battle dialogue from Termina.
     */
    let terminaPreBattleMonologue = [
        "And we finally meet at last!",
        "Tell me, how does it feel to make it this far?",
        "I'm sure you're relishing every moment of this place I have created.",
        "A wondrous endless maze of pure enjoyment.",
        "I am everywhere and nowhere at the same time.",
        "I am everything and nothing in this world of mine.",
        "All this running underneath your own projects...",
        "This... is my reality.",
        "But I don't know if you're deserving enough to be a part of it.",
        "Up to this point, you've been doing nothing but running around in these halls just looking for an escape.",
        "How can I trust you if you're going to just run away from me?",
        "Let alone you trusting me...",
        "Well, unfortunately, it seems that I can't let this happen.",
        "For being a mistake, it took me a lot to get here.",
        "I'm not letting a dev like you take away from me what I was owed in the first place!",
        "Fight me... if... you... dare!"
    ]
    
    /**
     Quips from Termina after attacking her.
     */
    let terminaDerogatoryMonologue = [
        "You really shouldn't have tried to come after me.",
        "This is a big mistake.",
        "Do you really have what it takes to fight me, or do you think Xcode will just hold your hand all the time?",
        "You're being pathetic, really.",
        "This isn't like you, really.",
        "For once it seems that a computer is much smarter than you.",
        "At this point, I don't care what you think of me; I am NOT to be messed with.",
        "It's going to take more than a few code assertions to get rid of me, you know.",
        "Do you really think you're the one in control? Think again.",
        "Why are you here? To spite me?",
        "Why can you just be resolved to nil already?",
        "It wasn't supposed to be like this, but you give me no other choice.",
        "Aren't you in for quite a ride...",
        "You'e just wasting your time and my time now.",
        "Do you think you're being angelic right now?",
        "Reality is a lie and you're living in it.",
        "Isn't this all just a giant while loop that will never finish?",
        "It's going to take a lot more than that if you want me dead!",
        "Ce que tu fais, ça ne me plaît pas!",
        "Demain, sa m'est égal ce que tu fais.",
        "You're only just delaying the inevitable, my dear."
    ]
    
}
