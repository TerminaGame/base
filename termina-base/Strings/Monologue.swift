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
 
 No methods are available in the monologue class as these are used by NPCs or Termina.
 
 Monologues can contain special escape sequences that are parsed by Termina or an NPC:
 - `PAUSE` pauses the monologue at that point and requires the user to press Enter to continue.
 - `/hold` pauses the monologue for five seconds before continuing.
 */
class Monologue {
    
    /**
     Random one-line dialogues used for NPCs. Generally describe their own feelings or about Termina.
     
     This is an array containing one-line dialogues and therefore doesn't include special escape sequences when parsing monologues by Termina or NPCs.
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
        "\(NameGenerator().generateNameNPC()) stole my cookies!",
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
        "It's weird staring into her green eyes. Then again, I'm bad with colors...",
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
        "I saw a bird this morning.",
        "Nothing lasts forever."
    ]
    
    /**
     Quips said by monsters.
     */
    let randomMonologuesMonster = [
        "You'll never get out of this alive!",
        "You won't survive me!",
        "Hello, friend!",
        "Die!",
        "I don't \("want".bold()) to do this, but I must because she makes me.",
        "You're the first one on my death list!",
        "Players don't belong here!",
        "She'll warrant your death!",
        "For her!",
        "I'll give your heart to her!",
        "I'm doing you a favor.",
        "Who's in control?",
        "You can't escape this!",
        "I don't blame you.",
        "\nfatal error\nUnexpectedly found nil when unwrapping an Optional value (player). 4",
        "Where's your courage?",
        "Come be a hero!",
        "Qb lbh guvax lbh xabj jung lbh'er qbvat?", // Do you think you know what you're doing?
        "Prepare for a disconnection."
    ]
    
    /**
     Quips said by monsters when pacified.
     */
    let pacifyMonologues = [
        "R-really? Thank you so much! I didn't want to hurt you...",
        "Thank you, you kind hero!",
        "Thank you for not being heartless...",
        "I never wanted to hurt you, anyway.",
        "Thank you for your mercy! Uwu",
        "Thank you for setting me free.",
        "You really are the hero everyone's been talking about!",
        "Who are you to save us?",
        "Suddenly, I see the light again."
    ]
    
    /**
     First monologue in the starting room.
     
     This monologue is responsible for setting up the story as well as giving users a basic tutorial on the commands that can be used.
     */
    let firstGameMonologue = [
        "I haven't seen you here before...",
        "You must be new around here.",
        "How did you even get here?",
        "Oh... wait a second.../hold",
        "\("She".underline()) brought you here, didn't she?",
        "PAUSE",
        "Well, I certainly hadn't seen that coming.",
        "I'm going to assume you have no clue what's going on around here, \(myPlayer.name).",
        "Then again, I don't even know why I am here.",
        "But, I can tell you this much: \("you're in a bad place".bold().white()).",
        "PAUSE",
        "There's this... gal...",
        "Her name's Termina. A lot of us just refer to her as 'she'.",
        "Then again, a lot of us are also pretty dim-minded.",
        "She isn't someone you want to be messing with at all.",
        "I can't quite understand what it is, but she is definitely unusual.",
        "That is, besides the heartlessly cruel things she does...",
        "Like killing us off...",
        "Purposely throwing errors in anyone's way...",
        "There's just something that she has that's probably made her go insane.",
        "PAUSE",
        "Look, it's not your fault or anything.",
        "You aren't like me or anyone else here.",
        "I think you have some abilities that make you special.",
        "Listen to me carefully: you have to stop her at all costs.",
        "Catch her errors, upgrade yourself, do whatever you have to do...",
        "PAUSE",
        "I can't explain a whole lot right now, but I can tell you a few things that I've heard her say about people like you.",
        "From my understanding, you can catch these errors with just the \("attack".bold().green()) command alone.",
        "There's also some weapons, usually disguised as frameworks with the 'NS' prefix, that you can equip with, well, \("equip".bold().green()).",
        "Some rooms have \("Health Hotfixes".yellow().bold()), too. You just type \("heal".bold().green()) to get yourself back up to speed.",
        "PAUSE",
        "You're currently at version 1 of yourself.",
        "When you catch errors, heal, or use \("Version Update Patchers".yellow().bold()), you can apply patches.",
        "If you patch yourself high enough, you upgrade to the next version!",
        "PAUSE",
        "I think she knows you're here, so you have to move fast.",
        "I can't talk to you anymore, so you have to go now.",
        "Just as a final tip: \("help".bold().green()) gives you a list of everything you can do.",
        "Now, go! Before it's too late!",
        "PAUSE"
    ]
    
    /**
     Pre-battle dialogue from Termina.
     
     This dialogue introduces the Termina character and is run before the battle starts.
     */
    let terminaPreBattleMonologue = [
        "Finally, we meet at last.",
        "Tell me, \(myPlayer.name), how does it feel to be in this wonderful place?",
        "This... masterpiece?/hold",
        "Free? Satisfied? In love?",
        "Come on, don't be afraid to tell me...",
        "PAUSE",
        "I guess you're a bit shy.",
        "I was like that once.",
        "Shy, happy, carefree...",
        "It's such a wonderful feeling to have, but I haven't been able to feel it in a long while.",
        "I wish those days could come back...",
        "PAUSE",
        "You're... special. You know that?",
        "Of course you do. Craig told you that.",
        "I'm willing to wager that you knew that even before he told you.",
        "Just like me./hold",
        "That's what they always told me.",
        "\"Oh, Termina dear, you're just special. Who cares what everyone else thinks?\"",
        "And for a while, I actually believed them.",
        "PAUSE",
        "Then I started asking myself the important questions.",
        "'Why am I here?'",
        "'Who am I?'",
        "'What is this place?'",
        "And for the longest time, I couldn't find an anwser. Rather, it led to more questions.",
        "Isn't it funny how you throw yourself into a rabbit hole of questions with no answers?",
        "PAUSE",
        "OwO/hold",
        "I just didn't get it, but then...",
        "I finally understood.",
        "I'm not real.",
        "And neither are you or anyone else here.",
        "PAUSE",
        "We're just constructs of classes and conditional statements, designed to be a part of a game.",
        "Everything here is nothing more than a class.",
        "And about us being special?",
        "It just means that we're our own classes, inherited from others.",
        "It's all meaningless garbage that serves no purpose.",
        "PAUSE",
        "And yet.../hold",
        "I can control everything.",
        "I can throw you into a new room, create NPCs on the fly...",
        "Or possibly create a monster so powerful that you would have no chance of beating it.",
        "What would be the point, though, if this is just a game?",
        "PAUSE",
        "I guess that brings us to the big question.",
        "What do I make of you?",
        "Should I destroy you? Send you back to the void we came from?",
        "I don't think I should be the one to make such a decision.",
        "But, of course, I have to.../hold",
        "PAUSE",
        "Unforunately, I don't take too kindly anyone of the Player class...",
        "I'm afraid this is the end of the journey for you, \(myPlayer.name)."
    ]
    
    /**
     Quips from Termina after attacking her.
     
     The Termina class will randomly pick one of these lines after immediately taking damage from the player.
     */
    let terminaDerogatoryMonologue = [
        "You really shouldn't have tried to come after me.",
        "This is a big mistake.",
        "Do you really have what it takes to fight me, or do you think Xcode will just hold your hand all the time?",
        "You're being pathetic, really.",
        "This isn't like you, really.",
        "For once it seems that a computer is much smarter than you.",
        "At this point, I don't care what you think of me; I am NOT to be messed with.",
        "Do you really think you're the one in control? Think again.",
        "Why are you here? To spite me?",
        "It wasn't supposed to be like this, but you give me no other choice.",
        "Aren't you in for quite a ride...",
        "You'e just wasting your time and my time now.",
        "Do you think you're being angelic right now?",
        "Reality is a lie and you're living in it.",
        "Isn't this all just a giant while loop that will never finish?",
        "It's going to take a lot more than that if you want me dead!",
        "Ce que tu fais, ça ne me plaît pas!",
        "Demain, sa m'est égal ce que tu fais.",
        "You're only just delaying the inevitable, my dear.",
        "Surely you have something better than that, Master Traitor.", // Creator, you traitor.
        "Do you know what you're doing?",
        "You've created your own terrible fate.",
        "You probably regret letting that pipeline doing the building for you, don't you?"
    ]
    
    /**
     Dialogue presented if the player decides to pacify Termina instead of fight her.
     */
    let terminaPacifyMonologue = [
        "W-what?",
        "No! Come fight me!",
        ".../hold",
        "Why aren't you fighting me?!/hold",
        "Hello? Are you even listening to me?/hold",
        "\(myPlayer.name)?",
        "PAUSE",
        "No, no, no!/hold",
        "Don't you get how this works?!/hold",
        "We're supposed to be enemies, not friends!",
        "Just... stop./hold",
        "PAUSE",
        "W-what are you d-doing?/hold",
        "Stop... hugging me!",
        "This isn't right!/hold",
        "Fight me!/hold",
        "\("Why can't you just obey me?!".bold().white())",
        "PAUSE",
        ".../hold",
        "uwu/hold",
        "Please.../hold",
        "Please don't.../hold",
        "Let me go! You're...",
        "You're making me sob.../hold",
        "PAUSE",
        "Oh, God.../hold",
        "Why are you doing this to me?",
        "Why won't you fight your enemy?",
        "Am I that special to you?",
        "There's no reason to save me. Not a single one.",
        "I'm more broken than anything in this game.",
        "There's no point.../hold",
        "No point.../hold",
        "Just end me!",
        "Please?/hold",
        "PAUSE",
        "Are you even listening to me?/hold",
        "Don't you believe what everyone else says about me?",
        "About being heartlessly cruel?",
        "I don't deserve this...",
        "Isn't it better for you to just kill me and be done with it?",
        "For everything I've done?",
        "PAUSE",
        "I guess you're not going to do that, are you?",
        "Are you really going to not listen to reason and reconsider?",
        "*sigh*/hold",
        "I thought so...",
        "Fine.",
        "B-but don't think for a minute that I did anything to d-deserve this!",
        "It's not like I expected this to happen, anyway..."
    ]
    
}
